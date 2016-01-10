{-| Comparing dates.

Copyright (c) 2016 Robin Luiten
-}

import Date
import Graphics.Element exposing (flow, down, leftAligned)
import Text

import Date.Compare as Compare exposing (is, Compare2 (..))


{- Time 1407833631161.0 in utc is "2014-08-12 08:53:51.161" -}
testDate1 = Date.fromTime 1407833631161.0


{- Time 1407833631162.0 in utc is "2014-08-12 08:53:51.162" -}
testDate2 = Date.fromTime 1407833631162.0


{- This displays a list of strings on screen conveniently. -}
stringListToElement =
  flow down << (List.map (leftAligned << Text.fromString))


main =
  stringListToElement
    [ "Test is date1 After date2 should be False and is = "
        ++ (toString (is After testDate1 testDate2)) ++ ". "
    , "Test is date1 Before date2 should be True and is = "
        ++ (toString (is Before testDate1 testDate2)) ++ ". "
    ]
