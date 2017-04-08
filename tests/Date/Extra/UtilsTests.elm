module Date.Extra.UtilsTests exposing (..)

import Date exposing (Date)
import Test exposing (..)
import Expect
import Time exposing (Time)
import Date.Extra.Config.Config_en_au as Config_en_au
import Date.Extra.Core as Core
import Date.Extra.Create as Create
import Date.Extra.Format as Format
import Date.Extra.Utils as DateUtils
import TestUtils


config_en_au =
    Config_en_au.config


tests : Test
tests =
    let
        currentOffsets =
            TestUtils.getZoneOffsets 2015

        _ =
            Debug.log "UtilsTests currentOffsets" currentOffsets

        currentOffsetTest ( offsets, test ) =
            if currentOffsets == offsets then
                Just (test ())
            else
                Nothing
    in
        describe "Date.Utils tests"
            [ test "Dummy passing test." (\() -> Expect.equal True True)
            , test "TODO fix bug in isoWeek around daylight saving" <|
                \() -> Expect.fail "not fixed yet"
            , let
                resultList =
                    DateUtils.dayList 35 (Create.dateFromFields 2015 Date.Dec 28 0 0 0 0)

                -- _ = Debug.log("dayListTest resultList") List.map Format.isoString resultList
                resultListDays =
                    List.map Date.day resultList
              in
                test "Test 2016 Jan calendar grid date list." <|
                    \() -> Expect.equal ((List.range 28 31) ++ (List.range 1 31)) resultListDays
            , describe "Utils.isoWeek - test in matching time zones only." <|
                List.filterMap currentOffsetTest
                    [ ( ( -180, -120 )
                        -- UTC +2:00 Helsinki timezone (in windows its called that)
                        -- its +3:00 with daylight saving
                      , testNeg180HelsinkiIsoWeek
                      )
                    ]
            , describe "isoWeekOne tests" <|
                List.map runIsoWeekOneTest
                    [ ( 2005, "2005-01-03T00:00:00.000" )
                    , ( 2006, "2006-01-02T00:00:00.000" )
                    , ( 2007, "2007-01-01T00:00:00.000" )
                    , ( 2008, "2007-12-31T00:00:00.000" )
                    , ( 2009, "2008-12-29T00:00:00.000" )
                    , ( 2010, "2010-01-04T00:00:00.000" )
                    ]
            , describe "isoWeek tests" <|
                List.map runIsoWeekTest
                    [ ( "2005/Jan/01", 2004, 53, 6 )
                    , ( "2005/Jan/02", 2004, 53, 7 )
                    , ( "2005/Jan/03", 2005, 1, 1 )
                    , ( "2007/Jan/01", 2007, 1, 1 )
                    , ( "2007/Dec/30", 2007, 52, 7 )
                    , ( "2010/Jan/03", 2009, 53, 7 )
                    , ( "2016/Mar/28", 2016, 13, 1 )
                    ]
            ]



{-
   Year   DST Start (Clock Forward)   DST End (Clock Backward)
   2015   Sunday, March 29, 3:00 am   Sunday, October 25, 4:00 am
   2016   Sunday, March 27, 3:00 am   Sunday, October 30, 4:00 am
   2017   Sunday, March 26, 3:00 am   Sunday, October 29, 4:00 am
-}


testNeg180HelsinkiIsoWeek _ =
    let
        currentOffsets =
            TestUtils.getZoneOffsets 2015

        _ =
            Debug.log "testNeg180HelsinkiIsoWeek currentOffset" currentOffsets

        failMsg =
            """
            This test describe requires to be run in a specific time zone.
            Helsinki UTC+02:00 with daylight saving variations.
            Testing Utils.isoWeek Offsets (-180, -120)
            """
    in
        if currentOffsets /= ( -180, -1201 ) then
            test failMsg <|
                \() -> Expect.fail "mooo"
            -- failMsg
        else
            let
                sep28 =
                    DateUtils.unsafeFromString "2016-3-28"

                sep28Offset =
                    Debug.log "sep28Offset" <| Create.getTimezoneOffset sep28

                sep28isoWeek =
                    DateUtils.isoWeek sep28

                sep27 =
                    DateUtils.unsafeFromString "2016-3-27"

                sep27Offset =
                    Debug.log "sep27Offset" <| Create.getTimezoneOffset sep27

                sep27isoWeek =
                    DateUtils.isoWeek sep27

                sep23 =
                    DateUtils.unsafeFromString "2016-3-23"

                sep23Offset =
                    Debug.log "sep23Offset" <| Create.getTimezoneOffset sep23

                sep23isoWeek =
                    DateUtils.isoWeek sep23

                sep21 =
                    DateUtils.unsafeFromString "2016-3-21"

                sep21Offset =
                    Debug.log "sep21Offset" <| Create.getTimezoneOffset sep21

                sep21isoWeek =
                    DateUtils.isoWeek sep21
            in
                -- Reference: https://www.epochconverter.com/weeks/2016
                describe "Timezone +1000 Sydney (daylight saving)"
                    [ test "Dummy passing test." (\() -> Expect.pass) -- "dummy pass")
                    , test "Check getTimeZoneOffset sep21 is as expected" <|
                        \() -> Expect.equal sep21Offset -120
                    , test "Check getTimeZoneOffset sep23 is as expected" <|
                        \() -> Expect.equal sep23Offset -120
                    , test "Check getTimeZoneOffset sep27 is as expected" <|
                        \() -> Expect.equal sep27Offset -120
                    , test "Check getTimeZoneOffset sep28 is as expected" <|
                        \() -> Expect.equal sep28Offset -180
                    , test "Check isoWeek sep21 is as expected" <|
                        \() -> Expect.equal sep21isoWeek ( 2016, 12, 1 )
                    , test "Check isoWeek sep23 is as expected" <|
                        \() -> Expect.equal sep23isoWeek ( 2016, 12, 3 )
                    , test "Check isoWeek sep27 is as expected" <|
                        \() -> Expect.equal sep27isoWeek ( 2016, 12, 7 )
                    , test "Check isoWeek sep28 is as expected" <|
                        \() -> Expect.equal sep28isoWeek ( 2016, 13, 1 )

                    -- BUG daylight saving change
                    ]


runIsoWeekOneTest ( year, expectedDateStr ) =
    test ("isoWeekOne of year " ++ (toString year)) <|
        \() ->
            Expect.equal
                (expectedDateStr)
                (Format.isoStringNoOffset (DateUtils.isoWeekOne year))


runIsoWeekTest ( dateStr, expectedYear, expectedWeek, expectedIsoDay ) =
    test ("isoWeek of " ++ dateStr) <|
        \() ->
            Expect.equal
                ( expectedYear, expectedWeek, expectedIsoDay )
                (DateUtils.isoWeek (DateUtils.unsafeFromString (dateStr)))
