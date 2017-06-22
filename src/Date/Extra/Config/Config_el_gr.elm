module Date.Extra.Config.Config_el_gr exposing (..)

{-| This is the Greek (Greece) config for formatting dates.

@docs config

-}

import Date
import Date.Extra.Config as Config
import Date.Extra.I18n.I_el_gr as Greek


{-| Config for el-gr.
-}
config : Config.Config
config =
    { i18n =
        { dayShort = Greek.dayShort
        , dayName = Greek.dayName
        , monthShort = Greek.monthShort
        , monthName = Greek.monthName
        , dayOfMonthWithSuffix = Greek.dayOfMonthWithSuffix
        , twelveHourPeriod = Greek.twelveHourPeriod
        }
    , format =
        -- TODO: Verify those types:
        { date =
            "%-d/%-m/%y"
            -- d/M/yy
        , longDate =
            "%A, %-d %B %Y"
            -- EEEE, d MMMM yyyy
            -- ex. "Παρασκευή, 9 Ιουνίου 2017"
            -- TODO:
            -- Τhe month suffix is correct in this case, but could be wrong
            -- in other contexts. When rendering the month on its own
            -- (e.g. "%B") then it should be "Ιούνιος" rather than "Ιουνίου"
        , time =
            "%-I:%M %P"
            -- h:mm tt
        , longTime =
            "%-I:%M:%S %P"
            -- h:mm:ss a
        , dateTime =
            "-d/%m/%Y %-I:%M %P"
            -- date + time
        , firstDayOfWeek = Date.Sun
        }
    }
