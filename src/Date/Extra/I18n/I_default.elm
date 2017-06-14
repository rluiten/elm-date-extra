module Date.Extra.I18n.I_default exposing (twelveHourPeriod)

{-| Default values to be reused in multiple language configurations.

@docs twelveHourPeriod

-}

import Date.Extra.TwelveHourClock exposing (TwelveHourPeriod(..))


{-| 12-hour clock period (AM/PM) translation and formatting.
    This should be valid for most latin-based languages.
-}
twelveHourPeriod : TwelveHourPeriod -> String
twelveHourPeriod period =
    case period of
        AM ->
            "AM"

        PM ->
            "PM"
