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
    describe "Date.Utils tests"
        [ let
            resultList =
                DateUtils.dayList 35 (Create.dateFromFields 2015 Date.Dec 28 0 0 0 0)
          in
            test "Test dayList 2016 Jan calendar grid date list." <|
                \() ->
                    Expect.equal
                        ((List.range 28 31) ++ (List.range 1 31))
                        (List.map Date.day resultList)
        , let
            resultList =
                DateUtils.dayList 2 (Create.dateFromFields 2017 Date.Oct 29 0 0 0 0)
          in
            test "Test dayList UTC +01:00 Amsterdam, Berlin cross daylight saving end" <|
                \() ->
                    Expect.equal
                        ((List.range 29 30))
                        (List.map Date.day resultList)
        , let
            resultList =
                DateUtils.dayList 2 (Create.dateFromFields 2017 Date.Mar 26 0 0 0 0)
          in
            test "Test dayList UTC +01:00 Amsterdam, Berlin cross daylight saving start" <|
                \() ->
                    Expect.equal
                        (List.range 26 27)
                        (List.map Date.day resultList)
        , let
            resultList =
                DateUtils.dayList -2 (Create.dateFromFields 2017 Date.Mar 26 0 0 0 0)
          in
            test "Test dayList negative count eg -2 counts down dates not up" <|
                \() ->
                    Expect.equal
                        (List.reverse (List.range 25 26))
                        (List.map Date.day resultList)
        , TestUtils.describeOffsetTests "Utils.isoWeek - test in matching time zones only."
            2016
            [ ( ( -180, -120 )
                -- UTC +02:00 Helsinki timezone (in windows its called that)
                -- its +03:00 with daylight saving
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
        , isoWeekTests
        ]


isoWeekTests =
    describe "isoWeek tests" <|
        List.map runIsoWeekTest
            [ ( "2005/Jan/01", 2004, 53, 6 )
            , ( "2005/Jan/02", 2004, 53, 7 )
            , ( "2005/Jan/03", 2005, 1, 1 )
            , ( "2007/Jan/01", 2007, 1, 1 )
            , ( "2007/Dec/30", 2007, 52, 7 )
            , ( "2010/Jan/03", 2009, 53, 7 )
            , ( "2016/Mar/28", 2016, 13, 1 )
            , ( "2016/Mar/27", 2016, 12, 7 )
            ]


{-| Example data

Year: DST Start (Clock Forward): DST End (Clock Backward)
2015: Sunday, March 29, 3:00 am: Sunday, October 25, 4:00 am
2016: Sunday, March 27, 3:00 am: Sunday, October 30, 4:00 am
2017: Sunday, March 26, 3:00 am: Sunday, October 29, 4:00 am

Move this test to its own file - to test daylight saving case problem.

-}
testNeg180HelsinkiIsoWeek _ =
    let
        currentOffsets =
            TestUtils.getZoneOffsets 2015
    in
        if currentOffsets /= ( -180, -120 ) then
            test
                """
                This test describe requires to be run in a specific time zone.
                Helsinki UTC+02:00 with daylight saving variations.
                Testing Utils.isoWeek Offsets (-180, -120)
                """
            <|
                \() -> Expect.fail "currentOffsets incorrect for this test"
        else
            -- Reference: https://www.epochconverter.com/weeks/2016
            describe "Timezone +02:00 Helisnki (daylight saving +03:00)"
                [ isoWeekTests
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
