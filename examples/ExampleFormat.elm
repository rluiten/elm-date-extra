{-| An example of formatting dates.

Copyright (c) 2016 Robin Luiten
-}

import Date
import Graphics.Element exposing (flow, down, leftAligned)
import Text

import Date.Config.Config_en_au exposing (config)
import Date.Format as Format exposing (format, formatUtc, isoMsecOffsetFormat)


{- Configured format with config and format string.
* `config` is form the English Austrlian Config module.
* `config.format.datetime` is "%d/%m/%Y %H:%M:%S"
-}
displayString1 =
  Result.withDefault "Failed to get a date." <|
    Result.map
      (format config config.format.datetime)
      (Date.fromString "2015-06-01 12:45:14.211Z")


{- Configured formatUtc with config and format string.
`isoMsecOffsetFormat` is "%Y-%m-%dT%H:%M:%S.%L%z"
-}
displayString2 =
  Result.withDefault "Failed to get a date." <|
    Result.map
      (formatUtc config isoMsecOffsetFormat)
      (Date.fromString "2015-06-01 12:45:14.211Z")


{- This displays a list of strings on screen conveniently. -}
stringsToElement =
  flow down << (List.map (leftAligned << Text.fromString))


main =
  stringsToElement
    [ "Display String 1 Australian date time format \"" ++ displayString1 ++ "\". "
    , "Display String 2 UTC iso format \"" ++ displayString2 ++ "\". "
    ]
