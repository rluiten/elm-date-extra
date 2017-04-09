module Date.Extra.Period
    exposing
        ( add
        , DeltaRecord
        , diff
        , Period(..)
        , toTicks
        , zeroDelta
        )

{-| Period is a fixed length of time. It is an elapsed time concept, which
does not include the concept of Years Months or Daylight saving variations.

Name of type concept copied from NodaTime.

@docs add
@docs diff
@docs Period
@docs DeltaRecord
@docs zeroDelta
@docs toTicks

Copyright (c) 2016-2017 Robin Luiten

-}

import Date exposing (Date)
import Date.Extra.Internal2 as Internal2


{-| A Period.

Week is a convenience for users if they want to use it, it does
just scale Day in functionality so is not strictly required.

DELTARECORD values are multiplied addend on application.

-}
type Period
    = Millisecond
    | Second
    | Minute
    | Hour
    | Day
    | Week
    | Delta DeltaRecord


{-| A multi granularity period delta.
-}
type alias DeltaRecord =
    { week : Int
    , day : Int
    , hour : Int
    , minute : Int
    , second : Int
    , millisecond : Int
    }


{-| All zero delta.
Useful as a starting point if you want to set a few fields only.
-}
zeroDelta : DeltaRecord
zeroDelta =
    { week = 0
    , day = 0
    , hour = 0
    , minute = 0
    , second = 0
    , millisecond = 0
    }


{-| Return tick counts for periods.
Useful to get total ticks in a Delta.
-}
toTicks : Period -> Int
toTicks period =
    case period of
        Millisecond ->
            Internal2.ticksAMillisecond

        Second ->
            Internal2.ticksASecond

        Minute ->
            Internal2.ticksAMinute

        Hour ->
            Internal2.ticksAnHour

        Day ->
            Internal2.ticksADay

        Week ->
            Internal2.ticksAWeek

        Delta delta ->
            (Internal2.ticksAMillisecond * delta.millisecond)
                + (Internal2.ticksASecond * delta.second)
                + (Internal2.ticksAMinute * delta.minute)
                + (Internal2.ticksAnHour * delta.hour)
                + (Internal2.ticksADay * delta.day)
                + (Internal2.ticksAWeek * delta.week)


{-| Add Period count to date.
-}
add : Period -> Int -> Date -> Date
add period =
    addTimeUnit (toTicks period)


{-| Add time units.
-}
addTimeUnit : Int -> Int -> Date -> Date
addTimeUnit unit addend date =
    date
        |> Internal2.toTime
        |> (+) (addend * unit)
        |> Internal2.fromTime


{-| Return a Period representing date difference. date1 - date2.

If you add the result of this function to date2 with addend of 1
will return date1.

-}
diff : Date -> Date -> DeltaRecord
diff date1 date2 =
    let
        ticksDiff =
            Internal2.toTime date1 - Internal2.toTime date2

        hourDiff =
            Date.hour date1 - Date.hour date2

        minuteDiff =
            Date.minute date1 - Date.minute date2

        secondDiff =
            Date.second date1 - Date.second date2

        millisecondDiff =
            Date.millisecond date1 - Date.millisecond date2

        ticksDayDiff =
            ticksDiff
                - (hourDiff * Internal2.ticksAnHour)
                - (minuteDiff * Internal2.ticksAMinute)
                - (secondDiff * Internal2.ticksASecond)
                - (millisecondDiff * Internal2.ticksAMillisecond)

        onlyDaysDiff =
            ticksDayDiff // Internal2.ticksADay

        ( weekDiff, dayDiff ) =
            if onlyDaysDiff < 0 then
                let
                    absDayDiff =
                        abs onlyDaysDiff
                in
                    ( negate (absDayDiff // 7)
                    , negate (absDayDiff % 7)
                    )
            else
                ( onlyDaysDiff // 7
                , onlyDaysDiff % 7
                )
    in
        { week = weekDiff
        , day = dayDiff
        , hour = hourDiff
        , minute = minuteDiff
        , second = secondDiff
        , millisecond = millisecondDiff
        }
