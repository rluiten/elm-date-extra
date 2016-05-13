module Date.Extra.ConfigTests exposing (..)

import Date exposing (Date)
import ElmTest exposing (..)

import Date.Extra.Config.Config_en_au as Config_en_au
import Date.Extra.Config.Config_en_us as Config_en_us
import Date.Extra.Config.Configs as Configs


config_en_au = Config_en_au.config
config_en_us = Config_en_us.config


tests : Test
tests =
  suite "Date.Config tests"
    [ test "getConfig en_au" <|
        assertEqual
          config_en_au.format
          (Configs.getConfig "en_au").format
    , test "getConfig en-AU" <|
        assertEqual
          config_en_au.format
          (Configs.getConfig "en-AU").format
    , test "getConfig en-au" <|
        assertEqual
          config_en_au.format
          (Configs.getConfig "en-au").format
    , test "getConfig anything returns en_us" <|
        assertEqual
          config_en_us.format
          (Configs.getConfig "anything").format
    ]
