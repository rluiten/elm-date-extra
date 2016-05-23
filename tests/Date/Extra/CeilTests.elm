module Date.Extra.CeilTests exposing (..)

import ElmTest exposing (..)
import Date.Extra.Ceil as Ceil
import Date.Extra.Format as Format
import TestUtils

tests: Test
tests =
  suite "Date.Ceil tests" <|
    List.map runCeilCase ceilCases

type alias CeilCase =
  { dateString: String
  , ceil: Ceil.Ceil
  , expected: String
  }

runCeilCase: CeilCase -> Test
runCeilCase { dateString, ceil, expected } =
  let
    date = TestUtils.fudgeDate dateString
    ceilDate = Ceil.ceil ceil date
    ceilDateStr = Format.isoStringNoOffset ceilDate
  in
    test ("ceil " ++ (toString ceil)
      ++ " on " ++ dateString
      ++ ".") <|

    (assertEqual expected ceilDateStr)

ceilCases : List CeilCase
ceilCases =
  [ CeilCase "2016/06/05 04:03:02.111" Ceil.Millisecond "2016-06-05T04:03:02.111"
  , CeilCase "2016/06/05 04:03:02.111" Ceil.Second "2016-06-05T04:03:02.999"
  , CeilCase "2016/06/05 04:03:02.111" Ceil.Minute "2016-06-05T04:03:59.999"
  , CeilCase "2016/06/05 04:03:02.111" Ceil.Hour "2016-06-05T04:59:59.999"
  , CeilCase "2016/06/05 04:03:02.111" Ceil.Day "2016-06-05T23:59:59.999"

  --month with 30 days
  , CeilCase "2016/06/05 04:03:02.111" Ceil.Month "2016-06-30T23:59:59.999"
  --month with 31 days
  , CeilCase "2016/07/05 04:03:02.111" Ceil.Month "2016-07-31T23:59:59.999"

  , CeilCase "2016/06/05 04:03:02.111" Ceil.Year "2016-12-31T23:59:59.999"

  --leap year
  , CeilCase "2016/02/05 04:03:02.111" Ceil.Month "2016-02-29T23:59:59.999"
  , CeilCase "2017/02/05 04:03:02.111" Ceil.Month "2017-02-28T23:59:59.999"

  , CeilCase "1965/01/02 03:04:05.678" Ceil.Millisecond "1965-01-02T03:04:05.678"
  , CeilCase "1965/01/02 03:04:05.678" Ceil.Second "1965-01-02T03:04:05.999"
  , CeilCase "1965/01/02 03:04:05.678" Ceil.Minute "1965-01-02T03:04:59.999"
  , CeilCase "1965/01/02 03:04:05.678" Ceil.Hour "1965-01-02T03:59:59.999"
  , CeilCase "1965/01/02 03:04:05.678" Ceil.Day "1965-01-02T23:59:59.999"

  , CeilCase "1964/02/02 03:04:05.678" Ceil.Month "1964-02-29T23:59:59.999"
  , CeilCase "1965/02/02 03:04:05.678" Ceil.Month "1965-02-28T23:59:59.999"

  , CeilCase "1965/03/02 03:04:05.678" Ceil.Year "1965-12-31T23:59:59.999"
  ]
