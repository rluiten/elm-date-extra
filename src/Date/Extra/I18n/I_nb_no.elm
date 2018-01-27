module Date.Extra.I18n.I_nb_no exposing (..)

{-| Norwegian values for day and month names.

@docs dayShort
@docs dayName
@docs monthShort
@docs monthName
@docs dayOfMonthWithSuffix

Copyright (c) 2016 Ossi Hanhinen

-}

import Date exposing (Day(..), Month(..))


{-| Day short name.
-}
dayShort : Day -> String
dayShort day =
    case day of
        Mon ->
            "man"

        Tue ->
            "tir"

        Wed ->
            "ons"

        Thu ->
            "tor"

        Fri ->
            "fre"

        Sat ->
            "lør"

        Sun ->
            "søn"


{-| Day full name.
-}
dayName : Day -> String
dayName day =
    case day of
        Mon ->
            "mandag"

        Tue ->
            "tisdag"

        Wed ->
            "onsdag"

        Thu ->
            "torsdag"

        Fri ->
            "fredag"

        Sat ->
            "lørdag"

        Sun ->
            "søndag"


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
            "mar"

        Apr ->
            "apr"

        May ->
            "mai"

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
            "des"


{-| Month full name.
-}
monthName : Month -> String
monthName month =
    case month of
        Jan ->
            "januar"

        Feb ->
            "februar"

        Mar ->
            "mars"

        Apr ->
            "april"

        May ->
            "mai"

        Jun ->
            "juni"

        Jul ->
            "juli"

        Aug ->
            "august"

        Sep ->
            "september"

        Oct ->
            "oktober"

        Nov ->
            "november"

        Dec ->
            "desember"


{-| Nothing done here for now, but it might be needed
-}
dayOfMonthWithSuffix : Bool -> Int -> String
dayOfMonthWithSuffix pad day =
    case day of
        _ ->
            toString day
