{-| An example of adjusting the Config for Format.

Configure the month name produced when formatting dates.

This example modifies an existing Config but you can create
your own Config without using existing ones as well.

You can also use existing translations in the Date.Config.I18n namespace if
they match your language needs for your own config.

Copyright (c) 2016 Robin Luiten
-}

import Date
import Graphics.Element exposing (flow, down, leftAligned)
import String
import Text

import Date.Config.Config_en_au exposing (config)
import Date.Format as Format exposing (format)


{- Modify the i18n in config to change month names so they area reversed. -}
configReverseMonthName =
  let
    i18nCurrent = config.i18n
    i18nUpdated =
      { i18nCurrent
      | monthName = String.reverse << i18nCurrent.monthName
      }
  in
    { config
    | i18n = i18nUpdated
    }


{- See [DocFormat.md](../DocFormat.md) for token meanings. -}
myDateFormat = "%A, %e %B %Y"
formatOriginal = format config myDateFormat
formatReverseMonthName = format configReverseMonthName myDateFormat


{- Time 1407833631161.0 in utc is "2014-08-12 08:53:51.161" -}
testDate1 = Date.fromTime 1407833631161.0


{- This displays a list of strings on screen conveniently. -}
stringsToElement =
  flow down << (List.map (leftAligned << Text.fromString))


main =
  stringsToElement
    [ "Display String 1 en_au config \""
        ++ (formatOriginal testDate1)  ++ "\". "
    , "Display String 1 using modified reverse monthName config \""
        ++ (formatReverseMonthName testDate1)  ++ "\". "
    ]
