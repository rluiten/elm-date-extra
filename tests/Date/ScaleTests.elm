module Date.ScaleTests where

import Date exposing (Date)
import ElmTest exposing (..)
import Time exposing (Time)

import Date.Format as Format
import Date.Scale as Scale exposing (Scale (..))
import Date.Utils as DateUtils


tests : Test
tests =
  suite "Date.Scale tests"
    [ scaleDateTests ()
    ]


scaleDateTests _ =
  suite "scaleDate tests" <|
    List.map runScaleDateTest scaleDateCases


runScaleDateTest (dateStr, dateScale, expectedDate) =
  let
    date : Date
    date = DateUtils.unsafeFromString dateStr
    dateOut = Scale.scale dateScale date
    dateOutStr = Format.utcIsoString dateOut
    dateOut2Str = Format.isoString dateOut
    -- _ = Debug.log("runScaleDateTest") (dateStr, date, dateScale, dateOut, dateOutStr, dateOut2Str)
  in
    test ("scale " ++ (toString dateScale)
          ++ " on " ++ dateStr
          ++ ".") <|
      assertEqual (expectedDate) (dateOutStr)


scaleDateCases =
  [ ("2016-06-05T04:03:02.111Z", Millisecond, "2016-06-05T04:03:02.111Z")
  , ("2016-06-05T04:03:02.111Z", Second, "2016-06-05T04:03:02.000Z")
  , ("2016-06-05T04:03:02.111Z", Minute, "2016-06-05T04:03:00.000Z")
  , ("2016-06-05T04:03:02.111Z", Hour, "2016-06-05T04:00:00.000Z")

  -- "2016-06-04T14:00:00.000Z" == "06-05T00:00:00.000+10:00"
  , ("2016-06-05T04:03:02.111Z", Day, "2016-06-04T14:00:00.000Z")
  , ("2016-06-05T04:03:02.111+10:00", Day, "2016-06-04T14:00:00.000Z")
  , ("2016-06-05T23:03:02.111+10:00", Day, "2016-06-04T14:00:00.000Z")
  -- "2016-06-05T14:00:00.000Z" == "2016-06-06T00:00:00.000+10:00"
  , ("2016-06-06T01:03:02.111+10:00", Day, "2016-06-05T14:00:00.000Z")

  , ("2016-06-05T04:03:02.111+10:00", Month, "2016-05-31T14:00:00.000Z")
  , ("2016-06-05T04:03:02.111+10:00", Year, "2015-12-31T14:00:00.000Z")
  ]
