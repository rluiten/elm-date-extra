module Date.UtilsTests where

{- Copyright (c) 2016 Robin Luiten -}

import Date exposing (Date)
import ElmTest exposing (..)
import Time exposing (Time)

import Date.Config.Config_en_au as Config_en_au
import Date.Core as Core
import Date.Format as Format
import Date.Create as Create
import Date.Utils as DateUtils
import TestUtils


config_en_au = Config_en_au.config


tests : Test
tests =
  suite "Date.Utils tests"
    [ fromStringErr1Test ()
    , fromStringErr2Test ()
    , fromStringTest1 ()
    , fromStringTest2 ()
    , dayListTest ()
    , isoWeekOneTests ()
    , isoWeekTests ()
    , fromFieldsTests ()
    ]


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


fromFieldsTests _ =
  suite "dateFromFields timeFromFields tests"
  [ test "test dateFromFields for Date time around code creation" <|
      assertEqual
        "2016-01-29T11:07:47.111+1000"
        (testDateFromFields 2016 Date.Jan 29 11 07 47 111)
  , test "test dateFromFields for Date time around epoch" <|
      assertEqual
        "1970-01-01T05:09:13.111+1000"
        (testDateFromFields 1970 Date.Jan 1 5 9 13 111)
  , test "test timeFromFields" <|
      assertEqual
        "1970-01-01T07:09:13.111+1000"
        (testTimeFromFields 7 9 13 111)
  ]


-- helper
testDateFromFields year month day hour minute second millisecond =
  let
    date = DateUtils.dateFromFields year month day hour minute second millisecond
  in
    Format.formatOffset
      config_en_au
      (Create.getTimezoneOffset date)
      Format.isoMsecOffsetFormat
      (date)


-- helper
testTimeFromFields hour minute second millisecond =
  let
    date = DateUtils.timeFromFields hour minute second millisecond
  in
    Format.formatOffset
      config_en_au
      (Create.getTimezoneOffset date)
      Format.isoMsecOffsetFormat
      (date)
