module Date.Extra.Ceil exposing
  (ceil
  , Ceil (..)
  )

{-| Increases a date to a given granularity this is similar in concept
to ceil on Float so was named the same.

This allows you to modify a date to reset to maximum values
all values below a given granularity.

This operates in local time zone so if you are not in UTC time zone
and you output date in UTC time zone the datefields will not be floored.

Example `Floor.ceil Hour date` will return a modified date with
* Minutes to 59
* Seconds to 59
* Milliseconds to 999

@docs ceil
@docs Ceil

This modules implementation became much simpler when Field module was introduced.

Copyright (c) 2016 Robin Luiten
-}

import Date exposing (..)
import Date.Extra.Field as Field
import Date.Extra.Floor as Floor
import Date.Extra.Duration as Duration

{-| Date granularity of operations. -}
type Ceil
  = Millisecond
  | Second
  | Minute
  | Hour
  | Day
  | Month
  | Year


{-| Floor date by increasing to maximum value all values below given granularity.

This ceils in local time zone values, as the date element parts
are pulled straight from the local time zone date values.
-}
ceil : Ceil -> Date -> Date
ceil dateCeil date =
  case dateCeil of
    Millisecond -> date
    Second -> Field.fieldToDateClamp (Field.Millisecond 999) date
    Minute -> Field.fieldToDateClamp (Field.Second 59) (ceil Second date)
    Hour -> Field.fieldToDateClamp (Field.Minute 59) (ceil Minute date)
    Day -> Field.fieldToDateClamp (Field.Hour 23) (ceil Hour date)
    Month -> Field.fieldToDateClamp (Field.DayOfMonth 31) (ceil Day date)
    Year ->
      let
        extraYear = (Duration.add Duration.Year 1 date)
        startYear = Floor.floor Floor.Year extraYear
      in
        Duration.add Duration.Millisecond -1 startYear
