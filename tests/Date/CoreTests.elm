module Date.CoreTests where

import Date exposing (Date)
import ElmTest exposing (..)

import Date.Core as Core
import Date.Utils as DateUtils
import TestUtils


tests : Test
tests =
  suite "Date.Core tests"
    [ nextDayGoesThroughAllDays ()
    , prevDayGoesThroughAllDays ()
    , yearToDayLength1 ()
    , yearToDayLength2 ()
    , isLeapYear1 ()
    , isLeapYear2 ()
    , nextMonthGoesThroughAllMonths ()
    , prevMonthGoesThroughAllMonths ()
    , daysInPrevMonthTest ()
    , daysInNextMonthTest ()
    , toFirstOfMonthTest ()
    , toFirstOfMonthTest2 ()
    , toFirstOfMonthTest3 ()
    , lastOfMonthDateTest ()
    , lastOfMonthDateLeapFebTest ()
    , lastOfPrevMonthDateTest ()
    , firstOfNextMonthDateTest ()
    , daysBackToStartOfWeekTests()
    ]


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


daysInPrevMonthTest _ =
  test "daysInprevMonth" <|
    assertEqual
      (Ok 29)
      ( ( Result.map
            Core.daysInPrevMonth
            (DateUtils.fromString "2012-03-04 11:34")
        )
      )

daysInNextMonthTest _ =
  test "daysInNextMonth" <|
    assertEqual
      (Ok 31)
      ( ( Result.map
            Core.daysInNextMonth
            (DateUtils.fromString "2011-12-25 22:23")
        )
      )


toFirstOfMonthTest _ =
  test "toFirstOfMonth \"2015-11-11 11:45\" is \"2015-11-01 11:45\"" <|
    TestUtils.assertDateFunc
      "2015-11-11 11:45"
      "2015-11-01 11:45"
      Core.toFirstOfMonth


toFirstOfMonthTest2 _ =
  test "toFirstOfMonth \"2016-01-02 00:00\" is \"2016-01-01 00:00\"" <|
    TestUtils.assertDateFunc
      "2016-01-02 00:00"
      "2016-01-01 00:00"
      Core.toFirstOfMonth


toFirstOfMonthTest3 _ =
  test "toFirstOfMonth \"2016-01-02\" is \"2016-01-01\"" <|
    TestUtils.assertDateFunc
      "2016-01-02"
      "2016-01-01"
      Core.toFirstOfMonth


lastOfMonthDateTest _ =
  test "lastOfMonthDate" <|
    TestUtils.assertDateFunc
      "2015-11-11 11:45"
      "2015-11-30 11:45"
      (Core.lastOfMonthDate)


lastOfMonthDateLeapFebTest _ =
  test "lastOfMonthDate" <|
    TestUtils.assertDateFunc
      "2012-02-18 11:45"
      "2012-02-29 11:45"
      (Core.lastOfMonthDate)


lastOfPrevMonthDateTest _ =
  test "lastOfprevMonthDate" <|
    TestUtils.assertDateFunc
      "2012-03-02 11:45"
      "2012-02-29 11:45"
      (Core.lastOfPrevMonthDate)


firstOfNextMonthDateTest _ =
  test "firstOfNextMonthDate" <|
    TestUtils.assertDateFunc
      "2012-02-01 02:20"
      "2012-03-01 02:20"
      (Core.firstOfNextMonthDate)


daysBackToStartOfWeekTests _ =
  suite "DateUtils.daysBackToStartOfWeek tests"
    (List.map runBackToStartofWeekTests backToStartofWeekTestCases)


runBackToStartofWeekTests : (Date.Day, Date.Day, Int) -> Test
runBackToStartofWeekTests (dateDay, startOfWeekDay, expectedOffset) =
  test
    (  "dateDay " ++ (toString dateDay)
    ++ " for startOfWeekDay " ++ (toString startOfWeekDay)
    ++ " expects Offsetback of " ++ (toString expectedOffset) ) <|
  assertEqual
    (expectedOffset)
    (Core.daysBackToStartOfWeek dateDay startOfWeekDay)


-- this is all the possible cases.
backToStartofWeekTestCases : List (Date.Day, Date.Day, Int)
backToStartofWeekTestCases =
  [ (Date.Mon, Date.Mon, 0)
  , (Date.Mon, Date.Tue, 6)
  , (Date.Mon, Date.Wed, 5)
  , (Date.Mon, Date.Thu, 4)
  , (Date.Mon, Date.Fri, 3)
  , (Date.Mon, Date.Sat, 2)
  , (Date.Mon, Date.Sun, 1)

  , (Date.Tue, Date.Mon, 1)
  , (Date.Tue, Date.Tue, 0)
  , (Date.Tue, Date.Wed, 6)
  , (Date.Tue, Date.Thu, 5)
  , (Date.Tue, Date.Fri, 4)
  , (Date.Tue, Date.Sat, 3)
  , (Date.Tue, Date.Sun, 2)

  , (Date.Wed, Date.Mon, 2)
  , (Date.Wed, Date.Tue, 1)
  , (Date.Wed, Date.Wed, 0)
  , (Date.Wed, Date.Thu, 6)
  , (Date.Wed, Date.Fri, 5)
  , (Date.Wed, Date.Sat, 4)
  , (Date.Wed, Date.Sun, 3)

  , (Date.Thu, Date.Mon, 3)
  , (Date.Thu, Date.Tue, 2)
  , (Date.Thu, Date.Wed, 1)
  , (Date.Thu, Date.Thu, 0)
  , (Date.Thu, Date.Fri, 6)
  , (Date.Thu, Date.Sat, 5)
  , (Date.Thu, Date.Sun, 4)

  , (Date.Fri, Date.Mon, 4)
  , (Date.Fri, Date.Tue, 3)
  , (Date.Fri, Date.Wed, 2)
  , (Date.Fri, Date.Thu, 1)
  , (Date.Fri, Date.Fri, 0)
  , (Date.Fri, Date.Sat, 6)
  , (Date.Fri, Date.Sun, 5)

  , (Date.Sat, Date.Mon, 5)
  , (Date.Sat, Date.Tue, 4)
  , (Date.Sat, Date.Wed, 3)
  , (Date.Sat, Date.Thu, 2)
  , (Date.Sat, Date.Fri, 1)
  , (Date.Sat, Date.Sat, 0)
  , (Date.Sat, Date.Sun, 6)

  , (Date.Sun, Date.Mon, 6)
  , (Date.Sun, Date.Tue, 5)
  , (Date.Sun, Date.Wed, 4)
  , (Date.Sun, Date.Thu, 3)
  , (Date.Sun, Date.Fri, 2)
  , (Date.Sun, Date.Sat, 1)
  , (Date.Sun, Date.Sun, 0)
  ]
