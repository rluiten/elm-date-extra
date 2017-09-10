module Date.Extra.Config.Config_fr_fr exposing (..)

{-| This is the French config for formatting dates.

@docs config

Copyright (c) 2016-2017 Bruno Girin

-}

import Date
import Date.Extra.Config as Config
import Date.Extra.I18n.I_default as Default
import Date.Extra.I18n.I_fr_fr as French


{-| Config for fr-fr.
-}
config : Config.Config
config =
    { i18n =
        { dayShort = French.dayShort
        , dayName = French.dayName
        , monthShort = French.monthShort
        , monthName = French.monthName
        , dayOfMonthWithSuffix = French.dayOfMonthWithSuffix
        , twelveHourPeriod = Default.twelveHourPeriod
        }
    , format =
        { date = "%d/%m/%Y" -- dd/MM/yyyy
        , longDate = "%A %-d %B %Y" -- dddd, d MMMM yyyy
        , time = "%H:%M" -- h:mm (hours in 24)
        , longTime = "%H:%M:%S" -- h:mm:ss (hours in 24)
        , dateTime = "%-d/%m/%Y %H:%M" -- date + time (hours in 24)
        , firstDayOfWeek = Date.Mon
        }
    }
