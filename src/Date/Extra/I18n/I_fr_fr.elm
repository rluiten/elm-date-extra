module Date.Extra.I18n.I_fr_fr exposing (..)

{-| French values for day and month names.

@docs dayShort
@docs dayName
@docs monthShort
@docs monthName

Copyright (c) 2016 Bruno Girin
-}


import Date exposing (Day (..), Month (..))


{-| Day short name. -}
dayShort : Day -> String
dayShort day =
  case day of
    Mon -> "lun"
    Tue -> "mar"
    Wed -> "mer"
    Thu -> "jeu"
    Fri -> "ven"
    Sat -> "sam"
    Sun -> "dim"


{-| Day full name. -}
dayName : Day -> String
dayName day =
  case day of
    Mon -> "lundi"
    Tue -> "mardi"
    Wed -> "mercredi"
    Thu -> "jeudi"
    Fri -> "vendredi"
    Sat -> "samedi"
    Sun -> "dimanche"


{-| Month short name. -}
monthShort : Month -> String
monthShort month =
  case month of
    Jan -> "jan"
    Feb -> "fév"
    Mar -> "mar"
    Apr -> "avr"
    May -> "mai"
    Jun -> "jun"
    Jul -> "jul"
    Aug -> "aou"
    Sep -> "sep"
    Oct -> "oct"
    Nov -> "nov"
    Dec -> "déc"


{-| Month full name. -}
monthName : Month -> String
monthName month =
  case month of
    Jan -> "janvier"
    Feb -> "février"
    Mar -> "mars"
    Apr -> "avril"
    May -> "mai"
    Jun -> "juin"
    Jul -> "juillet"
    Aug -> "août"
    Sep -> "septembre"
    Oct -> "octobre"
    Nov -> "novembre"
    Dec -> "décembre"
