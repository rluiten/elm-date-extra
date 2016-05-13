module Date.Extra.Duration exposing
  ( add
  , Duration (..)
  )

{-| A Duration is a length of time that may vary with with calendar date
and time. It can be used to modify a date.

When modify dates using Durations (Day | Month | Week | Year) this module
compensates for day light saving hour variations to minimise the scenarios
that cause the Hour field in the result to be different to the input date.
It can't completely avoid the hour changing as some hours are not a real
world date and hence will modify the hour more than the Duration modified.

This behaviour is modelled on momentjs so any observed behaviour that is
not the same as momentjs should be raised as in issue.

Note adding or subtracting 24 * Hour units from a date may produce a
different answer to adding or subtracting a Day if day light saving
transitions occur as part of the date change.

@docs add
@docs Duration

Copyright (c) 2016 Robin Luiten
-}

import Date exposing (Date, Month)

-- import Date.Extra.Calendar as Calendar
import Date.Extra.Core as Core
import Date.Extra.Create as Create
import Date.Extra.Format as Format
import Date.Extra.Internal as Internal
import Date.Extra.Period as Period


{-| A Duration is time period that may vary with with calendar and time.

Using `Duration` adding 24 hours can produce different result to adding 1 day.

-}
type Duration
  = Millisecond
  | Second
  | Minute
  | Hour
  | Day
  | Week
  | Month
  | Year
  -- | Combo {year,month,week,day,hour,min,sec,millisecond}
  -- DateDiff could return a Duration with fields set


{- Return true if this Duration unit compensates for crossing daylight saving
boundaries.
-}
requireDaylightCompensateInAdd : Duration -> Bool
requireDaylightCompensateInAdd duration =
  case duration of
    Millisecond -> False
    Second -> False
    Minute -> False
    Hour -> False
    Day -> True
    Week -> True
    Month -> True
    Year -> True


{-| Add duration * count to date. -}
add : Duration -> Int -> Date -> Date
add duration addend date =
  let
    -- _ = Debug.log "add" (duration, addend)
    outputDate = doAdd duration addend date
  in
    if requireDaylightCompensateInAdd duration then
      daylightOffsetCompensate date outputDate
    else
      outputDate


doAdd : Duration -> Int -> Date -> Date
doAdd duration =
  case duration of
    Millisecond -> Period.add Period.Millisecond
    Second -> Period.add Period.Second
    Minute -> Period.add Period.Minute
    Hour -> Period.add Period.Hour
    Day -> Period.add Period.Day
    Week -> Period.add Period.Week
    Month -> addMonth
    Year -> addYear


daylightOffsetCompensate : Date -> Date -> Date
daylightOffsetCompensate dateBefore dateAfter =
  let
    offsetBefore = Create.getTimezoneOffset dateBefore
    offsetAfter = Create.getTimezoneOffset dateAfter
    -- _ = Debug.log "daylightOffsetCompensate"
    --   (offsetBefore, offsetAfter, (offsetAfter - offsetBefore)
    --   , Format.isoString dateAfter
    --   , Format.isoString
    --     ( Period.add
    --         Period.Millisecond
    --         ((offsetAfter - offsetBefore) * Core.ticksAMinute) dateAfter
    --     )
    --   )
  in
    -- this 'fix' can only happen if the date isnt allready shifted ?
    if offsetBefore /= offsetAfter then
      let
        adjustedDate =
          Period.add
            Period.Millisecond
            ((offsetAfter - offsetBefore) * Core.ticksAMinute) dateAfter
        adjustedOffset = Create.getTimezoneOffset adjustedDate
      in
        -- our timezone difference compensation caused us to leave the
        -- the after time zone this indicates we are falling in a place
        -- that is shifted by daylight saving so do not compensate
        if adjustedOffset /= offsetAfter then
          dateAfter
        else
          adjustedDate
    else
      dateAfter


{- Return a date with month count added to date.

New version leveraging daysFromCivil does not loop
over months so faster and only compensates at outer
level for DST.

Expects input in local time zone.
Return is in local time zone.
-}
addMonth : Int -> Date -> Date
addMonth monthCount date =
  let
    year = Date.year date
    monthInt = Core.monthToInt (Date.month date)
    day = Date.day date
    inputCivil = Internal.daysFromCivil year monthInt day
    newMonthInt = monthInt + monthCount
    targetMonthInt = newMonthInt % 12
    yearOffset =
      if newMonthInt < 0 then
        (newMonthInt // 12) - 1 -- one extra year than the negative modulus
      else
        newMonthInt // 12
    newYear = year + yearOffset
    newDay = min (Core.daysInMonth newYear (Core.intToMonth newMonthInt)) day
    -- _ = Debug.log "addMonth a" ((year, monthInt, day)
    --     , "yearOffset", yearOffset, newMonthInt
    --     , "a", (newYear, targetMonthInt, newDay))
    newCivil = Internal.daysFromCivil newYear targetMonthInt newDay
    daysDifferent = newCivil - inputCivil
    -- _ = Debug.log "addMonth b" (newCivil, inputCivil, newCivil - inputCivil)
  in
    Period.add Period.Day daysDifferent date


-- todo use civil days ?
{- Return a date with year count added to date.
TODO this is inefficient, as adding larger numbers of years loops a lot.
-}
addYear : Int -> Date -> Date
addYear yearCount date  =
  addMonth (12 * yearCount) date
