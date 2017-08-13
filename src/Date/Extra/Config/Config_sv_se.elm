module Date.Extra.Config.Config_sv_se exposing (config)

{-| This is the Swedish config for formatting dates.
@docs config
-}

import Date
import Date.Extra.Config as Config
import Date.Extra.I18n.I_default as Default
import Date.Extra.I18n.I_sv_se as Swedish


{-| Config for sv-se.
-}
config : Config.Config
config =
    { i18n =
        { dayShort = Swedish.dayShort
        , dayName = Swedish.dayName
        , monthShort = Swedish.monthShort
        , monthName = Swedish.monthName
        , dayOfMonthWithSuffix = Swedish.dayOfMonthWithSuffix
        , twelveHourPeriod = Default.twelveHourPeriod
        }
    , format =
        { date = "%Y-%m-%d" -- YYYY-MM-DD (L equivalent in moment.js)
        , longDate = "%A %-d %B %Y" -- dddd D MMMM YYYY
        , time = "%H:%M" -- HH:mm
        , longTime = "%H:%M:%S" -- HH:mm:ss
        , dateTime = "%Y-%m-%d %H:%M" -- YYYY-MM-DD HH:mm
        , firstDayOfWeek = Date.Mon
        }
    }
