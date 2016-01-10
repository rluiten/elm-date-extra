# Date Extra Function

### Introduction
A collection of modules for working with dates and times.

Example of formatting Dates
```elm
import Date.Config.Config_en_au exposing (config)
import Date.Format as Format exposing (format, formatUtc, isoMsecOffsetFormat)

displayString1 =
  Result.withDefault "Failed to get a date." <|
    Result.map
      (format config config.format.datetime)
      (Date.fromString "2015-06-01 12:45:14.211Z")


displayString2 =
  Result.withDefault "Failed to get a date." <|
    Result.map
      (formatUtc config isoMsecOffsetFormat)
      (Date.fromString "2015-06-01 12:45:14.211Z")
```

It is a start but it is by no means complete and there maybe many good things we can do to make it harder to do wrong things by leveraging Elm's types.

There is some fudging done to get timezone offset available in Elm without needing it be added at a native level. It may be a good idea in the future to introduce more access to javascript for more date functions or information.

See [DocFormat.md](DocFormat.md) for information about supported date format strings.

### Where did this come from.

This was created based upon code extracted from one of Robin's projects and put into  https://github.com/rluiten/elm-date-extra and from Luke's https://github.com/lukewestby/elm-date-extra/.

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

* Suggestions to improve API and or package structure or Types.
 * Particularly interested in improvements that might make it easier to work with dates more predictable and reproducible.
* More Examples for example folder
* Bugs
 * Please try to include sufficient detail to reproduce
 * Better yet create a test and submit a pull request, even if you cant figure out how to fix it.
* More tests
 * That demonstrate issues
 * That fill a short fall in existing tests.

## Change Warning.

Because this is new and many people are new to Elm and what can or should be done with its types to make developers lives better its quite likely the API may change quite a bit, so version numbers may climb rapidly.

## Future

I think there may be value in creating Types for each type of date. Types as covered in the Noda Time documentation such as `Instant`, `LocalTime` , `LocalDate`, `LocalDateTime`, `DateTimeZone`, `ZonedDateTime`, `Period` and `Duration`.

This library has a simple Period and Duration modules at the moment, I hope this is a step in the right direction and does not muddy the water.

In the long run this may require writing a date parser and introducing Elm native time zone structures in.


## People Using this library.

* Currently Robin on a new far from finished project. Only put this here because this section would be empty with out it.


## Useful references

http://momentjs.com/docs/
http://nodatime.org/1.3.x/userguide/
https://www.npmjs.com/package/timezonecomplete

Copyright (c) 2016 Robin Luiten
