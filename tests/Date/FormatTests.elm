module Date.FormatTests where

{- Test date format.

Copyright (c) 2016 Robin Luiten
-}

import Date exposing (Date)
import ElmTest exposing (..)
import Time exposing (Time)

import Date.Core as Core
import Date.Format as Format
import Date.Config.Config_en_us as English
import Date.Period as DPeriod exposing (Period (Hour))


tests : Test
tests =
  suite "Date.Format tests"
    [ formatTest ()
    , formatUtcTest ()
    , formatOffsetTest ()
    ]


{-

Time : 1407833631116
  is : 2014-08-12T08:53:51.116+00:00
  is : 2014-08-12T18:53:51.116+10:00
  is : 2014-08-12T04:53:51.116-04:00

Time : 1407855231116
  is : 2014-08-12T14:53:51.116+00:00
  is : 2014-08-13T00:53:51.116+10:00


Using floor here to work around bug in Elm 0.16 on Windows
that cant produce this as integer into the javascript source.

-}
aTestTime = floor 1407833631116.0


aTestTime2 = floor 1407855231116.0


formatTest _ =
  suite "format tests" <|
    List.map runFormatTest formatTestCases


runFormatTest (name, expected, formatStr, time) =
  test name <|
    assertEqual
      expected
      (Format.format English.config formatStr (Core.fromTime time))


formatTestCases =
  [ ("numeric date", "12/08/2014", "%d/%m/%Y", aTestTime)
  , ("spelled out date", "Tuesday, August 12, 2014", "%A, %B %d, %Y", aTestTime)
  , ("with %% ", "% 12/08/2014", "%% %d/%m/%Y", aTestTime)
  , ("with %% no space", " %12/08/2014", " %%%d/%m/%Y", aTestTime)
  , ("with milliseconds", "2014-08-12 (.116)", "%Y-%m-%d (.%L)", aTestTime)
  , ("with milliseconds", "2014-08-12T18:53:51.116", "%Y-%m-%dT%H:%M:%S.%L", aTestTime)
  ]


formatUtcTest _ =
  suite "formatUtc tests" <|
    List.map runFormatUtcTest formatUtcTestCases


runFormatUtcTest (name, expected, formatStr, time) =
  test name <|
    assertEqual
      expected
      (Format.formatUtc English.config formatStr (Core.fromTime time))


formatUtcTestCases =
  [ ( "get back expected date in utc +00:00", "2014-08-12T08:53:51.116+00:00"
    , "%Y-%m-%dT%H:%M:%S.%L%:z", aTestTime
    )
  ]


formatOffsetTest _ =
  suite "formatOffset tests" <|
    List.map runformatOffsetTest formatOffsetTestCases


runformatOffsetTest (name, expected, formatStr, time, offset) =
  test name <|
    assertEqual
      expected
      (Format.formatOffset English.config offset formatStr (Core.fromTime time))


formatOffsetTestCases =
  [ ( "get back expected date in utc -04:00", "2014-08-12T04:53:51.116-04:00"
    , "%Y-%m-%dT%H:%M:%S.%L%:z", aTestTime, 240
    )
  , ( "get back expected date in utc -12:00", "2014-08-12T20:53:51.116+12:00"
    , "%Y-%m-%dT%H:%M:%S.%L%:z", aTestTime, -720
    )
  , ( "12 hour time %I", "Wednesday, 13 August 2014 12:53:51 AM"
    , "%A, %e %B %Y %I:%M:%S %p"
    , aTestTime2, -600
    )
  , ( "12 hour time %l", "Wednesday, 13 August 2014 12:53:51 AM"
    , "%A, %e %B %Y %l:%M:%S %p"
    , aTestTime2, -600
    )
  ]
