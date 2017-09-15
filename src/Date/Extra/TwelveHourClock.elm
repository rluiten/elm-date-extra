module Date.Extra.TwelveHourClock
    exposing
        ( TwelveHourPeriod(..)
        , twelveHourPeriod
        )

{-| Definition of 12-Hour clock and AM/PMv alue for dates.
@docs TwelveHourPeriod
@docs twelveHourPeriod
-}

import Date


{-| 12-Hour clock abbreviations (AM/PM)
-}
type TwelveHourPeriod
    = AM
    | PM


{-| Common Date to AM/PM value.
-}
twelveHourPeriod : Date.Date -> TwelveHourPeriod
twelveHourPeriod d =
    if Date.hour d < 12 then
        AM
    else
        PM
