module Date.PeriodTests where

import Date exposing (Date)
import ElmTest exposing (..)
import Time exposing (Time)

import Date.Period as Period exposing (Period (..))
import TestUtils


tests : Test
tests = addTests ()


addTests _ =
  suite "Date.Period tests"
    (List.map runAddCase addCases)


runAddCase : (String, Period, Int, String) -> Test
runAddCase (inputDate, period, addend, expectedDate) =
  test
    ( "input " ++ inputDate
      ++ " add " ++ (toString period)
      ++ " addend " ++ (toString addend)
      ++ " expects " ++ expectedDate
    ) <|
    TestUtils.assertDateFunc
      inputDate
      expectedDate
      (Period.add period addend)


addCases =
  [ ("2015-06-10 11:43:55.213", Millisecond, 1, "2015-06-10 11:43:55.214")
  , ("2015-06-10 11:43:55.213", Second, 1, "2015-06-10 11:43:56.213")
  , ("2015-06-10 11:43:55.213", Minute, 1, "2015-06-10 11:44:55.213")
  , ("2015-06-10 11:43:55.213", Hour, 1, "2015-06-10 12:43:55.213")
  , ("2015-06-10 11:43:55.213", Day, 1, "2015-06-11 11:43:55.213")
  , ("2015-06-10 11:43:55.213", Week, 1, "2015-06-17 11:43:55.213")
  ]
