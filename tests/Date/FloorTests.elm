module Date.FloorTests where

import Date exposing (Date)
import ElmTest exposing (..)
import Time exposing (Time)

import Date.Format as Format
import Date.Floor as Floor exposing (Floor (..))
import Date.Utils as DateUtils


tests : Test
tests =
  suite "Date.Floor tests"
    [ floorDateTests ()
    ]


floorDateTests _ =
  suite "Floor tests" <|
    List.map runFloorCase floorCases


runFloorCase (dateStr, dateFloor, expectedDate) =
  let
    date : Date
    date = DateUtils.unsafeFromString dateStr
    dateOut = Floor.floor dateFloor date
    dateOutStr = Format.utcIsoString dateOut
    dateOut2Str = Format.isoString dateOut
    -- _ = Debug.log("runFloorCase") (dateStr, date, dateFloor, dateOut, dateOutStr, dateOut2Str)
  in
    test ("floor " ++ (toString dateFloor)
          ++ " on " ++ dateStr
          ++ ".") <|
      assertEqual (expectedDate) (dateOutStr)


floorCases =
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

  -- verify dates before 1970 as there internal tick represenation is negative.
  , ("1965-01-02T03:04:05.678Z", Millisecond, "1965-01-02T03:04:05.678Z")
  , ("1965-01-02T03:04:05.678Z", Second, "1965-01-02T03:04:05.000Z")
  , ("1965-01-02T03:04:05.678Z", Minute, "1965-01-02T03:04:00.000Z")
  , ("1965-01-02T03:04:05.678Z", Hour, "1965-01-02T03:00:00.000Z")
  , ("1965-01-02T03:04:05.678Z", Day, "1965-01-01T14:00:00.000Z")

  , ("1965-03-02T03:04:05.678Z", Month, "1965-02-28T14:00:00.000Z")
  , ("1965-03-02T03:04:05.678Z", Year, "1964-12-31T14:00:00.000Z")
  ]
