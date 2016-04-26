{-| The old version of Date.Extra.Utils.dateFromFields function.
It is much slower the new one, kept for comparison purposes.

Copyright (c) 2016 Robin Luiten
-}

import Graphics.Element exposing (show)
import Signal
import Benchmark
import Task exposing (Task, andThen)
import Text
import Date exposing (Day (..), Date, Month (..))

import Date.Extra.Create as Create
import Date.Extra.Field as Field


main =
 Signal.map (Graphics.Element.leftAligned << Text.fromString ) results.signal


results : Signal.Mailbox String
results =
  Signal.mailbox "Benchmark loading"


port benchResults : (Task Benchmark.Never ())
port benchResults =
  Benchmark.runWithProgress (Just results) mySuite `andThen` \_ -> Task.succeed ()
  -- `andThen` Signal.send results.address


{-| Create a date in current time zone from given fields.
All field values are clamped to there allowed range values.
This can only return dates in current time zone.

Hours are input in 24 hour time range 0 to 23 valid.

This is the previous implementation that is much slower than new one.
-}
dateFromFields : Int -> Month -> Int -> Int -> Int -> Int -> Int -> Date
dateFromFields year month day hour minute second millisecond =
  Date.fromTime 0
    |> Field.fieldToDateClamp (Field.Year year)
    |> Field.fieldToDateClamp (Field.Month month)
    |> Field.fieldToDateClamp (Field.DayOfMonth day)
    |> Field.fieldToDateClamp (Field.Hour hour)
    |> Field.fieldToDateClamp (Field.Minute minute)
    |> Field.fieldToDateClamp (Field.Second second)
    |> Field.fieldToDateClamp (Field.Millisecond millisecond)


oldFn1 _= dateFromFields 1971 Date.Jan 29 11 07 47 111
oldFn2 _= dateFromFields 2016 Date.Jan 29 11 07 47 111
newFn1 _= Create.dateFromFields 1971 Date.Jan 29 11 07 47 111
newFn2 _= Create.dateFromFields 2016 Date.Jan 29 11 07 47 111


mySuite =
  Benchmark.Suite "My Suite"
  [ Benchmark.bench "oldFn 1971" oldFn1
  , Benchmark.bench "oldFn 2016" oldFn2
  , Benchmark.bench "newFn 1971" newFn1
  , Benchmark.bench "newFn 2016" newFn2
  ]
