module Date.Extra.I18n.I_de_de exposing (..)

{-| German values for day and month names.

@docs dayShort
@docs dayName
@docs monthShort
@docs monthName
@docs dayOfMonthWithSuffix

Copyright (c) 2017 Frank Schmitt

-}

import Date exposing (Day(..), Month(..))
import String exposing (padLeft)


{-| Day short name.
-}
dayShort : Day -> String
dayShort day =
    case day of
        Mon ->
            "Mo"

        Tue ->
            "Di"

        Wed ->
            "Mi"

        Thu ->
            "Do"

        Fri ->
            "Fr"

        Sat ->
            "Sa"

        Sun ->
            "So"


{-| Day full name.
-}
dayName : Day -> String
dayName day =
    case day of
        Mon ->
            "Montag"

        Tue ->
            "Dienstag"

        Wed ->
            "Mittwoch"

        Thu ->
            "Donnerstag"

        Fri ->
            "Freitag"

        Sat ->
            "Samstag"

        Sun ->
            "Sonntag"


{-| Month short name.
-}
monthShort : Month -> String
monthShort month =
    case month of
        Jan ->
            "Jan"

        Feb ->
            "Feb"

        Mar ->
            "Mär"

        Apr ->
            "Apr"

        May ->
            "Mai"

        Jun ->
            "Jun"

        Jul ->
            "Jul"

        Aug ->
            "Aug"

        Sep ->
            "Sep"

        Oct ->
            "Okt"

        Nov ->
            "Nov"

        Dec ->
            "Dez"


{-| Month full name.
-}
monthName : Month -> String
monthName month =
    case month of
        Jan ->
            "Januar"

        Feb ->
            "Februar"

        Mar ->
            "März"

        Apr ->
            "April"

        May ->
            "Mai"

        Jun ->
            "Juni"

        Jul ->
            "Juli"

        Aug ->
            "August"

        Sep ->
            "September"

        Oct ->
            "Oktober"

        Nov ->
            "November"

        Dec ->
            "Dezember"


{-| Nothing to do here for German
-}
dayOfMonthWithSuffix : Bool -> Int -> String
dayOfMonthWithSuffix pad day =
    (toString day) ++ "."
