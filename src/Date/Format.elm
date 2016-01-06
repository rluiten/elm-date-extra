module Date.Format where

{-| Date Format, turning dates into strings.

The format code originally came from and was modified and extended.
https://github.com/mgold/elm-date-format/blob/1.0.4/src/Date/Format.elm

## Notes
* formatUtc and formatOffset are very new and not well tested.
* hackDateAsUtc and hackDateAsOffset not sure should be exposed.

## Date presentation
@docs isoString
@docs isoDateString
@docs isoTimeString
@docs utcIsoString
@docs utcIsoDateString
@docs utcIsoTimeString
@docs format
@docs formatUtc
@docs formatOffset

## Date Hackery
@docs hackDateAsUtc
@docs hackDateAsOffset

## Useful strings for format
@docs isoFormat
@docs isoMsecFormat
@docs isoOffsetFormat
@docs isoMsecOffsetFormat
@docs isoDateFormat
@docs isoTimeFormat

Copyright (c) 2016 Robin Luiten
-}

import Date exposing (Date, Month) -- (Day, Date, Month)
import Regex
import String exposing (padLeft)

import Date.Core as Core
import Date.Create as Create
import Date.I18n.I_en_us as English

month : Date -> String
month date =
  padLeft 2 '0' <| toString (Core.monthToInt (Date.month date))


monthMonth : Month -> String
monthMonth month =
  padLeft 2 '0' <| toString (Core.monthToInt month)


year : Date -> String
year date =
  padLeft 4 '0' <| toString (Date.year date)


yearInt : Int -> String
yearInt year =
  padLeft 4 '0' <| toString year



{-| Return date and time as string.

This is very simple it does not support offsets
or timezones.
-}
isoString : Date -> String
isoString date =
  (isoDateString date) ++ "T" ++ (isoTimeString date)


{-| This is a bit hacky, but useful in several cases in testing
allready.

TODO the best thing might be to expand Date's native stuff so
offsets and such can be used in Elm.


Return a date string represenation of the date but compensates
for any time zone offset so the date is renderd in a utc time zone.

In my timezone javascript environment which is +10:00

Example hour is returned as 14 in my time zone.

```
  date = DateUtils.unsafeFromString "2016-06-05T04:03:02.111Z"

  Format.isoString date == "2016-06-05T14:03:02.111Z"
  DateUtils.utcIsoString date == "2016-06-05T04:03:02.111Z"
```

Offset support.
This may need underlying get date as if it was UTC function ugh.
Given utc datetime give me the normal local offset.

-}
utcIsoString : Date -> String
utcIsoString date =
  (isoString (hackDateAsUtc date)) ++ "Z"


{-| Utc variant of isoDateString. -}
utcIsoDateString : Date -> String
utcIsoDateString date =
  (isoDateString (hackDateAsUtc date)) ++ "Z"


{-| Utc variant of isoTimeString. -}
utcIsoTimeString : Date -> String
utcIsoTimeString date =
  (isoTimeString (hackDateAsUtc date)) ++ "Z"


{-| Return date as string. -}
isoDateString : Date -> String
isoDateString date =
  let
    year = Date.year date
    month = Date.month date
    day = Date.day date
  in
               (String.padLeft 2 '0' (toString year))
    --  ++ "-" ++ (toString month)
     ++ "-" ++ (String.padLeft 2 '0' (toString (Core.monthToInt month)))
     ++ "-" ++ (String.padLeft 2 '0' (toString day))


{-| Return time as string. -}
isoTimeString : Date -> String
isoTimeString date =
  let
    hour = Date.hour date
    minute = Date.minute date
    second = Date.second date
    millisecond = Date.millisecond date
  in
              (String.padLeft 2 '0' (toString hour))
    ++ ":" ++ (String.padLeft 2 '0' (toString minute))
    ++ ":" ++ (String.padLeft 2 '0' (toString second))
    ++ "." ++ (String.padLeft 3 '0' (toString millisecond))


{-| Adjust date as if it was in utc zone. -}
hackDateAsUtc : Date -> Date
hackDateAsUtc date =
  hackDateAsOffset (Create.getTimezoneOffset date) date


{-| Adjust date for time zone offset in minutes. -}
hackDateAsOffset : Int -> Date -> Date
hackDateAsOffset offsetMinutes date =
  Core.fromTime <| Core.toTime date + (offsetMinutes * Core.ticksAMinute)


{-| Useful iso date strings. -}
isoFormat = "%Y-%m-%dT%H:%M:%S"
{-| Useful iso date strings. -}
isoMsecFormat = "%Y-%m-%dT%H:%M:%S.%L"
{-| Useful iso date strings. -}
isoOffsetFormat = "%Y-%m-%dT%H:%M:%S%z"
{-| Useful iso date strings. -}
isoMsecOffsetFormat = "%Y-%m-%dT%H:%M:%S%z"
{-| Useful iso date strings. -}
isoDateFormat = "%Y-%m-%d"
{-| Useful iso date strings. -}
isoTimeFormat = "%H:%M:%S"


{- Date formatter.
Initially from.
https://github.com/mgold/elm-date-format/blob/1.0.4/src/Date/Format.elm
-}
formatRegex : Regex.Regex
formatRegex = Regex.regex "%(Y|m|B|b|d|e|A|a|H|k|I|l|p|P|M|S|%|L|z|:z)"


{-| Use a format string to format a date.
This gets time zone offset from provided date.
-}
format : String -> Date.Date -> String
format formatStr date =
  formatOffset (Create.getTimezoneOffset date) formatStr date


{-| Convert date to utc then format it with offset set to 0 if rendered. -}
formatUtc : String -> Date.Date -> String
formatUtc formatStr date =
  formatOffset (Create.getTimezoneOffset date) formatStr (hackDateAsUtc date)


{-| This adjusts date for offset, and renders with the offset -}
formatOffset : Int -> String -> Date.Date -> String
formatOffset offset formatStr date =
  (Regex.replace Regex.All formatRegex)
    (formatToken offset (hackDateAsOffset offset date))
    formatStr


formatToken : Int -> Date.Date -> Regex.Match -> String
formatToken offset d m =
  let
    symbol = List.head m.submatches |> collapse |> Maybe.withDefault " "
  in
    case symbol of
      "Y" -> d |> Date.year |> toString
      "m" -> d |> Date.month |> Core.monthToInt |> padWith '0'
      "B" -> d |> Date.month |> English.monthName
      "b" -> d |> Date.month |> English.monthShort
      "d" -> d |> Date.day |> padWith '0'
      "e" -> d |> Date.day |> padWith ' '
      "A" -> d |> Date.dayOfWeek |> English.dayName
      "a" -> d |> Date.dayOfWeek |> English.dayShort
      "H" -> d |> Date.hour |> padWith '0'
      "k" -> d |> Date.hour |> padWith ' '
      "I" -> d |> Date.hour |> mod12 |> padWith '0'
      "l" -> d |> Date.hour |> mod12 |> padWith ' '
      "p" -> if Date.hour d < 13 then "AM" else "PM"
      "P" -> if Date.hour d < 13 then "am" else "pm"
      "M" -> d |> Date.minute |> padWith '0'
      "S" -> d |> Date.second |> padWith '0'
      "L" -> d |> Date.millisecond |> padWithN 3 '0'
      "%" -> symbol
      "z" -> formatOffsetStr "" offset
      ":z" -> formatOffsetStr ":" offset
      _ -> ""


collapse : Maybe (Maybe a) -> Maybe a
collapse m = Maybe.andThen m identity


formatOffsetStr : String -> Int -> String
formatOffsetStr betweenHoursMinutes offset =
  let
    (hour, minute) = toHourMin (abs offset)
  in
    ( if offset <= 0 then
        "+" -- "+" is displayed for negative offset.
      else
        "-"
    )
    ++ (padWith '0' hour)
    ++ betweenHoursMinutes
    ++ (padWith '0' minute)


mod12 h = h % 12


padWith : Char -> a -> String
padWith c = padLeft 2 c << toString


padWithN : Int -> Char -> a -> String
padWithN n c = padLeft n c << toString


{- Return time zone offset in Hours and Minutes from minutes. -}
toHourMin : Int -> (Int, Int)
toHourMin offsetMinutes =
    (offsetMinutes // 60, offsetMinutes % 60)
