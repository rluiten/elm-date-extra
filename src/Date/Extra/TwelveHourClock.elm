module Date.Extra.TwelveHourClock
    exposing
        ( TwelveHourPeriod(..)
        , twelveHourPeriod
        )

import Date


-- 12-Hour Clock --


{-| 12-Hour clock abbreviations (AM/PM)
-}
type TwelveHourPeriod
    = AM
    | PM


twelveHourPeriod : Date.Date -> TwelveHourPeriod
twelveHourPeriod d =
    if Date.hour d < 12 then
        AM
    else
        PM
