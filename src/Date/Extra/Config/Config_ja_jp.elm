module Date.Extra.Config.Config_ja_jp exposing (..)

{-| This is the Japanese config for formatting dates.

@docs config

Copyright (c) 2017 Yosuke Torii
-}

import Date
import Date.Extra.Config as Config
import Date.Extra.I18n.I_ja_jp as Japanese


{-| Config for ja_jp. -}
config : Config.Config
config =
  { i18n =
      { dayShort = Japanese.dayShort
      , dayName = Japanese.dayName
      , monthShort = Japanese.monthShort
      , monthName = Japanese.monthName
      , dayOfMonthWithSuffix = Japanese.dayOfMonthWithSuffix
      }
  , format =
      { date = "%Y/%m/%d" -- yyyy/MM/dd
      , longDate = "%Y年%m月%d日(%a)" -- yyyy年MM月dd日(aaa)
      , time = "%H:%M" -- hh:mm
      , longTime = "%H時%M分%S秒" -- hh:mm:ss
      , dateTime = "%Y/%m/%d %H:%M"  -- date + time
      , firstDayOfWeek = Date.Mon
      }
  }
