module Date.Extra.I18n.I_sv_se exposing (..)

{-| Swedish values for day and month names.

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
            "mån"

        Tue ->
            "tis"

        Wed ->
            "ons"

        Thu ->
            "tor"

        Fri ->
            "fre"

        Sat ->
            "lör"

        Sun ->
            "sön"


{-| Day full name.
-}
dayName : Day -> String
dayName day =
    case day of
        Mon ->
            "måndag"

        Tue ->
            "tisdag"

        Wed ->
            "onsdag"

        Thu ->
            "torsdag"

        Fri ->
            "fredag"

        Sat ->
            "lördag"

        Sun ->
            "lördag"


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
            "maj"

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
            "mars"

        Apr ->
            "april"

        May ->
            "maj"

        Jun ->
            "juni"

        Jul ->
            "juli"

        Aug ->
            "augusti"

        Sep ->
            "september"

        Oct ->
            "oktober"

        Nov ->
            "november"

        Dec ->
            "december"


{-| Nothing done here for now, but it might be needed
-}
dayOfMonthWithSuffix : Bool -> Int -> String
dayOfMonthWithSuffix pad day =
    case day of
        _ ->
            toString day
