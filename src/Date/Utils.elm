module Date.Utils where

{-| Date Utils.

`isoWeek` is only defined for Monday as start of week.
Therefore we don't support isoWeek in calendar if  you pick
Sunday as first day of week in your options.


In the spirit of NodaTime and JodaTime, moment ? though not as complete

Specifically a bunch of ISO 8601 calendar date useful stuff.
No other callendar is supported at the moment.

Currently does not consider time zones at all, no day
light saving support.

If you are familiar with JodaTime or NodaTime this currently deals
with dates and times that can be considered of type Instant.

REFERENCE

Representation of dates and times is an international standard covering
"ISO 8601 Data elements and interchange formats – Information interchange –
the exchange of date and time-related data."

https://en.wikipedia.org/wiki/ISO_8601


Unix epoch of (ISO) January 1st 1970, midnight, UTC.


## Date parsing
@docs fromString
**Be careful with this one will Debug.crash() if you feed it wrong**
@docs unsafeFromString

## Create Date
@docs getFirstOfMonth

## Modify Date
@docs addDays
@docs addMonths
@docs firstOfMonthDate
@docs lastOfMonthDate
@docs lastOfprevMonthDate
@docs firstOfNextMonthDate

## Utility
@docs daysInPrevMonth
@docs daysInNextMonth
@docs daysBackToStartOfWeek
@docs dayList
@docs isoWeek

## Extract fields
@docs monthInt
@docs isoDayOfWeek

## Date scaling
@docs DateScale
@docs scaleDate

## Not implemented yet
@docs dateDiff

## Date Comparison
@docs DateComparison2
@docs DateComparison3
@docs is
@docs is3

----
Elm Compiler Literal Int are 32 bit.
Elm calculation of Int is 2^53 - as per Javascript.

Javascript Maximum Integer.
http://ecma262-5.com/ELS5_HTML.htm#Section_8.5
`
Note that all the positive and negative integers whose magnitude is no
greater than 253 are representable in the Number type
(indeed, the integer 0 has two representations, +0 and −0).

9007199254740992

bitshift in js is 32 bits.
`

REMINDER https://github.com/jtobey/javascript-bignum
and it lists many others
http://www-cs-students.stanford.edu/~tjw/jsbn/

Copyright (c) 2016 Robin Luiten
-}

import Date exposing (Day (..), Date, Month (..))
import Regex
import String
import Time

import Date.Core as Core
import Date.Format as Format
import Date.StringUtils as StringUtils


-- -- useful think
-- -- from https://github.com/nodatime/nodatime/blob/master/src/NodaTime/Instant.cs
-- Instant type is based on milliseconds since X.
-- Instant does not have a callendar.
   -- need to give it one.
   -- nodatime defaults to ISO-8601 calendar.
   -- as required so assume this ? for now.
-- type MyDate
--   = Instant Float  -- dont need to be float Int works fine i use it.
--   | Offset Float Int -- Int is timezone offset in minutes
  -- | OffsetDateTime (InstantRecord, offset : Int) -- ?
  -- | ZonedDateTime (InstantRecord, timezone : TimeZone)


{-| Return days in previous calendar month. -}
daysInPrevMonth : Date -> Int
daysInPrevMonth date =
  let
    lastOfPrevMonthDateVal = lastOfPrevMonthDate date
    prevMonthYear = Date.year lastOfPrevMonthDateVal
    prevMonthMonth = Date.month lastOfPrevMonthDateVal
  in
    Core.daysInMonth prevMonthYear prevMonthMonth


{-| Return days in next calendar month. -}
daysInNextMonth : Date -> Int
daysInNextMonth date =
  let
    firstOfNextMonth = firstOfNextMonthDate date
    nextMonthYear = Date.year firstOfNextMonth
    nextMonthMonth = Date.month firstOfNextMonth
  in
    Core.daysInMonth nextMonthYear nextMonthMonth


{-| Return a date of dayCount added to date. -}
addDays : Int -> Date -> Date
addDays dayCount date =
  if dayCount == 0 then
    date
  else
    Core.fromTime ((Core.toTime date) + dayCount * Core.ticksADay)


{-| Return the date produced by adding a number of months to a date.
Adding multiple months will try to keep original starting day so adding
months crossing Feb wont clamp day at 28 (or 29 leap year).
-}
addMonths : Int -> Date -> Date
addMonths monthCount date =
  let
    goalDay = Date.day date
  in
    if monthCount == 0 then
       date
    else if monthCount > 0 then
      addMonthsPositive goalDay monthCount date
    else -- if monthCount < 0 then
      addMonthsNegative goalDay monthCount date


addMonthsPositive : Int -> Int -> Date -> Date
addMonthsPositive goalDay monthCount date =
  let
    thisMonthMaxDay = Core.daysInMonthDate date
    nextMonthMaxDay = daysInNextMonth date
    nextMonthTargetDay = min goalDay nextMonthMaxDay
    addDays = thisMonthMaxDay - (Date.day date) + nextMonthTargetDay
    -- _ = Debug.log("addMonthsPositive") (goalDay, addDays, monthCount, (Format.isoString date))
    nextMonth = Core.fromTime ((Core.toTime date) + (addDays * Core.ticksADay))
  in
    if monthCount == 0 then
      date
    else
      addMonthsPositive goalDay (monthCount - 1) nextMonth


addMonthsNegative : Int -> Int -> Date -> Date
addMonthsNegative goalDay monthCount date =
  let
    prevMonthMaxDay = daysInPrevMonth date
    prevMonthTargetDay = min goalDay prevMonthMaxDay
    addDays = -(Date.day date) - (prevMonthMaxDay - prevMonthTargetDay)
    -- _ = Debug.log("addMonthsNegative'") (goalDay, addDays, monthCount, (Format.isoString date))
    prevMonth = Core.fromTime ((Core.toTime date) + (addDays * Core.ticksADay))
  in
    if monthCount == 0 then
      date
    else
      addMonthsNegative goalDay (monthCount + 1) prevMonth


getFirstOfMonth : Int -> Month -> Date
getFirstOfMonth year month =
  let
    _ = Debug.log ("getFirstOfMonth string")
      ( Format.yearInt year ++ "-" ++ Format.monthMonth month ++ "-01T08:23:11+10:00"
      , Format.utcIsoString (unsafeFromString (Format.yearInt year ++ "-" ++ Format.monthMonth month ++ "-01T08:23:11+10:00"))
      , Format.isoString (unsafeFromString (Format.yearInt year ++ "-" ++ Format.monthMonth month ++ "-01T08:23:11+10:00"))
      )
    _ = Debug.log ("getFirstOfMonth string")
      ( Format.yearInt year ++ "-" ++ Format.monthMonth month ++ "-01T08:23:11Z"
      , Format.utcIsoString (unsafeFromString (Format.yearInt year ++ "-" ++ Format.monthMonth month ++ "-01T08:23:11Z"))
      , Format.isoString (unsafeFromString (Format.yearInt year ++ "-" ++ Format.monthMonth month ++ "-01T08:23:11Z"))
      )
    _ = Debug.log ("getFirstOfMonth string")
      ( Format.yearInt year ++ "-" ++ Format.monthMonth month ++ "-01T08:23:11"
      , Format.utcIsoString (unsafeFromString (Format.yearInt year ++ "-" ++ Format.monthMonth month ++ "-01T08:23:11"))
      , Format.isoString (unsafeFromString (Format.yearInt year ++ "-" ++ Format.monthMonth month ++ "-01T08:23:11"))
      )
  in
    unsafeFromString (Format.yearInt year ++ "-" ++ Format.monthMonth month ++ "-01")


{-| Return date of first of month. -}
firstOfMonthDate : Date -> Date
firstOfMonthDate date =
  Core.fromTime (firstOfMonthTicks date)


{- Return ticks of first of month. -}
firstOfMonthTicks : Date -> Int
firstOfMonthTicks date =
  let
    day = Date.day date
    dateTicks = Core.toTime date
    -- _ = Debug.log("firstOfMonthTicks") (day, dateTicks)
  in
    dateTicks + ((1 - day) * Core.ticksADay)


{-| Resturn date of last day of month. -}
lastOfMonthDate : Date -> Date
lastOfMonthDate date =
    Core.fromTime (lastOfMonthTicks date)


{- Return ticks of last day of month. -}
lastOfMonthTicks : Date -> Int
lastOfMonthTicks date =
  let
    year = Date.year date
    month = Date.month date
    day = Date.day date
    dateTicks = Core.toTime date
    -- _ = Debug.log("lastOfMonthTicks") (day, dateTicks)
    daysInMonthVal = Core.daysInMonth year month
    addDays = daysInMonthVal - day
  in
    dateTicks + (addDays * Core.ticksADay)


{-| Return last of previous month date. -}
lastOfPrevMonthDate : Date -> Date
lastOfPrevMonthDate date =
  Core.fromTime ((firstOfMonthTicks date) - Core.ticksADay)


{-| Return first of next month date. -}
firstOfNextMonthDate : Date -> Date
firstOfNextMonthDate date =
  Core.fromTime ((lastOfMonthTicks date) + Core.ticksADay)



{-| Days back to start of week day. -}
daysBackToStartOfWeek : Date.Day -> Date.Day -> Int
daysBackToStartOfWeek dateDay startOfWeekDay =
  let
    dateDayIndex = Core.isoDayOfWeek dateDay
    startOfWeekDayIndex = Core.isoDayOfWeek startOfWeekDay
  in
    if dateDayIndex < startOfWeekDayIndex then
       (7 + dateDayIndex) - startOfWeekDayIndex
    else
      dateDayIndex - startOfWeekDayIndex



{-| Return a list of days dayLength long for successive days
starting from startDate.
-}
dayList : Int -> Date -> List (Date)
dayList dayLength startDate =
  List.reverse (dayList' dayLength startDate [])


dayList' : Int -> Date -> List (Date) -> List (Date)
dayList' dayLength date list =
  if dayLength == 0 then
    list
  else
    dayList'
      (dayLength - 1)
      (addDays 1 date)
      (date :: list)


{-| Return iso week values year, week, isoDayOfWeek. -}
isoWeek : Date -> (Int, Int, Int)
isoWeek date =
  let
    inputYear = Date.year date
    endOfYearMaxIsoWeekDate = unsafeFromString ((toString inputYear) ++ "/12/29")
    (year, week1) =
      if is SameOrAfter date endOfYearMaxIsoWeekDate then
        let
          nextYearIsoWeek1 = isoWeekOne (inputYear + 1)
          -- _ = Debug.log("isoWeek") ("nextYearIsoWeek1", inputYear + 1, Format.isoString nextYearIsoWeek1)
        in
          if is Before date nextYearIsoWeek1 then
            (inputYear, isoWeekOne inputYear)
          else
            (inputYear + 1, nextYearIsoWeek1)
      else
        let
          thisYearIsoWeek1 = isoWeekOne inputYear
          -- _ = Debug.log("isoWeek") ("thisYearIsoWeek1", inputYear, Format.utcFormat.isoString thisYearIsoWeek1)
        in
          if is Before date thisYearIsoWeek1 then
            (inputYear - 1, isoWeekOne (inputYear - 1))
          else
            (inputYear, thisYearIsoWeek1)
    dateAsDay = scaleDate ScaleDay date
    daysSinceWeek1 = (Core.toTime dateAsDay - (Core.toTime week1)) // Core.ticksADay
  in
    (year, (daysSinceWeek1 // 7) + 1, Core.isoDayOfWeek (Date.dayOfWeek date))


{- Return date of start of week one for year. -}
isoWeekOne : Int -> Date
isoWeekOne year =
  let
    date = unsafeFromString ((toString year) ++ "/01/04")
    isoDow = Core.isoDayOfWeek (Date.dayOfWeek date)
  in
    addDays (Core.isoDayOfWeekMon - isoDow) date


{-| Scale date by zeroing out all values below given scale.
Rounds down to the nearest scale basically.

This scales in local time zone values, as the date element parts
are pulled straight from the local time zone date values.

-}
scaleDate : DateScale -> Date -> Date
scaleDate dateScale date =
  let
    dateTicks = Core.toTime date
  in
    case dateScale of
      ScaleNone -> date
      ScaleMillisecond -> date
      ScaleSecond -> scaleSecond date
      ScaleMinute -> scaleMinute date
      ScaleHour -> scaleHour date
      ScaleDay -> scaleDay date
      -- ScaleWeek -> date
      ScaleMonth -> scaleMonth date
      -- ScaleQuarter -> date
      ScaleYear -> scaleYear date


scaleSecond : Date -> Date
scaleSecond date =
  let
    ticks = (Date.millisecond date) * Core.ticksAMillisecond
    newDate = Core.fromTime ((Core.toTime date) - ticks)
    -- _ = Debug.log("scaleSecond") (Format.utcFormat.isoString date, Format.utcFormat.isoString newDate)
  in
    newDate


scaleMinute : Date -> Date
scaleMinute date =
  let
    ticks = (Date.second date) * Core.ticksASecond
    updatedDate = Core.fromTime ((Core.toTime date) - ticks)
    newDate = scaleSecond updatedDate
    -- _ = Debug.log("scaleMinute") (Format.utcFormat.isoString date, Format.utcFormat.isoString updatedDate, Format.utcFormat.isoString newDate)
  in
    newDate


scaleHour : Date -> Date
scaleHour date =
  let
    ticks = (Date.minute date) * Core.ticksAMinute
    updatedDate = Core.fromTime ((Core.toTime date) - ticks)
    newDate = scaleMinute updatedDate
    -- _ = Debug.log("scaleHour  ") (Format.utcFormat.isoString date, Format.utcFormat.isoString updatedDate, Format.utcFormat.isoString newDate)
  in
    newDate


scaleDay : Date -> Date
scaleDay date =
  let
    ticks = (Date.hour date) * Core.ticksAnHour
    updatedDate = Core.fromTime ((Core.toTime date) - ticks)
    newDate = scaleHour updatedDate
    -- _ = Debug.log("scaleDay   ") (Format.utcFormat.isoString date, Format.utcFormat.isoString updatedDate, Format.utcFormat.isoString newDate)
  in
    newDate


scaleMonth : Date -> Date
scaleMonth date =
  let
    ticks = ((Date.day date) - 1) * Core.ticksADay
    updatedDate = Core.fromTime ((Core.toTime date) - ticks)
    newDate = scaleDay updatedDate
    -- _ = Debug.log("scaleMonth ") (Format.utcFormat.isoString date, Format.utcFormat.isoString updatedDate, Format.utcFormat.isoString newDate)
  in
    newDate


scaleYear : Date -> Date
scaleYear date =
  let
    startYearDate =
      unsafeFromString (Format.year date ++ "-01-01Z")
    startMonthDate =
      unsafeFromString (Format.year date ++ "-" ++ Format.month date ++ "-01Z")
    monthTicks = (Core.toTime startMonthDate) - (Core.toTime startYearDate)
    updatedDate = Core.fromTime ((Core.toTime date) - monthTicks)
    newDate = scaleMonth updatedDate
    -- _ = Debug.log("scaleYear  ") (Format.utcFormat.isoString date, Format.utcFormat.isoString updatedDate, Format.utcFormat.isoString newDate)
  in
    newDate


dateDiff : DateScale -> Date -> Date -> Int
dateDiff scale date1 date2 =
  Debug.crash ("dateDiff Not implemented yet")


{-| For specifiying granularity of operations.
Example with is operations.
Example with datediff and which field you care about. not implemented yet.
-}
type DateScale
  = ScaleNone
  | ScaleMillisecond -- this is functionally same as ScaleNone
  | ScaleSecond
  | ScaleMinute
  | ScaleHour
  | ScaleDay
  -- | ScaleWeek -- may not implement
  | ScaleMonth
  -- | ScaleQuarter -- may not implement
  | ScaleYear

{-
-- There will be a proliferation of end points if we supply
-- the following with DateScale parameter.

{-| Return True if date1 is after date2. -}
isAfter : Date -> Date -> Bool
isAfter date1 date2 =
  (Core.toTime date1) > (Core.toTime date2)


{-| Return True if date1 is before date2. -}
isBefore : Date -> Date -> Bool
isBefore date1 date2 =
  (Core.toTime date1) < (Core.toTime date2)


{-| Return True if date1 is same as date2. -}
isSame : Date -> Date -> Bool
isSame date1 date2 =
  (Core.toTime date1) == (Core.toTime date2)


{-| Return True if date1 is same or after date2. -}
isSameOrAfter : Date -> Date -> Bool
isSameOrAfter date1 date2 =
  (Core.toTime date1) >= (Core.toTime date2)


{-| Return True if date1 is same or before date2. -}
isSameOrBefore : Date -> Date -> Bool
isSameOrBefore date1 date2 =
  (Core.toTime date1) <= (Core.toTime date2)


{- Return True if date1 is between date2 and date3. -}
isBetween : Date -> Date -> Date -> Bool
isBetween date1 date2 date3 =
  (isAfter date1 date2) && (isBefore date1 date3)


{- Return True if date1 is between date2 and date3 including
being equal to date2 or date3. -}
isBetweenOpen : Date -> Date -> Date -> Bool
isBetweenOpen date1 date2 date3 =
  (isSameOrAfter date1 date2) && (isSameOrBefore date1 date3)


{- Half open interval start date1 between date2 and date3  -}
isBetweenOpenStart : Date -> Date -> Date -> Bool
isBetweenOpenStart date1 date2 date3 =
  (isSameOrAfter date1 date2) && (isBefore date1 date3)


{- Half open interval end date1 between date2 and date3  -}
isBetweenOpenEnd : Date -> Date -> Date -> Bool
isBetweenOpenEnd date1 date2 date3 =
  (isAfter date1 date2) && (isSameOrBefore date1 date3)
-}


type DateComparison2
  = Before
  | After
  | Same
  | SameOrAfter
  | SameOrBefore

type DateComparison3
  = Between
  | BetweenOpenStart
  | BetweenOpenEnd
  | BetweenOpen


{-
TODO ? add variant with DateScale parameter.
-}
is : DateComparison2 -> Date -> Date -> Bool
is comp date1 date2 =
  let
    time1 = Core.toTime date1
    time2 = Core.toTime date2
  in
    case comp of
      Before -> time1 < time2
      After -> time1 > time2
      Same -> time1 == time2
      SameOrBefore -> time1 <= time2
      SameOrAfter -> time1 >= time2


{- date1 is between date2 and date3 -}
is3 : DateComparison3 -> Date -> Date -> Date -> Bool
is3 comp date1 date2 date3=
  let
    time1 = Core.toTime date1
    time2 = Core.toTime date2
    time3 = Core.toTime date3
  in
    case comp of
      Between -> time1 > time2 && time1 < time3
      BetweenOpenStart -> time1 >= time2 && time1 < time3
      BetweenOpenEnd -> time1 > time2 && time1 <= time3
      BetweenOpen -> time1 >= time2 && time1 <= time3





{- Elm Date.fromString suffers from the some of the same javascript unusual
compensation of input ranges when converting strings to Dates.

This method makes some known undesirable no Err results return Err.

Example produces `Ok "2012-03-02"` in javascript
```
  aDate = (Date.fromString "2012-02-31")
```

checkDateResult tries to catch and mark as Err some of these cases.
-}
fromString : String -> Result String Date
fromString dateStr =
  (Date.fromString dateStr)
    `Result.andThen`
    (checkDateResult dateStr)


{-| Utility for known input string date creation cases.
Checks for a fail anyway just in case and calls Debug.crash().
-}
unsafeFromString : String -> Date
unsafeFromString dateStr =
  case fromString dateStr of
    Ok date -> date
    Err msg -> Debug.crash("unsafeFromString")


{- If the input string is UTC based ends in "Z" or "+00:00"
check that rendering date to string again after is in utc form.
Otherwise we check rendering of date in local form matches date part.

Regex currently limited to "-" between date parts only.
-}
checkDateResult : String -> Date -> Result String Date
checkDateResult dateStr date =
    let
      -- we only check for extra logic if dateStr matches this regex
      extraCheck = Regex.regex "^\\d{4}-\\d{1,2}-\\d{1,2}"
      endsWithUTCOffset =
           String.endsWith "Z" dateStr
        || String.endsWith "+00:00" dateStr
        || String.endsWith "+0000" dateStr
        || String.endsWith "+00" dateStr
      checkDatePart =
        if endsWithUTCOffset then
          StringUtils.trimRightChar 'Z' (Format.utcIsoDateString date)
        else
          Format.isoDateString date
      -- _ = Debug.log("checkDateResult") (dateStr, checkDatePart)
    in
      if Regex.contains extraCheck dateStr then
        if String.startsWith checkDatePart dateStr then
          Ok date
        else
          Err
          ( "Error leading date part got converted from \""
            ++ dateStr ++ "\" to \""
            ++ checkDatePart ++ "\""
          )
      else
        Ok date










-- Bunch of create date functions, do not use date as input.

{- Make a local date from year, rest fields default. -}
makeDateY : { a | year : Int} -> Date
makeDateY {year} =
  unsafeFromString ""


-- input idea ? "1981,Dec,32,12,23,55,333,-600" - urk parse.

-- custom records for this stuff ?
-- unique entry points or all.

makeDateAllOffset :
  { a
  | year : Int
  , month : Month
  , day : Day
  , hour : Int
  , minute : Int
  , second : Int
  , millisecond : Int
  , offsetMinutes : Int
  }
  -> Date
makeDateAllOffset {year,month,day,hour,minute,second,millisecond,offsetMinutes} =
  unsafeFromString ""

-- makeDate {year, month} =


type alias DateRec =
  { year : Int
  , month : Month
  , day : Day
  , hour : Int
  , minute : Int
  , second : Int
  , millisecond : Int
  , offsetMinutes : Int
  }


epochAsRecord : DateRec
epochAsRecord =
  { year = 1970
  , month = Jan
  , day = Thu
  , hour = 0
  , minute = 0
  , second = 0
  , millisecond = 0
  , offsetMinutes = 0
  }
