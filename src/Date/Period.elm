module Date.Period
  ( add
  , Period (..)
  ) where

{-| Period is a fixed length of time.

Name of type concept copied from NodaTime.

This module has no concept of Months or Years which have variable lenghts of time.
For that see Duration.

@docs add
@docs Period

Copyright (c) 2016 Robin Luiten
-}

import Date exposing (Date)

import Date.Core as Core


{-| A Period. -}
type Period
  = Millisecond
  | Second
  | Minute
  | Hour
  | Day
  | Week
  -- | Combo {week,day,hour,min,sec,millisecond}
  -- DateDiff can return a Period Combo :) neat.

{- Return tick counts for periods. -}
toTicks : Period -> Int
toTicks period =
  case period of
    Millisecond -> Core.ticksAMillisecond
    Second -> Core.ticksASecond
    Minute -> Core.ticksAMinute
    Hour -> Core.ticksAnHour
    Day -> Core.ticksADay
    Week -> Core.ticksAWeek


{-| Add Period count to date. -}
add : Period -> Int -> Date -> Date
add period =
  addTimeUnit (toTicks period)


{- Add time units. -}
addTimeUnit : Int -> Int -> Date -> Date
addTimeUnit unit addend date =
  date
    |> Core.toTime
    |> (+) (addend * unit)
    |> Core.fromTime
