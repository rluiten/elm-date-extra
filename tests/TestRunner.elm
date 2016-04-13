module TestRunner where

{- Copyright (c) 2016 Robin Luiten -}
import Graphics.Element exposing (Element)
import ElmTest exposing (..)
import String

import Date.Extra.CoreTests as CoreTests
import Date.Extra.PeriodTests as PeriodTests
import Date.Extra.DurationTests as DurationTests
import Date.Extra.FloorTests as FloorTests
import Date.Extra.CreateTests as CreateTests
import Date.Extra.UtilsTests as UtilsTests
import Date.Extra.FormatTests as FormatTests
import Date.Extra.CompareTests as CompareTests
import Date.Extra.FieldTests as FieldTests
import Date.Extra.ConfigTests as ConfigTests
import Date.Extra.ConvertingTests as ConvertingTests


main : Element
main =
  elementRunner
    ( suite "Element Test Runner Tests"
        [ CoreTests.tests
        , PeriodTests.tests
        , DurationTests.tests
        , FloorTests.tests
        , CreateTests.tests
        , UtilsTests.tests
        , FormatTests.tests
        , CompareTests.tests
        , FieldTests.tests
        , ConfigTests.tests
        , ConvertingTests.tests
        ]
    )
