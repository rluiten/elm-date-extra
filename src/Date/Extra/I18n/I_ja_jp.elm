module Date.Extra.I18n.I_ja_jp exposing (..)

{-| Japanese values for day and month names.

@docs dayShort
@docs dayName
@docs monthShort
@docs monthName
@docs dayOfMonthWithSuffix

Copyright (c) 2017 Yosuke Torii

-}

import Date exposing (Day(..), Month(..))


{-| Day short name.
-}
dayShort : Day -> String
dayShort day =
    case day of
        Mon ->
            "月"

        Tue ->
            "火"

        Wed ->
            "水"

        Thu ->
            "木"

        Fri ->
            "金"

        Sat ->
            "土"

        Sun ->
            "日"


{-| Day full name.
-}
dayName : Day -> String
dayName day =
    case day of
        Mon ->
            "月曜日"

        Tue ->
            "火曜日"

        Wed ->
            "水曜日"

        Thu ->
            "木曜日"

        Fri ->
            "金曜日"

        Sat ->
            "土曜日"

        Sun ->
            "日曜日"


{-| Month short name.
-}
monthShort : Month -> String
monthShort month =
    case month of
        Jan ->
            "1"

        Feb ->
            "2"

        Mar ->
            "3"

        Apr ->
            "4"

        May ->
            "5"

        Jun ->
            "6"

        Jul ->
            "7"

        Aug ->
            "8"

        Sep ->
            "9"

        Oct ->
            "10"

        Nov ->
            "11"

        Dec ->
            "12"


{-| Month full name.
-}
monthName : Month -> String
monthName month =
    case month of
        Jan ->
            "1月"

        Feb ->
            "2月"

        Mar ->
            "3月"

        Apr ->
            "4月"

        May ->
            "5月"

        Jun ->
            "6月"

        Jul ->
            "7月"

        Aug ->
            "8月"

        Sep ->
            "9月"

        Oct ->
            "10月"

        Nov ->
            "11月"

        Dec ->
            "12月"


{-| No suffixes for Japanese
-}
dayOfMonthWithSuffix : Bool -> Int -> String
dayOfMonthWithSuffix pad day =
    case day of
        _ ->
            toString day
