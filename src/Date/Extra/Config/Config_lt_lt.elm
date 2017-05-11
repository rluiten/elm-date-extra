module Date.Extra.Config.Config_lt_lt exposing (..)

{-| This is the default Lithuanian config for formatting dates.

@docs config

Copyright (c) 2016-2017 Robin Luiten

-}

import Date
import Date.Extra.Config as Config
import Date.Extra.I18n.I_lt_lt as Lithuanian


{-| Config for en-us.
-}
config : Config.Config
config =
    { i18n =
        { dayShort = Lithuanian.dayShort
        , dayName = Lithuanian.dayName
        , monthShort = Lithuanian.monthShort
        , monthName = Lithuanian.monthName
        , dayOfMonthWithSuffix = Lithuanian.dayOfMonthWithSuffix
        }
    , format =
        { date =
            "%Y-%m-%d"
        , longDate =
            "%A, %Y, %B %-d"
        , time =
            "%H:%M"
        , longTime =
            "%H:%M:%S"
        , dateTime =
            "%a, %-d. %b %Y. %-H:%M"
        , firstDayOfWeek = Date.Mon
        }
    }
