module TestRunner where

{- Copyright (c) 2016 Robin Luiten -}
import Graphics.Element exposing (Element)
import ElmTest exposing (..)
import String

import Date.CoreTests
import Date.PeriodTests
import Date.DurationTests
import Date.FloorTests
import Date.CreateTests
import Date.UtilsTests
import Date.FormatTests
import Date.CompareTests
import Date.FieldTests
import Date.ConfigTests


main : Element
main =
  elementRunner
    ( suite "Element Test Runner Tests"
        [ Date.CoreTests.tests
        , Date.PeriodTests.tests
        , Date.DurationTests.tests
        , Date.FloorTests.tests
        , Date.CreateTests.tests
        , Date.UtilsTests.tests
        , Date.FormatTests.tests
        , Date.CompareTests.tests
        , Date.FieldTests.tests
        , Date.ConfigTests.tests
        ]
    )
