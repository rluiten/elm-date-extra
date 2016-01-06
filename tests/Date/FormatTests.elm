module Date.FormatTests where

{- Test date format. -}

import Date exposing (Date)
import ElmTest exposing (..)
import Time exposing (Time)

import Date.Core as Core
import Date.Format as Format


tests : Test
tests =
  suite "Date.Format tests"
    [ formatTest ()
    ]


formatTest _ =
  suite "format tests" <|
    List.map runFormatTest formatTestCases


runFormatTest (name, expected, formatStr, time) =
  test name <|
    assertEqual
      expected
      (Format.format formatStr (Date.fromTime time))


formatTestCases =
  [ ("numeric date", "12/08/2014", "%d/%m/%Y", 1407833631116.0)
  , ("spelled out date", "Tuesday, August 12, 2014", "%A, %B %d, %Y", 1407833631116.0)
  , ("with %% ", "% 12/08/2014", "%% %d/%m/%Y", 1407833631116.0)
  , ("with %% no space", " %12/08/2014", " %%%d/%m/%Y", 1407833631116.0)
  , ("with milliseconds", "2014-08-12 (.116)", "%Y-%m-%d (.%L)", 1407833631116.0)
  , ("with offset", "2014-08-12", "%Y-%m-%dT%H:%M%z", 1407833631116.0)
  , ("with offset", "2014-08-12", "%Y-%m-%dT%H:%M%:z", 1407833631116.0)

  -- failing due to time zone offset assumed by author
  , ("time", "04:53:51 AM", "%I:%M:%S %p", 1407833631116.0)
  ]
