module Date.Floor
  ( floor
  , Floor (..)
  ) where

{-| Reduce a date to a given granularity this is similar in concept
to floor on Float so was named the same.

This allows you to modify a date to reset to minimum values
all values below a given granulasiry.

Example `Floor.floor Hour date` will return a modified date with
* Minutes to 0
* Seconds to 0
* Milliseconds to 0

@docs floor
@docs Floor

Copyright (c) 2016 Robin Luiten
-}

import Date exposing (Date, Month (..))

import Date.Core as Core
import Date.Duration as Duration


{-| Date granularity of operations. -}
type Floor
  = Millisecond
  | Second
  | Minute
  | Hour
  | Day
  | Month
  | Year


{-| Floor date by reducing to minimum value all values below given granularity.

This floors in local time zone values, as the date element parts
are pulled straight from the local time zone date values.
-}
floor : Floor -> Date -> Date
floor dateFloor date =
  case dateFloor of
    Millisecond -> date
    Second -> floorSecond date
    Minute -> floorMinute date
    Hour -> floorHour date
    Day -> floorDay date
    Month -> floorMonth date
    Year -> floorYear date


floorSecond : Date -> Date
floorSecond date =
  let
    ticks = (Date.millisecond date) * Core.ticksAMillisecond
    newDate = Core.fromTime ((Core.toTime date) - ticks)
    -- _ = Debug.log("floorSecond") (Format.utcFormat date, Format.utcFormat.isoString newDate)
  in
    newDate


floorMinute : Date -> Date
floorMinute date =
  let
    ticks = (Date.second date) * Core.ticksASecond
    updatedDate = Core.fromTime ((Core.toTime date) - ticks)
    newDate = floorSecond updatedDate
    -- _ = Debug.log("floorMinute") (Format.formatUtc date, Format.utcFormat.isoString updatedDate, Format.utcFormat.isoString newDate)
  in
    newDate


floorHour : Date -> Date
floorHour date =
  let
    ticks = (Date.minute date) * Core.ticksAMinute
    updatedDate = Core.fromTime ((Core.toTime date) - ticks)
    newDate = floorMinute updatedDate
    -- _ = Debug.log("floorHour  ") (Format.formatUtc date, Format.utcFormat.isoString updatedDate, Format.utcFormat.isoString newDate)
  in
    newDate


floorDay : Date -> Date
floorDay date =
  let
    ticks = (Date.hour date) * Core.ticksAnHour
    updatedDate = Core.fromTime ((Core.toTime date) - ticks)
    newDate = floorHour updatedDate
    -- _ = Debug.log("floorDay   ") (Format.formatUtc date, Format.utcFormat.isoString updatedDate, Format.utcFormat.isoString newDate)
  in
    newDate


floorMonth : Date -> Date
floorMonth date =
  let
    ticks = ((Date.day date) - 1) * Core.ticksADay
    updatedDate = Core.fromTime ((Core.toTime date) - ticks)
    newDate = floorDay updatedDate
    -- _ = Debug.log("floorMonth ") (Format.utcFormat.isoString date, Format.utcFormat.isoString updatedDate, Format.utcFormat.isoString newDate)
  in
    newDate


floorYear : Date -> Date
floorYear date =
  let
    startYearDate = Duration.firstOfTheMonth date Jan
    startMonthDate = Duration.firstOfTheMonth date (Date.month date)
    monthTicks = (Core.toTime startMonthDate) - (Core.toTime startYearDate)
    updatedDate = Core.fromTime ((Core.toTime date) - monthTicks)
    newDate = floorMonth updatedDate
    -- _ = Debug.log("floorYear  ") (Format.utcFormat.isoString date, Format.utcFormat.isoString updatedDate, Format.utcFormat.isoString newDate)
  in
    newDate
