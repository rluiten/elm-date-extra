module Date.Extra.FormatTests exposing (..)

{- Test date format. -}

import Date exposing (Date)
import Test exposing (..)
import Expect
import Time exposing (Time)
import Date.Extra.Core as Core
import Date.Extra.Format as Format
import Date.Extra.Config.Config_en_au as Config_en_au
import Date.Extra.Config.Config_en_us as Config_en_us
import Date.Extra.Config.Config_en_gb as Config_en_gb
import Date.Extra.Config.Config_fr_fr as Config_fr_fr
import Date.Extra.Config.Config_fi_fi as Config_fi_fi
import Date.Extra.Config.Config_pl_pl as Config_pl_pl
import Date.Extra.Config.Config_ro_ro as Config_ro_ro
import Date.Extra.Config.Config_nl_nl as Config_nl_nl
import Date.Extra.Config.Config_pt_br as Config_pt_br
import Date.Extra.Config.Config_et_ee as Config_et_ee
import Date.Extra.Config.Config_ja_jp as Config_ja_jp
import Date.Extra.Config.Config_ru_ru as Config_ru_ru
import Date.Extra.Config.Config_de_de as Config_de_de
import Date.Extra.Config.Config_tr_tr as Config_tr_tr
import Date.Extra.Period as DPeriod exposing (Period(Hour))


config_en_au =
    Config_en_au.config


config_en_us =
    Config_en_us.config


config_en_gb =
    Config_en_gb.config


config_fr_fr =
    Config_fr_fr.config


config_fi_fi =
    Config_fi_fi.config


config_pl_pl =
    Config_pl_pl.config


config_ro_ro =
    Config_ro_ro.config


config_nl_nl =
    Config_nl_nl.config


config_pt_br =
    Config_pt_br.config


config_et_ee =
    Config_et_ee.config


config_ja_jp =
    Config_ja_jp.config


config_ru_ru =
    Config_ru_ru.config


config_de_de =
    Config_de_de.config


config_tr_tr =
    Config_tr_tr.config


tests : Test
tests =
    describe "Date.Format tests"
        [ describe "format tests" <|
            List.map runFormatTest formatTestCases
        , describe "formatUtc tests" <|
            List.map runFormatUtcTest formatUtcTestCases
        , describe "formatOffset tests" <|
            List.map runformatOffsetTest formatOffsetTestCases
        , describe "configLanguage tests" <|
            List.map runConfigLanguageTest formatConfigTestCases
        ]



{-

   Time : 1407833631116
     is : 2014-08-12T08:53:51.116+00:00
     is : 2014-08-12T18:53:51.116+10:00
     is : 2014-08-12T04:53:51.116-04:00

     In a specific time zone... that showed errors.
     "Tue Aug 12 2014 04:53:51 GMT-0400 (Eastern Daylight Time)""
     toUTCString() is : "Tue, 12 Aug 2014 08:53:51 GMT"
     toISOString() is : "2014-08-12T08:53:51.116Z"

   Time : 1407855231116
     is : 2014-08-12T14:53:51.116+00:00
     is : 2014-08-13T00:53:51.116+10:00


   Using floor here to work around bug in Elm 0.16 on Windows
   that cant produce this as integer into the javascript source.

-}


aTestTime =
    floor 1407833631116.0


aTestTime2 =
    floor 1407855231116.0


aTestTime3 =
    floor -48007855231116.0


{-| year 448
-}
aTestTime4 =
    floor -68007855231116.0


{-| problem year negative year out disabled test
-}
aTestTime5 =
    floor 1407182031000.0


{-| 2014-08-04T19:53:51.000Z
-}
aTestTime6 =
    floor 1407117600000.0


{-| 2014-08-04T12:00:00.000+10:00
-}
aTestTime7 =
    floor 1407074400000.0


{-| 2014-08-04T00:00:00.000+10:00
-}
aTestTime8 =
    floor 1375426800000.0


{-| 2013-08-02T17:00:00.000+10:00
-}
aTestTime9 =
    floor -55427130000000.0


{-| 0213-08-02T17:00:00.000+10:00
forces to +10:00 time zone so will run on any time zone
-}
runFormatTest ( name, expected, formatStr, time ) =
    let
        asDate =
            Core.fromTime time

        -- _ = Debug.log "runFormatTest"
        --   ( "name", name
        --   , (Date.year asDate, Date.month asDate, Date.day asDate, Date.hour asDate)
        --   , "time", time
        --   , "format", (Format.formatOffset Config_en_us.config -600 formatStr asDate)
        --   )
    in
        test name <|
            \() ->
                Expect.equal
                    expected
                    (Format.formatOffset Config_en_us.config -600 formatStr asDate)


formatTestCases =
    [ ( "numeric date", "12/08/2014", "%d/%m/%Y", aTestTime )
    , ( "spelled out date", "Tuesday, August 12, 2014", "%A, %B %d, %Y", aTestTime )
    , ( "with %% ", "% 12/08/2014", "%% %d/%m/%Y", aTestTime )
    , ( "with %% no space", " %12/08/2014", " %%%d/%m/%Y", aTestTime )
    , ( "with milliseconds", "2014-08-12 (.116)", "%Y-%m-%d (.%L)", aTestTime )

    -- in EDT GMT-04:00
    -- Tue Aug 12 2014 04:53:51 GMT-0400 (Eastern Daylight Time)
    , ( "with milliseconds 2", "2014-08-12T18:53:51.116", "%Y-%m-%dT%H:%M:%S.%L", aTestTime )
    , ( "small year", "0448-09-09T22:39:28.884", "%Y-%m-%dT%H:%M:%S.%L", aTestTime3 )
    , ( "Config_en_us date", "8/5/2014", config_en_us.format.date, aTestTime5 )
    , ( "Config_en_us longDate", "Tuesday, August 05, 2014", config_en_us.format.longDate, aTestTime5 )
    , ( "Config_en_us time", "5:53 AM", config_en_us.format.time, aTestTime5 )
    , ( "Config_en_us longTime", "5:53:51 AM", config_en_us.format.longTime, aTestTime5 )
    , ( "Config_en_us dateTime", "8/5/2014 5:53 AM", config_en_us.format.dateTime, aTestTime5 )
    , ( "Config_en_us dateTime test PM", "8/4/2014 12:00 PM", config_en_us.format.dateTime, aTestTime6 )
    , ( "Config_en_us dateTime test AM", "8/4/2014 12:00 AM", config_en_us.format.dateTime, aTestTime7 )
    , ( "Config_en_au date", "5/08/2014", config_en_au.format.date, aTestTime5 )
    , ( "Config_en_au longDate", "Tuesday, 5 August 2014", config_en_au.format.longDate, aTestTime5 )
    , ( "Config_en_au time", "5:53 AM", config_en_au.format.time, aTestTime5 )
    , ( "Config_en_au longTime", "5:53:51 AM", config_en_au.format.longTime, aTestTime5 )
    , ( "Config_en_au dateTime", "5/08/2014 5:53 AM", config_en_au.format.dateTime, aTestTime5 )
    , ( "Config_en_us date", "8/12/2014", config_en_us.format.date, aTestTime )

    -- year rendered negative ? boggle :) disabled for not supporting at moment
    --, ("small year", "0448-09-09T22:39:28.885", "%Y-%m-%dT%H:%M:%S.%L", aTestTime4)
    , ( "Check day 12 ordinal date format with out padding", "[12][12th]", "[%-d][%-@d]", aTestTime )
    , ( "Check day 12 ordinal date format with padding", "[12][12th]", "[%e][%@e]", aTestTime )
    , ( "Check day 2 ordinal date format with out padding", "[2][2nd]", "[%-d][%-@d]", aTestTime8 )
    , ( "Check day 2 ordinal date format with padding", "[ 2][ 2nd]", "[%e][%@e]", aTestTime8 )
    , ( "Check short year field ", "0213", "%Y", aTestTime9 )
    , ( "Check 2 digit year field ", "13", "%y", aTestTime9 )
    ]


runConfigLanguageTest ( name, expected, config, formatStr, time ) =
    let
        asDate =
            Core.fromTime time
    in
        test name <|
            \() ->
                Expect.equal
                    expected
                    (Format.formatOffset config -600 formatStr asDate)


{-| These tests are testing a few language field values and the day idiom function.
-}
dayDayIdiomMonth =
    "%A (%@e) %d %B %Y"


formatConfigTestCases =
    [ ( "Config_en_au format", "5/08/2014", config_en_au, config_en_au.format.date, aTestTime5 )
    , ( "Config_en_au format idiom", "Tuesday ( 5th) 05 August 2014", config_en_au, dayDayIdiomMonth, aTestTime5 )
    , ( "Config_en_us day idiom", "8/5/2014", config_en_us, config_en_us.format.date, aTestTime5 )
    , ( "Config_en_us format idiom", "Tuesday ( 5th) 05 August 2014", config_en_us, dayDayIdiomMonth, aTestTime5 )
    , ( "Config_en_gb day idiom", "5/08/2014", config_en_gb, config_en_gb.format.date, aTestTime5 )
    , ( "Config_en_gb format idiom", "Tuesday ( 5th) 05 August 2014", config_en_gb, dayDayIdiomMonth, aTestTime5 )
    , ( "Config_fr_fr day idiom", "5/08/2014", config_fr_fr, config_fr_fr.format.date, aTestTime5 )
    , ( "Config_fr_fr format idiom", "Mardi (  5) 05 Août 2014", config_fr_fr, dayDayIdiomMonth, aTestTime5 )
    , ( "Config_fi_fi day idiom", "5.8.2014", config_fi_fi, config_fi_fi.format.date, aTestTime5 )
    , ( "Config_fi_fi format idiom", "tiistai (5) 05 elokuuta 2014", config_fi_fi, dayDayIdiomMonth, aTestTime5 )
    , ( "Config_pl_pl day idiom", "05.08.2014", config_pl_pl, config_pl_pl.format.date, aTestTime5 )
    , ( "Config_pl_pl format idiom", "wtorek (5) 05 sierpień 2014", config_pl_pl, dayDayIdiomMonth, aTestTime5 )
    , ( "Config_ro_ro day idiom", "05.08.2014", config_ro_ro, config_ro_ro.format.date, aTestTime5 )
    , ( "Config_ro_ro format idiom", "Marți (5) 05 August 2014", config_ro_ro, dayDayIdiomMonth, aTestTime5 )
    , ( "Config_nl_nl day idiom", "05-08-2014", config_nl_nl, config_nl_nl.format.date, aTestTime5 )
    , ( "Config_nl_nl time idiom", "05:53", config_nl_nl, config_nl_nl.format.time, aTestTime5 )
    , ( "Config_nl_nl dateTime idiom", "05-08-2014 05:53", config_nl_nl, config_nl_nl.format.dateTime, aTestTime5 )
    , ( "Config_nl_nl format date idiom", "dinsdag (5) 05 augustus 2014", config_nl_nl, dayDayIdiomMonth, aTestTime5 )
    , ( "Config_pt_br day idiom", "05/08/2014", config_pt_br, config_pt_br.format.date, aTestTime5 )
    , ( "Config_pt_br format idiom", "Terça-feira ( 5) 05 Agosto 2014", config_pt_br, dayDayIdiomMonth, aTestTime5 )
    , ( "Config_et_ee day idiom", "5. aug 2014. a", config_et_ee, config_et_ee.format.date, aTestTime5 )
    , ( "Config_et_ee format idiom", "teisipäev (5.) 05 august 2014", config_et_ee, dayDayIdiomMonth, aTestTime5 )
    , ( "Config_ja_jp day idiom", "2014/8/5", config_ja_jp, config_ja_jp.format.date, aTestTime5 )
    , ( "Config_ja_jp format idiom", "火曜日 (5) 05 8月 2014", config_ja_jp, dayDayIdiomMonth, aTestTime5 )
    , ( "Config_ru_ru day idiom", "05/08/2014", config_ru_ru, config_ru_ru.format.date, aTestTime5 )
    , ( "Config_ru_ru format idiom", "Вторник (5) 05 Август 2014", config_ru_ru, dayDayIdiomMonth, aTestTime5 )
    , ( "Config_ru_ru time idiom", "05:53", config_ru_ru, config_ru_ru.format.time, aTestTime5 )
    , ( "Config_de_de date idiom", "5. August 2014", config_de_de, config_de_de.format.date, aTestTime5 )
    , ( "Config_de_de longDate idiom", "Dienstag, 5. August 2014", config_de_de, config_de_de.format.longDate, aTestTime5 )
    , ( "Config_tr_tr date idiom", "05.08.2014", config_tr_tr, config_tr_tr.format.date, aTestTime5 )
    , ( "Config_tr_tr longDate idiom", "05 Ağustos 2014 Salı", config_tr_tr, config_tr_tr.format.longDate, aTestTime5 )
    ]


runFormatUtcTest ( name, expected, formatStr, time ) =
    test name <|
        \() ->
            Expect.equal
                expected
                (Format.formatUtc Config_en_us.config formatStr (Core.fromTime time))


formatUtcTestCases =
    [ ( "get back expected date in utc +00:00"
      , "2014-08-12T08:53:51.116+00:00"
      , "%Y-%m-%dT%H:%M:%S.%L%:z"
      , aTestTime
      )
    ]


runformatOffsetTest ( name, expected, formatStr, time, offset ) =
    test name <|
        \() ->
            Expect.equal
                expected
                (Format.formatOffset Config_en_us.config offset formatStr (Core.fromTime time))


formatOffsetTestCases =
    [ ( "get back expected date in utc -04:00"
      , "2014-08-12T04:53:51.116-04:00"
      , "%Y-%m-%dT%H:%M:%S.%L%:z"
      , aTestTime
      , 240
      )
    , ( "get back expected date in utc -12:00"
      , "2014-08-12T20:53:51.116+12:00"
      , "%Y-%m-%dT%H:%M:%S.%L%:z"
      , aTestTime
      , -720
      )
    , ( "12 hour time %I"
      , "Wednesday, 13 August 2014 12:53:51 AM"
      , "%A, %e %B %Y %I:%M:%S %p"
      , aTestTime2
      , -600
      )
    , ( "12 hour time %l"
      , "Wednesday, 13 August 2014 12:53:51 AM"
      , "%A, %e %B %Y %l:%M:%S %p"
      , aTestTime2
      , -600
      )
    ]
