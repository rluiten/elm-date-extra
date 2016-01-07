# Date Extra Function

### Introduction
A bunch of date related functionality.

It is a start it is by no means complete and there maybe many good things we can do to make it harder to do wrong things by leveraging Elm's types.

It currently tries to assist with offsets but does not do any more time zone support than what Date.fromString does in its own way.

There is some fudging done to get timezone offset available in Elm without need it added at a native level. It may be a good idea in the future to introduce more access to javascript for more date functions or information.

### Provenance

This was created based upon code extracted from one of Robin's projects and put into  https://github.com/rluiten/elm-date-extra and from Luke's https://github.com/lukewestby/elm-date-extra/.

The date time format code originally came from
https://github.com/mgold/elm-date-format/ however I have modified it and hence any problems you discover with it in this package should be initially raised with me.

While there are tests they can't possible cover the range of what can be done with dates. In addition Elm is at the mercy of the underlying javascript Date implementation and that is likely to have impact as well.

### There be Dragons here. "Date's in General"

Please be warned that there are many ways to manipulate dates that produce basically incorrect results. This library does not yet have much in the way of prevention of doing the wrong thing.

Date, Time, DateTime, with or without offset and with or without Timezones make for an easily underestimated problem.

This library is quite new and even though it has tests and written in Elm it might eat your lunch if you do something the authors had not thought of, and I can promise you there is sufficient complexity in "dates" that there is a lot we have not thought of.

## Feedback, Suggestions

It is hoped that with feedback from users and reviewers with deep Type-zen it will be possible to improve the API to reduce the chances of doing the wrong thing with out realising it.

## Change Warning.

Because this is new and many people are new to Elm and what can or should be done with its types to make developers lives better its quite likely the API may change markedly for a while.

## Future

I think there may be value in creating Types for each type of date. Types as covered in the Noda Time documentation such as `Instant`, `LocalTime` , `LocalDate`, `LocalDateTime`, `DateTimeZone`, `ZonedDateTime`, `Period` and `Duration`.

We have a simple Period and Duration type at the moment, I am hope this is a step in the right direction and does not muddy the water.

In the long run this may require writing our own date parser and introducing Elm native time zone structures in.


## Useful references

http://momentjs.com/docs/
http://nodatime.org/1.3.x/userguide/
https://www.npmjs.com/package/timezonecomplete

Copyright (c) 2016 Robin Luiten
