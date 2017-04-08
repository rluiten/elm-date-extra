module Date.Extra.I18n.I_et_ee exposing (..)

{-| Estonian values for day and month names.

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
            "E"

        Tue ->
            "T"

        Wed ->
            "K"

        Thu ->
            "N"

        Fri ->
            "R"

        Sat ->
            "L"

        Sun ->
            "P"


{-| Day full name.
-}
dayName : Day -> String
dayName day =
    case day of
        Mon ->
            "esmaspäev"

        Tue ->
            "teisipäev"

        Wed ->
            "kolmapäev"

        Thu ->
            "neljapäev"

        Fri ->
            "reede"

        Sat ->
            "laupäev"

        Sun ->
            "pühapäev"


{-| Month short name.
-}
monthShort : Month -> String
monthShort month =
    case month of
        Jan ->
            "jaan"

        Feb ->
            "veebr"

        Mar ->
            "märts"

        Apr ->
            "apr"

        May ->
            "mai"

        Jun ->
            "juuni"

        Jul ->
            "juuli"

        Aug ->
            "aug"

        Sep ->
            "sept"

        Oct ->
            "okt"

        Nov ->
            "nov"

        Dec ->
            "dets"


{-| Month full name.
-}
monthName : Month -> String
monthName month =
    case month of
        Jan ->
            "jaanuar"

        Feb ->
            "veebruar"

        Mar ->
            "märts"

        Apr ->
            "aprill"

        May ->
            "mai"

        Jun ->
            "juuni"

        Jul ->
            "juuli"

        Aug ->
            "august"

        Sep ->
            "september"

        Oct ->
            "oktoober"

        Nov ->
            "november"

        Dec ->
            "detsember"


{-| Nothing to do here for Estonian.
-}
dayOfMonthWithSuffix : Bool -> Int -> String
dayOfMonthWithSuffix pad day =
    (toString day) ++ "."
