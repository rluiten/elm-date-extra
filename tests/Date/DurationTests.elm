module Date.DurationTests where

import Date exposing (Date)
import ElmTest exposing (..)
import Time exposing (Time)

import Date.Duration as Duration exposing (Duration (..))
import TestUtils


tests : Test
tests = addTests ()


addTests _ =
  suite "Date.Duration tests"
    (List.map runAddCase addCases)


runAddCase : (String, Duration, Int, String) -> Test
runAddCase (inputDate, duration, addend, expectedDate) =
  test
    ( "input " ++ inputDate
      ++ " add " ++ (toString duration)
      ++ " addend " ++ (toString addend)
      ++ " expects " ++ expectedDate
    ) <|
    TestUtils.assertDateFunc
      inputDate
      expectedDate
      (Duration.add duration addend)


addCases =
  [ ("2015-06-10 11:43:55.213", Millisecond, 1, "2015-06-10 11:43:55.214")
  , ("2015-06-10 11:43:55.213", Second, 1, "2015-06-10 11:43:56.213")
  , ("2015-06-10 11:43:55.213", Minute, 1, "2015-06-10 11:44:55.213")
  , ("2015-06-10 11:43:55.213", Hour, 1, "2015-06-10 12:43:55.213")
  , ("2015-06-10 11:43:55.213", Day, 1, "2015-06-11 11:43:55.213")
  , ("2015-06-10 11:43:55.213", Week, 1, "2015-06-17 11:43:55.213")
  , ("2015-06-10 11:43:55.213", Month, 1, "2015-07-10 11:43:55.213")
  , ("2015-06-10 11:43:55.213", Year, 1, "2016-06-10 11:43:55.213")

  , ("2015-02-28", Day, 1, "2015-03-01")
  , ("2012-02-28", Day, 1, "2012-02-29")
  , ("2012-02-29", Day, -1, "2012-02-28")
  , ("2015-01-01", Day, -1, "2014-12-31")

  , ("2015-06-10", Month,  1, "2015-07-10")
  , ("2015-01-02", Month,  1, "2015-02-02")
  , ("2015-01-31", Month,  1, "2015-02-28")
  , ("2012-01-31", Month,  1, "2012-02-29")

  , ("2015-07-10", Month, -1, "2015-06-10")
  , ("2015-02-02", Month, -1, "2015-01-02")
  , ("2015-02-28", Month, -1, "2015-01-28")
  , ("2012-02-29", Month, -1, "2012-01-29")
  , ("2012-03-31", Month, -1, "2012-02-29")

  , ("2015-06-10", Month,  2, "2015-08-10")
  , ("2015-01-03", Month,  2, "2015-03-03")
  , ("2015-01-31", Month,  2, "2015-03-31")
  , ("2012-01-31", Month,  2, "2012-03-31")

  , ("2015-07-10", Month, -2, "2015-05-10")
  , ("2015-02-02", Month, -2, "2014-12-02")
  , ("2015-02-28", Month, -2, "2014-12-28")
  , ("2012-02-29", Month, -2, "2011-12-29")
  , ("2012-03-31", Month, -2, "2012-01-31")
  ]
