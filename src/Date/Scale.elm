module Date.Scale
  ( scale
  , Scale (..)
  ) where

{-| Treat dates with specific granularity.

This allows you to modify a date to reset to minimum values
all scales below the one you set to.

Example `scaleDate Hour date` will return a modified date with
* Minutes to 0
* Seconds to 0
* Milliseconds to 0

@docs scale
@docs Scale

Copyright (c) 2016 Robin Luiten
-}

import Date exposing (Date, Month (..))

import Date.Core as Core
import Date.Duration as Duration


{-| Date granularity of operations.

Example with is operations.
Example with datediff and which field you care about. not implemented yet.
-}
type Scale
  = Millisecond
  | Second
  | Minute
  | Hour
  | Day
  | Month
  | Year


{-| Scale date by zeroing out all values below given scale.

This scales in local time zone values, as the date element parts
are pulled straight from the local time zone date values.
-}
scale : Scale -> Date -> Date
scale dateScale date =
  let
    dateTicks = Core.toTime date
  in
    case dateScale of
      Millisecond -> date
      Second -> scaleSecond date
      Minute -> scaleMinute date
      Hour -> scaleHour date
      Day -> scaleDay date
      Month -> scaleMonth date
      Year -> scaleYear date


scaleSecond : Date -> Date
scaleSecond date =
  let
    ticks = (Date.millisecond date) * Core.ticksAMillisecond
    newDate = Core.fromTime ((Core.toTime date) - ticks)
    -- _ = Debug.log("scaleSecond") (Format.utcFormat date, Format.utcFormat.isoString newDate)
  in
    newDate


scaleMinute : Date -> Date
scaleMinute date =
  let
    ticks = (Date.second date) * Core.ticksASecond
    updatedDate = Core.fromTime ((Core.toTime date) - ticks)
    newDate = scaleSecond updatedDate
    -- _ = Debug.log("scaleMinute") (Format.formatUtc date, Format.utcFormat.isoString updatedDate, Format.utcFormat.isoString newDate)
  in
    newDate


scaleHour : Date -> Date
scaleHour date =
  let
    ticks = (Date.minute date) * Core.ticksAMinute
    updatedDate = Core.fromTime ((Core.toTime date) - ticks)
    newDate = scaleMinute updatedDate
    -- _ = Debug.log("scaleHour  ") (Format.formatUtc date, Format.utcFormat.isoString updatedDate, Format.utcFormat.isoString newDate)
  in
    newDate


scaleDay : Date -> Date
scaleDay date =
  let
    ticks = (Date.hour date) * Core.ticksAnHour
    updatedDate = Core.fromTime ((Core.toTime date) - ticks)
    newDate = scaleHour updatedDate
    -- _ = Debug.log("scaleDay   ") (Format.formatUtc date, Format.utcFormat.isoString updatedDate, Format.utcFormat.isoString newDate)
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
    startYearDate = Duration.firstOfTheMonth date Jan
    startMonthDate = Duration.firstOfTheMonth date (Date.month date)
    monthTicks = (Core.toTime startMonthDate) - (Core.toTime startYearDate)
    updatedDate = Core.fromTime ((Core.toTime date) - monthTicks)
    newDate = scaleMonth updatedDate
    -- _ = Debug.log("scaleYear  ") (Format.utcFormat.isoString date, Format.utcFormat.isoString updatedDate, Format.utcFormat.isoString newDate)
  in
    newDate
