module Date.CreateTests where

import Date exposing (Date)
import ElmTest exposing (..)
import Time exposing (Time)

import Date.Core as Core
import Date.Create as Create
import Date.Utils as DateUtils


tests : Test
tests =
  suite "Date.Create tests"
    [ makeDateTicksTest1 ()
    , makeDateTicksTest2 ()
    , makeDateTicksTest3NegativeTicks1 ()
    , makeDateTicksTest4NegativeTicks2 ()
    , makeDateTicksTest5NegativeTicks3()
    ]


makeDateTicksTest1 _ =
  let
    date = DateUtils.unsafeFromString Core.epochDateStr
    newTicks = Create.makeDateTicks date
  in
  test "makeDateTicks unix epoch Core.epochDateStr produces timeZoneOffset difference." <|
    assertEqual
      (-(Create.getTimezoneOffset date) * Core.ticksAMinute)
      (newTicks)


makeDateTicksTest2 _ =
  let
    resultDate = DateUtils.unsafeFromString "2015-12-25T16:43:23Z"
    ticks = Core.toTime resultDate
    newTicks = Create.makeDateTicks resultDate
    timezoneTicks = (Create.getTimezoneOffset resultDate) * Core.ticksAMinute
  in
  test "makeDateTicks 2 \"2015-12-25T16:43:23Z\"" <|
    assertEqual ticks (newTicks + timezoneTicks)


makeDateTicksTest3NegativeTicks1 _ =
  let
    resultDate = DateUtils.unsafeFromString "1969-01-01T00:00Z"
    ticks = Core.toTime resultDate
    newTicks = Create.makeDateTicks resultDate
    timezoneTicks = (Create.getTimezoneOffset resultDate) * Core.ticksAMinute
  in
  test "makeDateTicks 1969-01-01T00:00Z negative ticks " <|
    assertEqual ticks (newTicks + timezoneTicks)


makeDateTicksTest4NegativeTicks2 _ =
  let
    resultDate = DateUtils.unsafeFromString "1969-02-04T12:23:51.567Z"
    ticks = Core.toTime resultDate
    newTicks = Create.makeDateTicks resultDate
    timezoneTicks = (Create.getTimezoneOffset resultDate) * Core.ticksAMinute
  in
  test "makeDateTicks 1969-01-01T00:00Z negative ticks " <|
    assertEqual ticks (newTicks + timezoneTicks)


makeDateTicksTest5NegativeTicks3 _ =
  let
    resultDate = DateUtils.unsafeFromString "1269-10-26T23:56:01.001Z"
    ticks = Core.toTime resultDate
    newTicks = Create.makeDateTicks resultDate
    timezoneTicks = (Create.getTimezoneOffset resultDate) * Core.ticksAMinute
  in
  test "makeDateTicks 1969-01-01T00:00Z negative ticks " <|
    assertEqual ticks (newTicks + timezoneTicks)




{- This test is dependent on local machines javascript timezone offset.
This was written in +10:00 offset in case you see this fail.

This should not be enabled in commited source as it is too environment
dependent. Built to verify understanding.

Not useful anymore as time zone offset is for a given date, not just a given
runtime, left here for now.
-}
{-
getTimezoneOffsetTest _ =
  test "Get timezone offset of underlying javascript." <|
    assertEqual
      (-600) -- -600 minutes is +10:00 hours, Brisbane Australia
      (Create.getTimezoneOffset)
-}
