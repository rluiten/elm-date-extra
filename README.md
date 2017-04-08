# Date Extra Package

### Introduction

An Elm language package for working with dates and times.

See bottom of this document for important history notes.

### Code format

This project uses elm-format for formatting.

### Includes
* flexible formatting of dates into strings
 * It has support for outputting dates with other offsets than local by deriving a timezone offset for a dates.
 * simple i18n support for long and short Day and Month names.
 * see [DocFormat.md](DocFormat.md)
* compare dates
* add or subtract time periods on a date
 * When modifying dates using Duration Day, Week, Month, Year the
 library compensates for daylight saving hour varations it should
 behave very much like momentjs in its add subtract date field functions.
* date diff
 * this is simple at moment and limited to Period module and the date fields
  * `millisecond`, `second`, `minute`, `hour`, `day`, `week`
* A function similar in concept to `floor` for Floats for dates called `floor`
  for reducing date fields below a given date
  field granularity to its minimum value.
* Set date field module.


Example of formatting Dates
```elm
import Date.Extra.Config.Config_en_au exposing (config)
import Date.Extra.Format as Format exposing (format, formatUtc, isoMsecOffsetFormat)


displayString1 =
    Result.withDefault "Failed to get a date." <|
        Result.map
            (format config config.format.dateTime)
            (Date.fromString "2015-06-01 12:45:14.211Z")


displayString2 =
    Result.withDefault "Failed to get a date." <|
        Result.map
            (formatUtc config isoMsecOffsetFormat)
            (Date.fromString "2015-06-01 12:45:14.211Z")
```

It is a start but it is by no means complete and there maybe many good things we can do to make it harder to do wrong things by leveraging Elm's types.

There is some fudging done to get timezone offset available in Elm without needing it be added at a native level. It may be a good idea in the future to introduce more access to javascript for more date functions or information.

### Where did this come from.

This was created based upon code extracted from one of Robin's projects and also from Luke's https://github.com/lukewestby/elm-date-extra/ and put into  https://github.com/rluiten/elm-date-extra.

The date time format code originally came from
https://github.com/mgold/elm-date-format/ however I have modified it and hence any problems you discover with it in this package should be initially raised with me.

While there are tests they can't possible cover the range of what can be done with dates. In addition Elm is at the mercy of the underlying javascript Date implementation and that is likely to have impact as well.

### There be Dragons here. "Date's in General"

Please be warned that there are many ways to manipulate dates that produce basically incorrect results. This library does not yet have much in the way of prevention of doing the wrong thing.

Dates, times, timezones and offsets can make working with dates a challenge.

This library is quite new and even though it has tests and written in Elm it might eat your lunch if you are not careful.

## Feedback

It is hoped that with feedback from users and reviewers with deep Type-zen it will be possible to improve the API to reduce the chances of doing the wrong thing with out realising it.

#### Feedback that is of interest.

* Additional locale for the Configs section.
* Suggestions to improve API and or package structure or Types.
 * Particularly interested in improvements that might make it safer and easier to work with dates.
* More Examples for example folder
* Improved documentation.
* Bugs.
 * Please try to include sufficient detail to reproduce.
 * Better yet create a test and submit a pull request, even if you cant figure out how to fix it.
* More tests.
 * That demonstrate issues.
 * That fill a short fall in existing tests..

## Future

I think there may be value in creating Types for each type of date. Types as covered in the Noda Time documentation such as `Instant`, `LocalTime` , `LocalDate`, `LocalDateTime`, `DateTimeZone`, `ZonedDateTime`, `Period` and `Duration`.

This library has a simple Period and Duration modules at the moment, I hope this is a step in the right direction and does not muddy the water.

In the long run this may require writing a date parser and introducing Elm native time zone structures in.


## People Using this library.

* Currently Robin on a new far from finished project. Only put this here because this section would be empty with out it.
* Feel free to contact me to let me know you are using this library.

## Things to think abut for future development, not really a road map.

* Consider a range checking year inputs, javascript getFullYear() only claims
to work for years 1000 to 9999, this is probably a reasonable range for range
checking. In this case also check ranges for fromTime and toTime functions ?


## Useful references

Many ideas and concepts shamelessly borrowed from the following.

* http://momentjs.com/docs/
* http://nodatime.org/1.3.x/userguide/
* https://www.npmjs.com/package/timezonecomplete

## Testing

This uses elm-test for testing so install it if you dont have it.

* npm install -g elm-test

To run Tests

* elm-test

### History

Only major (and recent) changes are listed here.

* 2017/01/31 v8.2.0
 #### WARNING
 * ##### Changes the value of `Format.isoMsecOffsetFormat`
  * It now usses the %:z format token for zone offset which means  they
 now include ":" this now appears to be a better choice as it is
 moregenerally parsed by browsers see issue.   https://github.com/rluiten/elm-date-extra/issues/29.
 * ##### Changes result of `Format.isoString`
  * which uses `Format.isoMsecOffsetFormat`.

* 2016/07/25 8.0.0
 * Add new format codes to format output day of month with a language idiom suffix.
   * In English eg for 2015/04/02 '%-@d' outputs '2nd', '%@e' outputs ' 2nd'
 * Only English has an implementation in place, I have no idea if this idiom
 exists in other languages so French, Finish and Polish currently only
 output day of month as decimal integer.

Copyright (c) 2016-2017 Robin Luiten
