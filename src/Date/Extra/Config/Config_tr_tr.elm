module Date.Extra.Config.Config_tr_tr exposing (..)

{-| This is the default Turkish config for formatting dates.

@docs config

Copyright (c) 2017 Mehmet Köse

-}

import Date
import Date.Extra.Config as Config
import Date.Extra.I18n.I_tr_tr as Turkish


{-| Config for en-us.
-}
config : Config.Config
config =
    { i18n =
        { dayShort = Turkish.dayShort
        , dayName = Turkish.dayName
        , monthShort = Turkish.monthShort
        , monthName = Turkish.monthName
        , dayOfMonthWithSuffix = Turkish.dayOfMonthWithSuffix
        }
    , format =
        { date =
            "%d.%m.%Y"

        , longDate =
            "%d %B %Y %A"

        , time =
            "%H:%M"

        , longTime =
            "%H:%M:%S"

        , dateTime =
            "%d %B %Y %-H:%M:%S"

        , firstDayOfWeek = Date.Mon
        }
    }
