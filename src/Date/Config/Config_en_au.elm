module Date.Config.Config_en_us where

{-| This is the default english config for formatting dates.

@docs config

Copyright (c) 2016 Robin Luiten
-}

import Date.Config as Config
import Date.I18n.I_en_us as English


{-| Config for en-au -}
config : Config.Config
config =
  { i18n =
      { dayShort = English.dayShort
      , dayName = English.dayName
      , monthShort = English.monthShort
      , monthName = English.monthName
      }
  , format =
      { date = "%d/%m/%Y" -- DD/MM/YYY
      , time = "%H:%M:%S"
      , datetime = "%d/%m/%Y %H:%M:%S"
      }
  }
