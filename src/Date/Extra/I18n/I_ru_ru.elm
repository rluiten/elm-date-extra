module Date.Extra.I18n.I_ru_ru exposing (..)

{-| Russian values for day and month names.

@docs dayShort
@docs dayName
@docs monthShort
@docs monthName
@docs dayOfMonthWithSuffix
@docs twelveHourPeriod

-}

import Date exposing (Day(..), Month(..))
import Date.Extra.TwelveHourClock exposing (TwelveHourPeriod(..))


{-| Day short name.
-}
dayShort : Day -> String
dayShort day =
    case day of
        Mon ->
            "пн."

        Tue ->
            "вт."

        Wed ->
            "ср."

        Thu ->
            "чт."

        Fri ->
            "пт."

        Sat ->
            "сб."

        Sun ->
            "вс."


{-| Day full name.
-}
dayName : Day -> String
dayName day =
    case day of
        Mon ->
            "понедельник"

        Tue ->
            "вторник"

        Wed ->
            "среда"

        Thu ->
            "четверг"

        Fri ->
            "пятница"

        Sat ->
            "суббота"

        Sun ->
            "воскресенье"


{-| Month short name.
sources:
<http://new.gramota.ru/spravka/buro/search-answer?s=242637>
<http://www.unicode.org/cldr/charts/28/summary/ru.html#1753>
-}
monthShort : Month -> String
monthShort month =
    case month of
        Jan ->
            "янв."

        Feb ->
            "февр."

        Mar ->
            "март"

        Apr ->
            "апр."

        May ->
            "май"

        Jun ->
            "июнь."

        Jul ->
            "июль."

        Aug ->
            "авг."

        Sep ->
            "сент."

        Oct ->
            "окт."

        Nov ->
            "нояб."

        Dec ->
            "дек."


{-| Month full name.
-}
monthName : Month -> String
monthName month =
    case month of
        Jan ->
            "январь"

        Feb ->
            "февраль"

        Mar ->
            "март"

        Apr ->
            "апрель"

        May ->
            "май"

        Jun ->
            "июнь"

        Jul ->
            "июль"

        Aug ->
            "август"

        Sep ->
            "сентябрь"

        Oct ->
            "октябрь"

        Nov ->
            "ноябрь"

        Dec ->
            "декабрь"


{-| 12-hour clock period (AM/PM) translation and formatting.
-}
twelveHourPeriod : TwelveHourPeriod -> String
twelveHourPeriod period =
    case period of
        AM ->
            "дп"

        PM ->
            "пп"


{-| Just convert to string
-}
dayOfMonthWithSuffix : Bool -> Int -> String
dayOfMonthWithSuffix pad day =
    case day of
        _ ->
            toString day
