module Date.Extra.FloorTests exposing (..)

import Date exposing (Date)
import ElmTest exposing (..)
import Time exposing (Time)

import Date.Extra.Format as Format
import Date.Extra.Floor as Floor exposing (Floor (..))
import Date.Extra.Utils as DateUtils
import TestUtils


tests : Test
tests =
  suite "Date.Floor tests" <|
    List.map runFloorCase floorCases


runFloorCase (dateStr, dateFloor, expectedDate) =
  let
    inputDate = TestUtils.fudgeDate dateStr
    dateOut = Floor.floor dateFloor inputDate
    dateOutStr = Format.isoStringNoOffset dateOut
    dateOut2Str = Format.isoStringNoOffset dateOut
    -- _ = Debug.log("runFloorCase") (dateStr, inputDate, dateFloor, dateOut, dateOutStr, dateOut2Str)
  in
    test ("floor " ++ (toString dateFloor)
          ++ " on " ++ dateStr
          ++ ".") <|
      assertEqual (expectedDate) (dateOutStr)


floorCases =
  [ ("2016/06/05 04:03:02.111", Millisecond, "2016-06-05T04:03:02.111")
  , ("2016/06/05 04:03:02.111", Second, "2016-06-05T04:03:02.000")
  , ("2016/06/05 04:03:02.111", Minute, "2016-06-05T04:03:00.000")
  , ("2016/06/05 04:03:02.111", Hour, "2016-06-05T04:00:00.000")
  , ("2016/06/05 04:03:02.111", Day, "2016-06-05T00:00:00.000")
  , ("2016/06/05 23:03:02.111", Day, "2016-06-05T00:00:00.000")
  --
  , ("2016/06/05 04:03:02.111", Month, "2016-06-01T00:00:00.000")
  , ("2016/06/05 04:03:02.111", Year, "2016-01-01T00:00:00.000")

  -- -- verify dates before 1970 as there internal tick represenation is negative.
  , ("1965/01/02 03:04:05.678", Millisecond, "1965-01-02T03:04:05.678")
  , ("1965/01/02 03:04:05.678", Second, "1965-01-02T03:04:05.000")
  , ("1965/01/02 03:04:05.678", Minute, "1965-01-02T03:04:00.000")
  , ("1965/01/02 03:04:05.678", Hour, "1965-01-02T03:00:00.000")
  , ("1965/01/02 03:04:05.678", Day, "1965-01-02T00:00:00.000")
  , ("1965/03/02 03:04:05.678", Month, "1965-03-01T00:00:00.000")
  , ("1965/03/02 03:04:05.678", Year, "1965-01-01T00:00:00.000")
  ]
