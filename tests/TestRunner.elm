module TestRunner where

{- Copyright (c) 2016 Robin Luiten -}
import Graphics.Element exposing (Element)
import ElmTest exposing (..)
import String

import Date.CoreTests
import Date.PeriodTests
import Date.DurationTests
import Date.ScaleTests
import Date.CreateTests
import Date.UtilsTests
import Date.FormatTests
import Date.CompareTests

main : Element
main =
  elementRunner
    ( suite "Element Test Runner Tests"
        [ Date.CoreTests.tests
        , Date.PeriodTests.tests
        , Date.DurationTests.tests
        , Date.ScaleTests.tests
        , Date.CreateTests.tests
        , Date.UtilsTests.tests
        , Date.FormatTests.tests
        , Date.CompareTests.tests
        ]
    )
