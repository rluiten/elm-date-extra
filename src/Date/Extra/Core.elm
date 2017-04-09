module Date.Extra.Core
    exposing
        ( daysInMonth
        , daysInNextMonth
        , daysInPrevMonth
        , daysInMonthDate
        , daysBackToStartOfWeek
        , epochDateStr
        , firstOfNextMonthDate
        , fromTime
        , intToMonth
        , isLeapYear
        , isLeapYearDate
        , isoDayOfWeek
        , lastOfMonthDate
        , lastOfPrevMonthDate
        , monthList
        , monthToInt
        , nextDay
        , nextMonth
        , prevDay
        , prevMonth
        , ticksAnHour
        , ticksADay
        , ticksAMillisecond
        , ticksAMinute
        , ticksASecond
        , ticksAWeek
        , toFirstOfMonth
        , toTime
        , yearToDayLength
        )

{-| Date core.


## Info

@docs monthToInt
@docs intToMonth
@docs daysInMonth
@docs monthList
@docs daysInNextMonth
@docs daysInPrevMonth
@docs daysInMonthDate
@docs isLeapYear
@docs isLeapYearDate
@docs yearToDayLength
@docs isoDayOfWeek


## Utility

@docs toFirstOfMonth
@docs firstOfNextMonthDate
@docs lastOfMonthDate
@docs lastOfPrevMonthDate
@docs daysBackToStartOfWeek


## Conversion

@docs fromTime
@docs toTime


## Iteration Utility

@docs nextDay
@docs prevDay
@docs nextMonth
@docs prevMonth


## Date constants

@docs epochDateStr


## Date constants

@docs ticksAMillisecond
@docs ticksASecond
@docs ticksAMinute
@docs ticksAnHour
@docs ticksADay
@docs ticksAWeek

Copyright (c) 2016-2017 Robin Luiten

-}

import Date exposing (Date, Day(..), Month(..))
import Time
import Date.Extra.Internal as Internal
import Date.Extra.Internal2 as Internal2
import Date.Extra.Period as Period


{-| Return days in month for year month.
-}
daysInMonth : Int -> Month -> Int
daysInMonth =
    Internal2.daysInMonth


{-| Return days in next calendar month.
-}
daysInNextMonth : Date -> Int
daysInNextMonth =
    Internal2.daysInNextMonth


{-| Return days in next calendar month.
-}
daysInPrevMonth : Date -> Int
daysInPrevMonth =
    Internal2.daysInPrevMonth


{-| Days in month for given date.
-}
daysInMonthDate : Date -> Int
daysInMonthDate =
    Internal2.daysInMonthDate


{-| Epoch starting point for tick 0.
-}
epochDateStr : String
epochDateStr =
    Internal2.epochDateStr


{-| Convenience fromTime as time ticks are Elm Ints in this library.
-}
fromTime : Int -> Date
fromTime =
    Internal2.fromTime


{-| Return integer as month. Jan <= 1 Feb == 2 up to Dec > 11.
-}
intToMonth : Int -> Month
intToMonth =
    Internal2.intToMonth


{-| Return True if Year is a leap year.
-}
isLeapYear : Int -> Bool
isLeapYear =
    Internal2.isLeapYear


{-| Return True if Year of Date is a leap year.
-}
isLeapYearDate : Date -> Bool
isLeapYearDate =
    Internal2.isLeapYearDate


{-| Return the Iso DayOfWeek Monday 1, to Sunday 7.
-}
isoDayOfWeek : Date.Day -> Int
isoDayOfWeek =
    Internal2.isoDayOfWeek


{-| List of months in order from Jan to Dec.
-}
monthList : List Month
monthList =
    Internal2.monthList


{-| Return month as integer. Jan = 1 to Dec = 12.
-}
monthToInt : Month -> Int
monthToInt =
    Internal2.monthToInt


{-| Return next day in calendar sequence.
-}
nextDay : Day -> Day
nextDay =
    Internal2.nextDay


{-| Return next month in calendar sequence.
-}
nextMonth : Month -> Month
nextMonth =
    Internal2.nextMonth


{-| Return previous day in calendar sequence.
-}
prevDay : Day -> Day
prevDay =
    Internal2.prevDay


{-| Return previous month in calendar sequence.
-}
prevMonth : Month -> Month
prevMonth =
    Internal2.prevMonth


{-| Ticks in an hour.
-}
ticksAnHour : Int
ticksAnHour =
    Internal2.ticksAnHour


{-| Ticks in a day.
-}
ticksADay : Int
ticksADay =
    Internal2.ticksADay


{-| Ticks in a millisecond. (this is 1 on Win 7 in Chrome)
-}
ticksAMillisecond : Int
ticksAMillisecond =
    Internal2.ticksAMillisecond


{-| Ticks in a minute.
-}
ticksAMinute : Int
ticksAMinute =
    Internal2.ticksAMinute


{-| Ticks in a second.
-}
ticksASecond : Int
ticksASecond =
    Internal2.ticksASecond


{-| Ticks in a week.
-}
ticksAWeek : Int
ticksAWeek =
    Internal2.ticksAWeek


{-| Convenience toTime as time ticks are Elm Ints in this library.
-}
toTime : Date -> Int
toTime =
    Internal2.toTime


{-| Return number of days in a year.
-}
yearToDayLength : Int -> Int
yearToDayLength =
    Internal2.yearToDayLength


{-| Return first of next month date.
-}
firstOfNextMonthDate : Date -> Date
firstOfNextMonthDate date =
    compensateZoneOffset
        date
        (Internal2.firstOfNextMonthDate date)


{-| Return last of previous month date.
-}
lastOfPrevMonthDate : Date -> Date
lastOfPrevMonthDate date =
    compensateZoneOffset
        date
        (Internal2.lastOfPrevMonthDate date)


{-| Return date of first of month.
-}
toFirstOfMonth : Date -> Date
toFirstOfMonth date =
    compensateZoneOffset
        date
        (Internal2.fromTime (Internal2.firstOfMonthTicks date))


{-| Resturn date of last day of month.
-}
lastOfMonthDate : Date -> Date
lastOfMonthDate date =
    compensateZoneOffset
        date
        (Internal2.fromTime (Internal2.lastOfMonthTicks date))


{-| Adjust value of date2 compensating for a time zone offset difference
between date1 and date2. This is used for cases where date2 is created based
on date1 but crosses day light saving boundary.
-}
compensateZoneOffset date1 date2 =
    Period.add
        Period.Minute
        ((Internal.getTimezoneOffset date2)
            - (Internal.getTimezoneOffset date1)
        )
        date2


{-| Return number of days back to start of week day.

First parameter Date.day - is current day of week.
Second parameter Date.day - is start day of week.

-}
daysBackToStartOfWeek : Date.Day -> Date.Day -> Int
daysBackToStartOfWeek dateDay startOfWeekDay =
    let
        dateDayIndex =
            isoDayOfWeek dateDay

        startOfWeekDayIndex =
            isoDayOfWeek startOfWeekDay
    in
        if dateDayIndex < startOfWeekDayIndex then
            (7 + dateDayIndex) - startOfWeekDayIndex
        else
            dateDayIndex - startOfWeekDayIndex
