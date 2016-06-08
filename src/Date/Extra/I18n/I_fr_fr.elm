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
    Mon -> "Lun"
    Tue -> "Mar"
    Wed -> "Mer"
    Thu -> "Jeu"
    Fri -> "Ven"
    Sat -> "Sam"
    Sun -> "Dim"


{-| Day full name. -}
dayName : Day -> String
dayName day =
  case day of
    Mon -> "Lundi"
    Tue -> "Mardi"
    Wed -> "Mercredi"
    Thu -> "Jeudi"
    Fri -> "Vendredi"
    Sat -> "Samedi"
    Sun -> "Dimanche"


{-| Month short name. -}
monthShort : Month -> String
monthShort month =
  case month of
    Jan -> "Jan"
    Feb -> "Fév"
    Mar -> "Mar"
    Apr -> "Avr"
    May -> "Mai"
    Jun -> "Jun"
    Jul -> "Jul"
    Aug -> "Aou"
    Sep -> "Sep"
    Oct -> "Oct"
    Nov -> "Nov"
    Dec -> "Déc"


{-| Month full name. -}
monthName : Month -> String
monthName month =
  case month of
    Jan -> "Janvier"
    Feb -> "Février"
    Mar -> "Mars"
    Apr -> "Avril"
    May -> "Mai"
    Jun -> "Juin"
    Jul -> "Juillet"
    Aug -> "Août"
    Sep -> "Septembre"
    Oct -> "Octobre"
    Nov -> "Novembre"
    Dec -> "Décembre"
