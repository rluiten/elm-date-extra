module Tests exposing (..)

import Test exposing (..)
import Date.Extra.CreateTests as CreateTests
import Date.Extra.UtilsTests as UtilsTests
import Date.Extra.CoreTests as CoreTests
import Date.Extra.PeriodTests as PeriodTests
import Date.Extra.DurationTests as DurationTests
import Date.Extra.TimeUnitTests as TimeUnitTests
import Date.Extra.FormatTests as FormatTests
import Date.Extra.CompareTests as CompareTests
import Date.Extra.FieldTests as FieldTests
import Date.Extra.ConfigTests as ConfigTests
import Date.Extra.ConvertingTests as ConvertingTests
import TestUtils exposing (getZoneOffsets)


_ =
    Debug.log "Tests Current Zone Offsets"
        (getZoneOffsets 2016)


all : Test
all =
    (describe "Date Extra Tests"
        [ CreateTests.tests
        , UtilsTests.tests
        , CoreTests.tests
        , PeriodTests.tests
        , DurationTests.tests
        , TimeUnitTests.tests
        , FormatTests.tests
        , CompareTests.tests
        , FieldTests.tests
        , ConfigTests.tests
        , ConvertingTests.tests
        ]
    )
