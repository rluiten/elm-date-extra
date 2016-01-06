module TestRunner where

import Graphics.Element exposing (Element)
import ElmTest exposing (..)
import String

import Date.CoreTests
import Date.CreateTests
import Date.FormatTests
import Date.StringUtilsTests
import Date.UtilsTests


main : Element
main =
  elementRunner
    ( suite "Element Test Runner Tests"
      [ Date.StringUtilsTests.tests
      , Date.CoreTests.tests
      , Date.CreateTests.tests
      , Date.FormatTests.tests
      , Date.UtilsTests.tests
      ]
    )
