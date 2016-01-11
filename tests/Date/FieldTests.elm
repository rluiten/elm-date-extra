module Date.FieldTests where

import Date exposing (Date)
import ElmTest exposing (..)
-- import Time exposing (Time)

import Date.Format as Format
-- import Date.Floor as Floor exposing (Floor (..))
import Date.Utils as DateUtils
import Date.Field as Field exposing (Field (..))


tests : Test
tests =
  suite "Date.Field tests"
    [ fieldDateTests ()
    , fieldDateClampTests()
    ]


fieldDateTests _ =
  suite "fieldDate tests" <|
    List.map runFieldCase fieldCases


runFieldCase (dateStr, field, expectedDate) =
  let
    date : Date
    date = DateUtils.unsafeFromString dateStr
    dateOut = Field.fieldToDate field date
    dateOutStr = Maybe.map Format.utcIsoString dateOut
    dateOut2Str = Maybe.map Format.isoString dateOut
    -- _ = Debug.log("runFieldCase") (dateStr, date, dateFloor, dateOut, dateOutStr, dateOut2Str)
  in
    test ("field " ++ (toString field)
          ++ " on " ++ dateStr
          ++ " expects " ++ toString expectedDate ++ ".") <|
      assertEqual (expectedDate) (dateOutStr)


fieldCases =
  [ ( "2016-06-05T04:03:02.111Z", Millisecond 1
    , Just "2016-06-05T04:03:02.001Z"
    )
  , ( "2016-06-05T04:03:02.111Z", Second 3
    , Just "2016-06-05T04:03:03.111Z"
    )
  , ( "2016-06-05T04:03:02.111Z", Millisecond 1000
    , Nothing
    )
  , ( "2016-06-05T04:03:02.111Z", Millisecond -1
    , Nothing
    )
  , ( "2016-06-05T04:03:02.111Z", Second 60
    , Nothing
    )
  , ( "2016-06-05T04:03:02.111Z", Second -1
    , Nothing
    )
  , ( "2016-06-05T04:03:02.111Z", Minute 60
    , Nothing
    )
  , ( "2016-06-05T04:03:02.111Z", Minute -1
    , Nothing
    )
  , ( "2016-06-05T04:03:02.111Z", Hour 24
    , Nothing
    )
  , ( "2016-06-05T04:03:02.111Z", Hour -1
    , Nothing
    )
  , ( "2016-06-05T04:03:02.111Z", DayOfMonth 0
    , Nothing
    )
  , ( "2016-06-05T04:03:02.111Z", DayOfMonth 31
    , Nothing
    )
  , ( "2016-06-05T04:03:02.111Z", Year -1
    , Nothing
    )
  , ( "2016-06-05T04:03:02.111Z", DayOfMonth 31
    , Nothing
    )
  , ( "2016-06-05T04:03:02.111Z" -- Sunday in UTC
    , DayOfWeek (Date.Mon, Date.Mon)
    , Just "2016-05-30T04:03:02.111Z"
    )
  , ( "2016-06-05T04:03:02.111Z" -- Sunday in UTC
    , DayOfWeek (Date.Mon, Date.Sun)
    , Just "2016-06-06T04:03:02.111Z"
    )
  , ( "2016-06-05T04:03:02.111Z" -- Sunday in UTC
    , DayOfWeek (Date.Thu, Date.Thu)
    , Just "2016-06-02T04:03:02.111Z"
    )
  , ( "2016-06-05T04:03:02.111Z" -- Sunday in UTC
    , DayOfWeek (Date.Sat, Date.Sun)
    , Just "2016-06-11T04:03:02.111Z"
    )
  ]


fieldDateClampTests _ =
  suite "fieldDateClamp tests" <|
    List.map runFieldClampCase fieldClampCases


runFieldClampCase (dateStr, field, expectedDate) =
  let
    date : Date
    date = DateUtils.unsafeFromString dateStr
    dateOut = Field.fieldToDateClamp field date
    dateOutStr = Format.utcIsoString dateOut
    dateOut2Str = Format.isoString dateOut
    -- _ = Debug.log("runFieldCase") (dateStr, date, dateFloor, dateOut, dateOutStr, dateOut2Str)
  in
    test ("field " ++ (toString field)
          ++ " on " ++ dateStr
          ++ " expects " ++ toString expectedDate ++ ".") <|
      assertEqual (expectedDate) (dateOutStr)


-- these are same input cases as FieldCases, different results for clamp
fieldClampCases =
  [ ( "2016-06-05T04:03:02.111Z", Millisecond 1
    , "2016-06-05T04:03:02.001Z"
    )
  , ( "2016-06-05T04:03:02.111Z", Second 3
    , "2016-06-05T04:03:03.111Z"
    )
  , ( "2016-06-05T04:03:02.111Z", Millisecond 1000
    , "2016-06-05T04:03:02.999Z"
    )
  , ( "2016-06-05T04:03:02.111Z", Millisecond -1
    , "2016-06-05T04:03:02.000Z"
    )
  , ( "2016-06-05T04:03:02.111Z", Second 60
    , "2016-06-05T04:03:59.111Z"
    )
  , ( "2016-06-05T04:03:02.111Z", Second -1
    , "2016-06-05T04:03:00.111Z"
    )
  , ( "2016-06-05T04:03:02.111Z", Minute 60
    , "2016-06-05T04:59:02.111Z"
    )
  , ( "2016-06-05T04:03:02.111Z", Minute -1
    , "2016-06-05T04:00:02.111Z"
    )

  -- UGH so may fail on other timezone javascript vm's DANGIT.
  -- Because the setting of field suses LOCAL date field values to do its work.

  -- this one clamps to 23 hours, and is applied in local time zone
  --  in local  +10:00 2016-06-05T14:03:02.111
  --  in local  +10:00 2016-06-05T23:03:02.111 after setting 23.
  --  which results in the below Z offset +00:00 result.
  , ( "2016-06-05T04:03:02.111Z", Hour 24
    , "2016-06-05T13:03:02.111Z"
    )
  , ( "2016-06-05T04:03:02.111Z", Hour -1
    , "2016-06-04T14:03:02.111Z"
    )
  , ( "2016-06-05T04:03:02.111Z", DayOfMonth 0
    , "2016-06-01T04:03:02.111Z"
    )
  , ( "2016-06-05T04:03:02.111Z", DayOfMonth 31
    , "2016-06-30T04:03:02.111Z"
    )
  , ( "2016-06-05T04:03:02.111Z", Year -1
    , "0000-06-05T04:03:02.111Z"
    )
  , ( "2016-06-05T04:03:02.111Z", DayOfMonth 31
    , "2016-06-30T04:03:02.111Z"
    )
  , ( "2016-06-05T04:03:02.111Z" -- Sunday in UTC
    , DayOfWeek (Date.Mon, Date.Mon)
    , "2016-05-30T04:03:02.111Z"
    )
  , ( "2016-06-05T04:03:02.111Z" -- Sunday in UTC
    , DayOfWeek (Date.Mon, Date.Sun)
    , "2016-06-06T04:03:02.111Z"
    )
  , ( "2016-06-05T04:03:02.111Z" -- Sunday in UTC
    , DayOfWeek (Date.Thu, Date.Thu)
    , "2016-06-02T04:03:02.111Z"
    )
  , ( "2016-06-05T04:03:02.111Z" -- Sunday in UTC
    , DayOfWeek (Date.Sat, Date.Sun)
    , "2016-06-11T04:03:02.111Z"
    )
  ]
