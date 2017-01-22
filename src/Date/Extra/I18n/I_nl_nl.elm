module Date.Extra.I18n.I_nl_nl exposing (..)

import Date exposing (Day(..), Month(..))


{-| Day short name.
-}
dayShort : Day -> String
dayShort day =
    case day of
        Mon ->
            "ma"

        Tue ->
            "di"

        Wed ->
            "wo"

        Thu ->
            "do"

        Fri ->
            "vr"

        Sat ->
            "za"

        Sun ->
            "zo"


{-| Day full name.
-}
dayName : Day -> String
dayName day =
    case day of
        Mon ->
            "maandag"

        Tue ->
            "dinsdag"

        Wed ->
            "woensdag"

        Thu ->
            "donderdag"

        Fri ->
            "vrijdag"

        Sat ->
            "zaterdag"

        Sun ->
            "zondag"


{-| Month short name.
-}
monthShort : Month -> String
monthShort month =
    case month of
        Jan ->
            "jan"

        Feb ->
            "feb"

        Mar ->
            "mrt"

        Apr ->
            "apr"

        May ->
            "mei"

        Jun ->
            "jun"

        Jul ->
            "jul"

        Aug ->
            "aug"

        Sep ->
            "sep"

        Oct ->
            "okt"

        Nov ->
            "nov"

        Dec ->
            "dec"


{-| Month full name.
-}
monthName : Month -> String
monthName month =
    case month of
        Jan ->
            "januari"

        Feb ->
            "februari"

        Mar ->
            "maart"

        Apr ->
            "april"

        May ->
            "mei"

        Jun ->
            "juni"

        Jul ->
            "juli"

        Aug ->
            "augustus"

        Sep ->
            "september"

        Oct ->
            "oktober"

        Nov ->
            "november"

        Dec ->
            "december"


dayOfMonthWithSuffix : Bool -> Int -> String
dayOfMonthWithSuffix _ day =
    toString day
