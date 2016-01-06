module Date.CoreTests where

import Date exposing (Date)
import ElmTest exposing (..)
-- import Time exposing (Time)

import Date.Core as Core


tests : Test
tests =
  suite "Date.Core tests"
    [ yearToDayLength1 ()
    , yearToDayLength2 ()
    , isLeapYear1 ()
    , isLeapYear2 ()
    , nextMonthGoesThroughAllMonths ()
    , prevMonthGoesThroughAllMonths ()
    , nextDayGoesThroughAllDays ()
    , prevDayGoesThroughAllDays ()
    ]


yearToDayLength1 _ =
  test "2016 is a leap year in length" <|
    assertEqual 366 (Core.yearToDayLength 2016)


yearToDayLength2 _ =
  test "1900 is not a leap year in length" <|
    assertEqual 365 (Core.yearToDayLength 1900)


isLeapYear1 _ =
  test "2016 is a leap year" <|
    assertEqual True (Core.isLeapYear 2016)


isLeapYear2 _ =
  test "1900 is not a leap year" <|
    assertEqual False (Core.isLeapYear 1900)


nextMonthGoesThroughAllMonths _ =
  let
    nm3 = Core.nextMonth << Core.nextMonth << Core.nextMonth
    nm12 = nm3 << nm3 << nm3 << nm3
  in
    test "nextMonth cycles through all months" <|
      assertEqual Date.Jan (nm12 Date.Jan)


prevMonthGoesThroughAllMonths _ =
  let
    pm3 = Core.prevMonth << Core.prevMonth << Core.prevMonth
    pm12 = pm3 << pm3 << pm3 << pm3
  in
    test "prevMonth cycles through all months" <|
      assertEqual Date.Jan (pm12 Date.Jan)


nextDayGoesThroughAllDays _ =
  let
    nd3 = Core.nextDay << Core.nextDay << Core.nextDay
    nd7 = nd3 << nd3 << Core.nextDay
  in
    test "nextDay cycles through all days" <|
      assertEqual Date.Mon (nd7 Date.Mon)


prevDayGoesThroughAllDays _ =
  let
    pd3 = Core.prevDay << Core.prevDay << Core.prevDay
    pd7 = pd3 << pd3 << Core.prevDay
  in
    test "prevDay cycles through all days" <|
      assertEqual Date.Mon (pd7 Date.Mon)
