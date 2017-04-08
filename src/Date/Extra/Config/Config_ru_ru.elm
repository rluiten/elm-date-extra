module Date.Extra.Config.Config_ru_ru exposing (..)

{-| This is the default russian config for formatting dates.

@docs config

Copyright (c) 2016-2017 Slava Turchaninov

-}

import Date
import Date.Extra.Config as Config
import Date.Extra.I18n.I_ru_ru as Russian


{-| Config for ru-ru.
-}
config : Config.Config
config =
    { i18n =
        { dayShort = Russian.dayShort
        , dayName = Russian.dayName
        , monthShort = Russian.monthShort
        , monthName = Russian.monthName
        , dayOfMonthWithSuffix = Russian.dayOfMonthWithSuffix
        }
    , format =
        { date = "%d/%m/%Y" -- d/M/YYY
        , longDate = "%A, %B %d, %Y" -- dddd, MMMM dd, yyyy
        , time = "%H:%M" -- H:mm tt
        , longTime = "%H:%M:%S" -- H:mm:ss
        , dateTime = "%d/%m/%Y %H:%M" -- date + time
        , firstDayOfWeek = Date.Mon
        }
    }
