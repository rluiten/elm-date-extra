module Date.Extra.Config.Config_es_es exposing (..)

{-| This is the Spanish config for formatting dates.

@docs config

Copyright (c) 2018 Ángel Herranz

-}

import Date
import Date.Extra.Config as Config
import Date.Extra.I18n.I_default as Default
import Date.Extra.I18n.I_es_es as Spanish


{-| Config for es_es.
-}
config : Config.Config
config =
    { i18n =
        { dayShort = Spanish.dayShort
        , dayName = Spanish.dayName
        , monthShort = Spanish.monthShort
        , monthName = Spanish.monthName
        , dayOfMonthWithSuffix = Spanish.dayOfMonthWithSuffix
        , twelveHourPeriod = Default.twelveHourPeriod
        }
    , format =
        { date = "%d.%m.%Y" -- dd.MM.yyyy
        , longDate = "%A, %-d %B %Y" -- dddd, d MMMM yyyy
        , time = "%-H:%M" -- h:mm
        , longTime = "%-H:%M:%S" -- h:mm:ss
        , dateTime = "%-d.%m.%Y %-H:%M" -- date + time
        , firstDayOfWeek = Date.Mon
        }
    }
