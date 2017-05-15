module Date.Extra.I18n.I_lt_lt exposing (..)

{-| Lithuanian values for day and month names.

@docs dayShort
@docs dayName
@docs monthShort
@docs monthName
@docs dayOfMonthWithSuffix

Copyright (c) 2016-2017 Robin Luiten

-}

import Date exposing (Day(..), Month(..))
import String exposing (padLeft)


{-| Day short name.
-}
dayShort : Day -> String
dayShort day =
    case day of
        Mon ->
            "Pr"

        Tue ->
            "An"

        Wed ->
            "Tr"

        Thu ->
            "Kt"

        Fri ->
            "Pn"

        Sat ->
            "Št"

        Sun ->
            "Sk"


{-| Day full name.
-}
dayName : Day -> String
dayName day =
    case day of
        Mon ->
            "Pirmadienis"

        Tue ->
            "Antradienis"

        Wed ->
            "Trečiadienis"

        Thu ->
            "Ketvirtadienis"

        Fri ->
            "Penktadienis"

        Sat ->
            "Šeštadienis"

        Sun ->
            "Sekmadienis"


{-| Month short name.
-}
monthShort : Month -> String
monthShort month =
    case month of
        Jan ->
            "Sau"

        Feb ->
            "Vas"

        Mar ->
            "Kov"

        Apr ->
            "Bal"

        May ->
            "Geg"

        Jun ->
            "Bir"

        Jul ->
            "Lie"

        Aug ->
            "Rgp"

        Sep ->
            "Rgs"

        Oct ->
            "Spa"

        Nov ->
            "Lap"

        Dec ->
            "Grd"


{-| Month full name.
-}
monthName : Month -> String
monthName month =
    case month of
        Jan ->
            "Sausio"

        Feb ->
            "Vasario"

        Mar ->
            "Kovo"

        Apr ->
            "Balandžio"

        May ->
            "Gegužės"

        Jun ->
            "Birželio"

        Jul ->
            "Liepos"

        Aug ->
            "Rugpjūčio"

        Sep ->
            "Rugsėjo"

        Oct ->
            "Spalio"

        Nov ->
            "Lapkričio"

        Dec ->
            "Gruodžio"


{-| Nothing to do here for Lithuanian.
-}
dayOfMonthWithSuffix : Bool -> Int -> String
dayOfMonthWithSuffix pad day =
    (toString day) ++ "."
