module Date.UtilsTests where

import Date exposing (Date)
import ElmTest exposing (..)
import Time exposing (Time)

import Date.Core as Core
import Date.Format as Format
import Date.Create as Create
import Date.Utils as DateUtils
import TestUtils


tests : Test
tests =
  suite "Date.Utils tests"
    [ backToStartofWeekTests () -- covers all cases.
    , firstOfMonthDateTest ()
    , firstOfMonthDateTest2 ()
    , firstOfMonthDateTest3 ()
    , lastOfMonthDateTest ()
    , lastOfMonthDateLeapFebTest ()
    , lastOfprevMonthDateTest ()
    , firstOfNextMonthDateTest ()
    , daysInprevMonthTest ()
    , daysInNextMonthTest ()
    , fromStringErr1Test ()
    , fromStringErr2Test ()
    , fromStringTest1 ()
    , fromStringTest2 ()
    , addDaysTests ()
    , addMonthsTests ()
    , dayListTest ()
    , scaleDateTests ()
    , isoWeekOneTests ()
    , isoWeekTests ()
    ]


backToStartofWeekTests _ =
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
    (DateUtils.daysBackToStartOfWeek dateDay startOfWeekDay)


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


-- this has
firstOfMonthDateTest _ =
  test "firstOfMonthDate \"2015-11-11 11:45\" is \"2015-11-01 11:45\"" <|
    TestUtils.assertDateFunc
      "2015-11-11 11:45"
      "2015-11-01 11:45"
      DateUtils.firstOfMonthDate


firstOfMonthDateTest2 _ =
  test "firstOfMonthDate \"2016-01-02 00:00\" is \"2016-01-01 00:00\"" <|
    TestUtils.assertDateFunc
      "2016-01-02 00:00"
      "2016-01-01 00:00"
      DateUtils.firstOfMonthDate


firstOfMonthDateTest3 _ =
  test "firstOfMonthDate \"2016-01-02\" is \"2016-01-01\"" <|
    TestUtils.assertDateFunc
      "2016-01-02"
      "2016-01-01"
      DateUtils.firstOfMonthDate


lastOfMonthDateTest _ =
  test "lastOfMonthDate" <|
    TestUtils.assertDateFunc
      "2015-11-11 11:45"
      "2015-11-30 11:45"
      (DateUtils.lastOfMonthDate)


lastOfMonthDateLeapFebTest _ =
  test "lastOfMonthDate" <|
    TestUtils.assertDateFunc
      "2012-02-18 11:45"
      "2012-02-29 11:45"
      (DateUtils.lastOfMonthDate)


lastOfprevMonthDateTest _ =
  test "lastOfprevMonthDate" <|
    TestUtils.assertDateFunc
      "2012-03-02 11:45"
      "2012-02-29 11:45"
      (DateUtils.lastOfPrevMonthDate)


firstOfNextMonthDateTest _ =
  test "firstOfNextMonthDate" <|
    TestUtils.assertDateFunc
      "2012-02-01 02:20"
      "2012-03-01 02:20"
      (DateUtils.firstOfNextMonthDate)


daysInprevMonthTest _ =
  test "daysInprevMonth" <|
    assertEqual
      (Ok 29)
      ( ( Result.map
            DateUtils.daysInPrevMonth
            (DateUtils.fromString "2012-03-04 11:34")
        )
      )


daysInNextMonthTest _ =
  test "daysInNextMonth" <|
    assertEqual
      (Ok 31)
      ( ( Result.map
            DateUtils.daysInNextMonth
            (DateUtils.fromString "2011-12-25 22:23")
        )
      )


fromStringErr1Test _ =
  test "Date.fromString will spread days > max month to month, DateUtils will Err." <|
    assertEqual
      (Err "Error leading date part got converted from \"2012-02-31\" to \"2012-03-02\"")
      (DateUtils.fromString "2012-02-31")


fromStringErr2Test _ =
  test "Date.fromString will spread hours > max hours to days, DateUtils will Err." <|
    assertEqual
      (Err "Error leading date part got converted from \"2015-06-11 24:00\" to \"2015-06-12\"")
      (DateUtils.fromString "2015-06-11 24:00")


fromStringTest1 _ =
  let
    resultDate = DateUtils.fromString "2015-12-25T16:43:23Z"
    -- _ = TestUtils.logResultDate "fromStringTest1" resultDate
    testValue = Result.map (\_ -> "Decoded Ok") resultDate
  in
    test "a utc date changing having day change in date due to timezone is not an error." <|
      assertEqual
          (Ok "Decoded Ok")
          testValue


-- This test checks that extra Err logic in DateUtils.fromString
-- only applies to narrow regex scope input patterns at moment.
fromStringTest2 _ =
  test
    """DateUtils.fromString does not try to check for javascript wrapping
    date values in parse logic if it does not match its built in regex.""" <|
    assertEqual
      ( Result.map
          (Date.toTime)
          (DateUtils.fromString "2 Mar 2012")
      )
      ( Result.map
          Date.toTime
          (DateUtils.fromString "31 Feb 2012")
      )


addMonthsTests _ =
  suite "DateUtils.addMonths tests"
    (List.map runAddMonthsTestCase addMonthsCases)


runAddMonthsTestCase : (String, Int, String) -> Test
runAddMonthsTestCase (inputDate, addMonths, expectedDate) =
  test
    ( "input " ++ inputDate
      ++ " addMonths " ++ (toString addMonths)
      ++ " expects " ++ expectedDate
    ) <|
    TestUtils.assertDateFunc
      inputDate
      expectedDate
      (DateUtils.addMonths addMonths)


addMonthsCases =
  [ ("2015-06-10",  1, "2015-07-10")
  , ("2015-01-02",  1, "2015-02-02")
  , ("2015-01-31",  1, "2015-02-28")
  , ("2012-01-31",  1, "2012-02-29")

  , ("2015-07-10", -1, "2015-06-10")
  , ("2015-02-02", -1, "2015-01-02")
  , ("2015-02-28", -1, "2015-01-28")
  , ("2012-02-29", -1, "2012-01-29")
  , ("2012-03-31", -1, "2012-02-29")

  , ("2015-06-10",  2, "2015-08-10")
  , ("2015-01-03",  2, "2015-03-03")
  , ("2015-01-31",  2, "2015-03-31")
  , ("2012-01-31",  2, "2012-03-31")

  , ("2015-07-10", -2, "2015-05-10")
  , ("2015-02-02", -2, "2014-12-02")
  , ("2015-02-28", -2, "2014-12-28")
  , ("2012-02-29", -2, "2011-12-29")
  , ("2012-03-31", -2, "2012-01-31")
  ]


addDaysTests _ =
  suite "DateUtils.addDays tests"
    (List.map runAddDaysTestCase addDaysCases)


runAddDaysTestCase : (String, Int, String) -> Test
runAddDaysTestCase (inputDate, addDays, expectedDate) =
  test
    ( "input " ++ inputDate
      ++ " addDays " ++ (toString addDays)
      ++ " expects " ++ expectedDate
    ) <|
    TestUtils.assertDateFunc
      inputDate
      expectedDate
      (DateUtils.addDays addDays)


addDaysCases =
  [ ("2015-06-10",  1, "2015-06-11")
  , ("2015-06-10 11:43",  1, "2015-06-11 11:43")
  , ("2015-06-10 1:43",  1, "2015-06-11 1:43")
  , ("2015-02-28",  1, "2015-03-01")
  , ("2012-02-28",  1, "2012-02-29")
  , ("2012-02-29", -1, "2012-02-28")
  , ("2015-01-01", -1, "2014-12-31")
  ]


dayListTest _ =
  let
    resultList =
      Result.map
        (DateUtils.dayList 35)
        (DateUtils.fromString "2015-12-28")
    _ = Debug.log("dayListTest")
      (Result.map (List.map Format.isoString) resultList)
    resultListDays =
      Result.map (List.map Date.day) resultList
  in
    test "Test 2016 Jan calendar grid date list." <|
      assertEqual
        (Ok ([28..31] ++ [1..31])) --  ++ [1..7]))
        resultListDays


isoWeekOneTests _ =
  suite "isoWeekOne tests" <|
    List.map runIsoWeekOneTest isoWeekOneCases


runIsoWeekOneTest (year, expectedDateStr) =
  test ("isoWeekOne of year " ++ (toString year)) <|
    assertEqual
      (expectedDateStr)
      (Format.utcIsoString (DateUtils.isoWeekOne year))


isoWeekOneCases =
  [ (2005, "2005-01-02T14:00:00.000Z") -- 2005/01/03
  , (2006, "2006-01-01T14:00:00.000Z") -- 2006/01/02
  , (2007, "2006-12-31T14:00:00.000Z") -- 2007/01/01
  , (2008, "2007-12-30T14:00:00.000Z")
  , (2009, "2008-12-28T14:00:00.000Z")
  , (2010, "2010-01-03T14:00:00.000Z")
  ]


isoWeekTests _ =
  suite "isoWeek tests" <|
    List.map runIsoWeekTest isoWeekCases


runIsoWeekTest (dateStr, expectedYear, expectedWeek, expectedIsoDay) =
  test ("isoWeek of " ++ dateStr) <|
    assertEqual
      (expectedYear, expectedWeek, expectedIsoDay)
      ( DateUtils.isoWeek
          (DateUtils.unsafeFromString dateStr)
      )


isoWeekCases =
  [ ("2005-01-01", 2004, 53, 6)
  , ("2005-01-02", 2004, 53, 7)
  , ("2005-01-03", 2005,  1, 1)
  , ("2007-01-01", 2007,  1, 1)
  , ("2007-12-30", 2007, 52, 7)
  , ("2010-01-03", 2009, 53, 7)
  ]


scaleDateTests _ =
  suite "scaleDate tests" <|
    List.map runScaleDateTest scaleDateCases


runScaleDateTest (dateStr, dateScale, expectedDate) =
  let
    date : Date
    date = DateUtils.unsafeFromString dateStr
    dateOut = DateUtils.scaleDate dateScale date
    dateOutStr = Format.utcIsoString dateOut
    dateOut2Str = Format.isoString dateOut
    -- _ = Debug.log("runScaleDateTest") (dateStr, date, dateScale, dateOut, dateOutStr, dateOut2Str)
  in
    test ("scaleDate " ++ (toString dateScale)
          ++ " on " ++ dateStr
          ++ ".") <|
      assertEqual (expectedDate) (dateOutStr)


scaleDateCases =
  [ ("2016-06-05T04:03:02.111Z", DateUtils.ScaleNone, "2016-06-05T04:03:02.111Z")
  , ("2016-06-05T04:03:02.111Z", DateUtils.ScaleMillisecond, "2016-06-05T04:03:02.111Z")
  , ("2016-06-05T04:03:02.111Z", DateUtils.ScaleSecond, "2016-06-05T04:03:02.000Z")
  , ("2016-06-05T04:03:02.111Z", DateUtils.ScaleMinute, "2016-06-05T04:03:00.000Z")
  , ("2016-06-05T04:03:02.111Z", DateUtils.ScaleHour, "2016-06-05T04:00:00.000Z")

  -- "2016-06-04T14:00:00.000Z" == "2016-06-05T00:00:00.000+10:00"
  , ("2016-06-05T04:03:02.111Z", DateUtils.ScaleDay, "2016-06-04T14:00:00.000Z")
  , ("2016-06-05T04:03:02.111+10:00", DateUtils.ScaleDay, "2016-06-04T14:00:00.000Z")
  , ("2016-06-05T23:03:02.111+10:00", DateUtils.ScaleDay, "2016-06-04T14:00:00.000Z")
  -- "2016-06-05T14:00:00.000Z" == "2016-06-06T00:00:00.000+10:00"
  , ("2016-06-06T01:03:02.111+10:00", DateUtils.ScaleDay, "2016-06-05T14:00:00.000Z")

  , ("2016-06-05T04:03:02.111+10:00", DateUtils.ScaleMonth, "2016-05-31T14:00:00.000Z")
  , ("2016-06-05T04:03:02.111+10:00", DateUtils.ScaleYear, "2015-12-31T14:00:00.000Z")
  ]
