module Date.Extra.I18n.I_ru_ru exposing (..)

{-| Russian values for day and month names.

@docs dayShort
@docs dayName
@docs monthShort
@docs monthName
@docs dayOfMonthWithSuffix

Copyright (c) 2017 Slava Turchaninov

-}

import Date exposing (Day(..), Month(..))
import String exposing (padLeft)


{-| Day short name.
-}
dayShort : Day -> String
dayShort day =
    case day of
        Mon ->
            "Пн"

        Tue ->
            "Вт"

        Wed ->
            "Ср"

        Thu ->
            "Чт"

        Fri ->
            "Пт"

        Sat ->
            "Сб"

        Sun ->
            "Вс"


{-| Day full name.
-}
dayName : Day -> String
dayName day =
    case day of
        Mon ->
            "Понедельник"

        Tue ->
            "Вторник"

        Wed ->
            "Среда"

        Thu ->
            "Четверг"

        Fri ->
            "Пятница"

        Sat ->
            "Суббота"

        Sun ->
            "Воскресенье"


{-| Month short name.
-}
monthShort : Month -> String
monthShort month =
    case month of
        Jan ->
            "Янв"

        Feb ->
            "Фев"

        Mar ->
            "Мар"

        Apr ->
            "Апр"

        May ->
            "Май"

        Jun ->
            "Июн"

        Jul ->
            "Июл"

        Aug ->
            "Авг"

        Sep ->
            "Сен"

        Oct ->
            "Окт"

        Nov ->
            "Ноя"

        Dec ->
            "Дек"


{-| Month full name.
-}
monthName : Month -> String
monthName month =
    case month of
        Jan ->
            "Январь"

        Feb ->
            "Февраль"

        Mar ->
            "Март"

        Apr ->
            "Апрель"

        May ->
            "Май"

        Jun ->
            "Июнь"

        Jul ->
            "Июль"

        Aug ->
            "Август"

        Sep ->
            "Сентябрь"

        Oct ->
            "Октябрь"

        Nov ->
            "Ноябрь"

        Dec ->
            "Декабрь"


{-| Just convert to string
-}
dayOfMonthWithSuffix : Bool -> Int -> String
dayOfMonthWithSuffix pad day =
    case day of
        _ ->
            (toString day)
