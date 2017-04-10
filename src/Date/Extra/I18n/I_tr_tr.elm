module Date.Extra.I18n.I_tr_tr exposing (..)

{-| English values for day and month names.

@docs dayShort
@docs dayName
@docs monthShort
@docs monthName
@docs dayOfMonthWithSuffix

Copyright (c) 2017 Mehmet Köse

-}

import Date exposing (Day(..), Month(..))

{-| Day short name.
-}
dayShort : Day -> String
dayShort day =
    case day of
        Mon ->
            "Pzt"

        Tue ->
            "Sal"

        Wed ->
            "Çar"

        Thu ->
            "Per"

        Fri ->
            "Cum"

        Sat ->
            "Cmt"

        Sun ->
            "Paz"


{-| Day full name.
-}
dayName : Day -> String
dayName day =
    case day of
        Mon ->
            "Pazartesi"

        Tue ->
            "Salı"

        Wed ->
            "Çarşamba"

        Thu ->
            "Perşembe"

        Fri ->
            "Cuma"

        Sat ->
            "Cumartesi"

        Sun ->
            "Pazar"


{-| Month short name.
-}
monthShort : Month -> String
monthShort month =
    case month of
        Jan ->
            "Oca"

        Feb ->
            "Şub"

        Mar ->
            "Mar"

        Apr ->
            "Nis"

        May ->
            "May"

        Jun ->
            "Haz"

        Jul ->
            "Tem"

        Aug ->
            "Ağu"

        Sep ->
            "Eyl"

        Oct ->
            "Eki"

        Nov ->
            "Kas"

        Dec ->
            "Ara"


{-| Month full name.
-}
monthName : Month -> String
monthName month =
    case month of
        Jan ->
            "Ocak"

        Feb ->
            "Şubat"

        Mar ->
            "Mart"

        Apr ->
            "Nisan"

        May ->
            "Mayıs"

        Jun ->
            "Haziran"

        Jul ->
            "Temmuz"

        Aug ->
            "Ağustos"

        Sep ->
            "Eylül"

        Oct ->
            "Ekim"

        Nov ->
            "Kasım"

        Dec ->
            "Aralık"


{-| Nothing to do here for Turkish
-}

dayOfMonthWithSuffix : Bool -> Int -> String
dayOfMonthWithSuffix pad day =
    (toString day) ++ "."

