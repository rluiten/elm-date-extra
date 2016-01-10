module Date.Config.Config_en_au where

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
      -- , longdate = "%A, %e %B %Y"
      , time = "%I:%M:%S %p"
      , datetime = "%d/%m/%Y %I:%M:%S %p"
      }
  }
