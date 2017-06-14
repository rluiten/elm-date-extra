module Date.Extra.I18n.I_el_gr exposing (..)

{-| Greek values for day and month names.

@docs dayShort
@docs dayName
@docs monthShort
@docs monthName
@docs dayOfMonthWithSuffix

Copyright (c) 2017 Eleni Lixourioti

-}

import Date exposing (Day(..), Month(..))
import Date.Extra.TwelveHourClock exposing (TwelveHourPeriod(..))


{-| Day short name.
-}
dayShort : Day -> String
dayShort day =
    case day of
        Mon ->
            "Δευ"

        Tue ->
            "Τρι"

        Wed ->
            "Τετ"

        Thu ->
            "Πεμ"

        Fri ->
            "Παρ"

        Sat ->
            "Σαβ"

        Sun ->
            "Κυρ"


{-| Day full name.
-}
dayName : Day -> String
dayName day =
    case day of
        Mon ->
            "Δευτέρα"

        Tue ->
            "Τρίτη"

        Wed ->
            "Τετάρτη"

        Thu ->
            "Πέμπτη"

        Fri ->
            "Παρασκευή"

        Sat ->
            "Σάββατο"

        Sun ->
            "Κυριακή"


{-| Month short name.
-}
monthShort : Month -> String
monthShort month =
    case month of
        Jan ->
            "Ιαν"

        Feb ->
            "Φεβ"

        Mar ->
            "Μαρ"

        Apr ->
            "Απρ"

        May ->
            "Μαϊ"

        Jun ->
            "Ιουν"

        Jul ->
            "Ιουλ"

        Aug ->
            "Αυγ"

        Sep ->
            "Σεπ"

        Oct ->
            "Οκτ"

        Nov ->
            "Νοε"

        Dec ->
            "Δεκ"


{-| Month full name.
-}
monthName : Month -> String
monthName month =
    case month of
        Jan ->
            "Ιανουαρίου"

        Feb ->
            "Φεβρουαρίου"

        Mar ->
            "Μαρτίου"

        Apr ->
            "Απριλίου"

        May ->
            "Μαΐου"

        Jun ->
            "Ιουνίου"

        Jul ->
            "Ιουλίου"

        Aug ->
            "Αυγούστου"

        Sep ->
            "Σεπτεμβρίου"

        Oct ->
            "Οκτωβρίου"

        Nov ->
            "Νοεμβρίου"

        Dec ->
            "Δεκεμβρίου"


twelveHourPeriod : TwelveHourPeriod -> String
twelveHourPeriod period =
    case period of
        AM ->
            "π.μ."

        PM ->
            "μ.μ."


{-| No known special rules for Greek
-}
dayOfMonthWithSuffix : Bool -> Int -> String
dayOfMonthWithSuffix pad day =
    case day of
        _ ->
            (toString day)
