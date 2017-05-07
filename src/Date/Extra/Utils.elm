module Date.Extra.Utils
    exposing
        ( unsafeFromString
        , dayList
        , isoWeek
        , isoWeekOne
        )

{-| Date Utils.

2016/14/23 `fromString` was removed as its extra date validity checking had problems in
many timezones so it became the same as `Date.fromString`.


## Date parsing

**Be careful with unsafeFromString it will Debug.crash() if it cant parse date.**
@docs unsafeFromString


## Utility

@docs dayList
@docs isoWeek
@docs isoWeekOne

Copyright (c) 2016-2017 Robin Luiten

-}

import Date exposing (Day(..), Date, Month(..))
import Regex
import String
import Time
import Date.Extra.Compare as Compare exposing (is, Compare2(..))
import Date.Extra.Core as Core
import Date.Extra.Create as Create
import Date.Extra.Duration as Duration
import Date.Extra.Format as Format
import Date.Extra.TimeUnit as TimeUnit


{-| Return a list of days dayLength long for successive days
starting from startDate.

Now adds 1 day if dayCount is +ve to create day list.
Now subtracts 1 day if dayCount is -ve to create day list.

This could be made much faster by using `daysFromCivil`
and not using underlying date system at all I believe.

-}
dayList : Int -> Date -> List Date
dayList dayCount startDate =
    List.reverse (dayList_ dayCount startDate [])


dayList_ : Int -> Date -> List Date -> List Date
dayList_ dayCount date list =
    if dayCount == 0 then
        list
    else if dayCount > 0 then
        dayList_
            (dayCount - 1)
            (Duration.add Duration.Day 1 date)
            (date :: list)
    else
        dayList_
            (dayCount + 1)
            (Duration.add Duration.Day -1 date)
            (date :: list)


{-| Return iso week values year, week, isoDayOfWeek.
Input date is expected to be in local time zone of vm.
-}
isoWeek : Date -> ( Int, Int, Int )
isoWeek date =
    let
        ( year, isoWeek1Date ) =
            getYearIsoWeekDate date

        daysSinceIsoWeek1 =
            Duration.diffDays date isoWeek1Date
    in
        ( year
        , (daysSinceIsoWeek1 // 7) + 1
        , Core.isoDayOfWeek (Date.dayOfWeek date)
        )


getYearIsoWeekDate date =
    let
        inputYear =
            Date.year date

        maxIsoWeekDateInYear =
            Create.dateFromFields inputYear Date.Dec 29 0 0 0 0
    in
        if is SameOrAfter date maxIsoWeekDateInYear then
            let
                nextYearIsoWeek1Date =
                    isoWeekOne (inputYear + 1)
            in
                if is Before date nextYearIsoWeek1Date then
                    ( inputYear, isoWeekOne inputYear )
                else
                    ( inputYear + 1, nextYearIsoWeek1Date )
        else
            let
                thisYearIsoWeek1Date =
                    isoWeekOne inputYear
            in
                if is Before date thisYearIsoWeek1Date then
                    ( inputYear - 1, isoWeekOne (inputYear - 1) )
                else
                    ( inputYear, thisYearIsoWeek1Date )


{-| Reference point for isoWeekOne.
-}
isoDayofWeekMonday =
    Core.isoDayOfWeek Date.Mon


{-| Return date of start of ISO week one for given year.
-}
isoWeekOne : Int -> Date
isoWeekOne year =
    let
        dateJan4 =
            Create.dateFromFields year Jan 4 0 0 0 0
    in
        Duration.add
            Duration.Day
            (isoDayofWeekMonday - (Core.isoDayOfWeek (Date.dayOfWeek dateJan4)))
            dateJan4


{-| Utility for known input string date creation cases.
Checks for a fail just in case and calls Debug.crash().
-}
unsafeFromString : String -> Date
unsafeFromString dateStr =
    case Date.fromString dateStr of
        Ok date ->
            date

        Err msg ->
            Debug.crash ("unsafeFromString")
