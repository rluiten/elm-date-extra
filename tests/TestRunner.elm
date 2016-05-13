module TestRunner exposing (..)

{- Copyright (c) 2016 Robin Luiten -}
import ElmTest exposing (..)
import String

import Date.Extra.CreateTests as CreateTests
import Date.Extra.UtilsTests as UtilsTests
import Date.Extra.CoreTests as CoreTests
import Date.Extra.PeriodTests as PeriodTests
import Date.Extra.DurationTests as DurationTests
import Date.Extra.FloorTests as FloorTests
import Date.Extra.FormatTests as FormatTests
import Date.Extra.CompareTests as CompareTests
import Date.Extra.FieldTests as FieldTests
import Date.Extra.ConfigTests as ConfigTests
import Date.Extra.ConvertingTests as ConvertingTests


main : Program Never
main = runSuite <|
  suite "Element Test Runner Tests"
    [ test "Dummy passing test." (assertEqual True True)
    , CreateTests.tests
    , UtilsTests.tests
    , CoreTests.tests
    , PeriodTests.tests
    , DurationTests.tests
    , FloorTests.tests
    , FormatTests.tests
    , CompareTests.tests
    , FieldTests.tests
    , ConfigTests.tests
    , ConvertingTests.tests
    ]
