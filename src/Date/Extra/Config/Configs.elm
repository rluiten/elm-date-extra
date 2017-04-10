module Date.Extra.Config.Configs
    exposing
        ( getConfig
        , configs
        )

{-| Get a Date Extra Config based up on a locale code.

@docs getConfig
@docs configs

Copyright (c) 2016-2017 Robin Luiten

-}

import Dict exposing (Dict)
import Regex exposing (replace, regex, HowMany(All))
import String
import Date.Extra.Config as Config exposing (Config)
import Date.Extra.Config.Config_en_au as Config_en_au
import Date.Extra.Config.Config_en_us as Config_en_us
import Date.Extra.Config.Config_en_gb as Config_en_gb
import Date.Extra.Config.Config_fr_fr as Config_fr_fr
import Date.Extra.Config.Config_fi_fi as Config_fi_fi
import Date.Extra.Config.Config_pl_pl as Config_pl_pl
import Date.Extra.Config.Config_ro_ro as Config_ro_ro
import Date.Extra.Config.Config_nl_nl as Config_nl_nl
import Date.Extra.Config.Config_pt_br as Config_pt_br
import Date.Extra.Config.Config_et_ee as Config_et_ee
import Date.Extra.Config.Config_ja_jp as Config_ja_jp
import Date.Extra.Config.Config_ru_ru as Config_ru_ru
import Date.Extra.Config.Config_de_de as Config_de_de
import Date.Extra.Config.Config_tr_tr as Config_tr_tr


{-| Built in configurations.
-}
configs : Dict String Config
configs =
    Dict.fromList
        [ ( "en_au", Config_en_au.config )
        , ( "en_us", Config_en_us.config )
        , ( "en_gb", Config_en_gb.config )
        , ( "fr_fr", Config_fr_fr.config )
        , ( "fi_fi", Config_fi_fi.config )
        , ( "pl_pl", Config_pl_pl.config )
        , ( "ro_ro", Config_ro_ro.config )
        , ( "nl_nl", Config_nl_nl.config )
        , ( "pt_br", Config_pt_br.config )
        , ( "et_ee", Config_et_ee.config )
        , ( "ja_jp", Config_ja_jp.config )
        , ( "ru_ru", Config_ru_ru.config )
        , ( "de_de", Config_de_de.config )
        , ( "tr_tr", Config_tr_tr.config )
        ]


{-| Get a Date Extra Config for a locale id.

Lower case matches strings and accepts "-" or "_" to seperate
the characters in code.

Returns "en_us" config if it can't find a match in configs.

-}
getConfig : String -> Config
getConfig id =
    let
        lowerId =
            String.toLower id

        fixedId =
            replace All (regex "-") (\_ -> "_") lowerId
    in
        Maybe.withDefault Config_en_us.config
            (Dict.get fixedId configs)
