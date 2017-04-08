module Date.Extra.Config.Config_nl_nl exposing (..)

{-| This is the Dutch config for formatting dates.

@docs config

Copyright (c) 2016-2017 Mats Stijlaart

-}

import Date
import Date.Extra.Config as Config
import Date.Extra.I18n.I_nl_nl as Dutch


{-| Config for nl-nl.
-}
config : Config.Config
config =
    { i18n =
        { dayShort = Dutch.dayShort
        , dayName = Dutch.dayName
        , monthShort = Dutch.monthShort
        , monthName = Dutch.monthName
        , dayOfMonthWithSuffix = Dutch.dayOfMonthWithSuffix
        }
    , format =
        { date =
            "%d-%m-%Y"

        -- dd-mm-yyy
        , longDate =
            "%A, %B %d, %Y"

        -- dddd, MMMM dd, yyyy
        , time =
            "%H:%M"

        -- hh:mm
        , longTime =
            "%-H:%M:%S %p"

        -- h:mm:ss tt
        , dateTime =
            "%d-%m-%Y %H:%M"

        -- date time
        , firstDayOfWeek = Date.Mon
        }
    }
