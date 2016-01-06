module Date.StringUtilsTests where

import ElmTest exposing (..)

import Date.StringUtils as StringUtils


tests : Test
tests =
  suite "String Utils tests"
    [ trimRightCharTest ()
    , trimRightCharTest2 ()
    ]


trimRightCharTest _ =
  test "trimRightCharTest 'y' on \"MoooFey\"" <|
    assertEqual
      "MooFe"
      (StringUtils.trimRightChar 'y' "MooFey")


trimRightCharTest2 _ =
  test "trimRightCharTest 'e' on \"MoooFey\"" <|
    assertEqual
      "MooFey"
      (StringUtils.trimRightChar 'e' "MooFey")
