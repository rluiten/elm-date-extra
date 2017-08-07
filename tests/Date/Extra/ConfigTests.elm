module Date.Extra.ConfigTests exposing (..)

import Date exposing (Date)
import Date.Extra.Config.Config_de_de as Config_de_de
import Date.Extra.Config.Config_el_gr as Config_el_gr
import Date.Extra.Config.Config_en_au as Config_en_au
import Date.Extra.Config.Config_en_gb as Config_en_gb
import Date.Extra.Config.Config_en_us as Config_en_us
import Date.Extra.Config.Config_et_ee as Config_et_ee
import Date.Extra.Config.Config_fi_fi as Config_fi_fi
import Date.Extra.Config.Config_fr_fr as Config_fr_fr
import Date.Extra.Config.Config_ja_jp as Config_ja_jp
import Date.Extra.Config.Config_lt_lt as Config_lt_lt
import Date.Extra.Config.Config_nl_nl as Config_nl_nl
import Date.Extra.Config.Config_pl_pl as Config_pl_pl
import Date.Extra.Config.Config_pt_br as Config_pt_br
import Date.Extra.Config.Config_ro_ro as Config_ro_ro
import Date.Extra.Config.Config_ru_ru as Config_ru_ru
import Date.Extra.Config.Config_sv_se as Config_sv_se
import Date.Extra.Config.Config_tr_tr as Config_tr_tr
import Date.Extra.Config.Configs as Configs
import Expect
import Test exposing (..)


config_en_au =
    Config_en_au.config


config_en_us =
    Config_en_us.config


config_en_gb =
    Config_en_gb.config


config_fr_fr =
    Config_fr_fr.config


config_fi_fi =
    Config_fi_fi.config


config_sv_se =
    Config_sv_se.config


config_pl_pl =
    Config_pl_pl.config


config_ro_ro =
    Config_ro_ro.config


config_nl_nl =
    Config_nl_nl.config


config_pt_br =
    Config_pt_br.config


config_et_ee =
    Config_et_ee.config


config_ja_jp =
    Config_ja_jp.config


config_ru_ru =
    Config_ru_ru.config


config_de_de =
    Config_de_de.config


config_tr_tr =
    Config_tr_tr.config


config_lt_lt =
    Config_lt_lt.config


config_el_gr =
    Config_el_gr.config


tests : Test
tests =
    describe "Date.Config tests"
        [ test "getConfig en_au" <|
            \() ->
                Expect.equal
                    config_en_au.format
                    (Configs.getConfig "en_au").format
        , test "getConfig en-AU" <|
            \() ->
                Expect.equal
                    config_en_au.format
                    (Configs.getConfig "en-AU").format
        , test "getConfig en-au" <|
            \() ->
                Expect.equal
                    config_en_au.format
                    (Configs.getConfig "en-au").format
        , test "getConfig anything returns en_us" <|
            \() ->
                Expect.equal
                    config_en_us.format
                    (Configs.getConfig "anything").format
        , test "getConfig en_gb" <|
            \() ->
                Expect.equal
                    config_en_gb.format
                    (Configs.getConfig "en_gb").format
        , test "getConfig fr_fr" <|
            \() ->
                Expect.equal
                    config_fr_fr.format
                    (Configs.getConfig "fr_fr").format
        , test "getConfig fi_fi" <|
            \() ->
                Expect.equal
                    config_fi_fi.format
                    (Configs.getConfig "fi_fi").format
        , test "getConfig sv_se" <|
            \() ->
                Expect.equal
                    config_sv_se.format
                    (Configs.getConfig "sv_se").format
        , test "getConfig pl_pl" <|
            \() ->
                Expect.equal
                    config_pl_pl.format
                    (Configs.getConfig "pl_pl").format
        , test "getConfig ro_ro" <|
            \() ->
                Expect.equal
                    config_ro_ro.format
                    (Configs.getConfig "ro_ro").format
        , test "getConfig nl_nl" <|
            \() ->
                Expect.equal
                    config_nl_nl.format
                    (Configs.getConfig "nl_nl").format
        , test "getConfig pt_br" <|
            \() ->
                Expect.equal
                    config_pt_br.format
                    (Configs.getConfig "pt_br").format
        , test "getConfig et_ee" <|
            \() ->
                Expect.equal
                    config_et_ee.format
                    (Configs.getConfig "et_ee").format
        , test "getConfig ja_jp" <|
            \() ->
                Expect.equal
                    config_ja_jp.format
                    (Configs.getConfig "ja_jp").format
        , test "getConfig ru_ru" <|
            \() ->
                Expect.equal
                    config_ru_ru.format
                    (Configs.getConfig "ru_ru").format
        , test "getConfig de_de" <|
            \() ->
                Expect.equal
                    config_de_de.format
                    (Configs.getConfig "de_de").format
        , test "getConfig tr_tr" <|
            \() ->
                Expect.equal
                    config_tr_tr.format
                    (Configs.getConfig "tr_tr").format
        , test "getConfig lt_lt" <|
            \() ->
                Expect.equal
                    config_lt_lt.format
                    (Configs.getConfig "lt_lt").format
        , test "getConfig el_gr" <|
            \() ->
                Expect.equal
                    config_el_gr.format
                    (Configs.getConfig "el_gr").format
        ]
