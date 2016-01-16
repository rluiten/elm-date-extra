module Date.ConfigTests where

import Date exposing (Date)
import ElmTest exposing (..)

import Date.Config.Config_en_au as Config_en_au
import Date.Config.Config_en_us as Config_en_us
import Date.Config.Configs as Configs


config_en_au = Config_en_au.config
config_en_us = Config_en_us.config


tests : Test
tests =
  suite "Date.Config tests"
    [ dateConfig1Test ()
    , dateConfig2Test ()
    , dateConfig3Test ()
    , dateConfig4Test ()
    ]


dateConfig1Test _ =
    test "getConfig en_au" <|
      assertEqual
        config_en_au.format
        (Configs.getConfig "en_au").format


dateConfig2Test _ =
    test "getConfig en-AU" <|
      assertEqual
        config_en_au.format
        (Configs.getConfig "en-AU").format


dateConfig3Test _ =
    test "getConfig en-au" <|
      assertEqual
        config_en_au.format
        (Configs.getConfig "en-au").format


dateConfig4Test _ =
    test "getConfig anything returns en_us" <|
      assertEqual
        config_en_us.format
        (Configs.getConfig "anything").format
