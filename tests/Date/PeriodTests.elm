module Date.PeriodTests where

import Date exposing (Date)
import ElmTest exposing (..)
import Time exposing (Time)

import Date.Period as Period exposing (Period (..))
import Date.Utils as DateUtils
import TestUtils


tests : Test
tests =
  suite "Date.Period tests"
    [ addTests ()
    , diffTests ()
    ]


addTests _ =
  suite "Date.Period add tests"
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

  , ("2015-06-10 11:43:55.213", Millisecond, -1, "2015-06-10 11:43:55.212")
  , ("2015-06-10 11:43:55.213", Second, -1, "2015-06-10 11:43:54.213")
  , ("2015-06-10 11:43:55.213", Minute, -1, "2015-06-10 11:42:55.213")
  , ("2015-06-10 11:43:55.213", Hour, -1, "2015-06-10 10:43:55.213")
  , ("2015-06-10 11:43:55.213", Day, -1, "2015-06-09 11:43:55.213")
  , ("2015-06-10 11:43:55.213", Week, -1, "2015-06-03 11:43:55.213")

  , ("2015-06-10 11:43:55.213"
    , Delta
      { week = 1
      , day = 1
      , hour = 1
      , minute = 1
      , second = 1
      , millisecond = 1
      }
    , 1
    , "2015-06-18 12:44:56.214")
  , ("2015-06-10 11:43:55.213"
    , Delta
      { week = 1
      , day = 1
      , hour = 1
      , minute = 1
      , second = 1
      , millisecond = 1
      }
    , -1
    , "2015-06-02 10:42:54.212")
  ]


diffTests _ =
  suite "Date.Period diff tests"
    (List.map runDiffCase diffCases)

runDiffCase (date1str, date2str, expectedDiff) =
  test
    ( "diff date1 " ++ date1str
      ++ " date2 = " ++ date2str
    ) <|
    assertEqual
      expectedDiff
      ( Period.diff
          (DateUtils.unsafeFromString date1str)
          (DateUtils.unsafeFromString date2str)
      )

diffCases =
  [ ( "2015-06-10 11:43:55.213"
    , "2015-06-10 11:43:55.214"
    , Delta
        { week = 0
        , day = 0
        , hour = 0
        , minute = 0
        , second = 0
        , millisecond = -1
        }
    )
  , ( "2015-06-10 11:43:55.213"
    , "2015-06-02 10:42:54.212"
    , Delta
        { week = 1
        , day = 1
        , hour = 1
        , minute = 1
        , second = 1
        , millisecond = 1
        }
    )
  , ( "2015-06-02 10:42:54.212"
    , "2015-06-10 11:43:55.213"
    , Delta
        { week = -1
        , day = -1
        , hour = -1
        , minute = -1
        , second = -1
        , millisecond = -1
        }
    )  ]
