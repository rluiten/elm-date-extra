module Date.Extra.Ceil exposing
  ( ceil
  , Ceil(..)
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

**Warning about using Ceil for date ranges**

In the past when I have encountered people using a function like Ceil (max date at a given granularity) it was being used in ways that could introduce problems.
Here is why.
* I want to know the maximum date/time of this date at a given granularity so that I can do a date range comparison between the minimum date (or current date) and this maximum date. In all the cases I can remember they were doing a date range comparison using  Greater Than Or Equal To minimum date and Less Than or Equal To maximum date.
 * I can't state strongly enough that this is not the way to do date ranges it leads to missed matches that fall between the generated maximum date and the following date at the same granularity in systems were you are working at a granularity larger than the underlying stored granularity. Even if you are working at the smallest granularity of the system its a not a good way to think about ranges.
 * When comparing date ranges I strongly suggest you always use a half closed interval. This means always build date ranges using Greater Than or Equal To minimum date and Less Than maximum date. (This applies to floating point numbers as well).
  * Its equivalently safe to go Greater Than minimum and Less Than or Equal to maximum, in my experience business understanding nearly always dictated include minimum excluded maximum.
 * Once you do this there is no possible gap and it becomes easier to think about.


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
