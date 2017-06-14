module Date.Extra.I18n.I_default exposing (twelveHourPeriod)

import Date.Extra.TwelveHourClock exposing (TwelveHourPeriod(..))


twelveHourPeriod : TwelveHourPeriod -> String
twelveHourPeriod period =
    case period of
        AM ->
            "AM"

        PM ->
            "PM"
