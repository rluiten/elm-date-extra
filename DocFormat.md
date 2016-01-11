
## Format Strings

The module `Date.Extra.Format` exports

* `format : Config -> String -> Date -> String`.
* `formatUtc : Config -> String -> Date -> String`.
* `formatOffset : Config -> Int -> String -> Date -> String`.

The `Config` refers to the configuration of i18n and default strings for some basic localisation support.

The `Date` refers to Elm's standard [Date library](http://package.elm-lang.org/packages/elm-lang/core/latest/Date).

The input `String` may contain any of the following substrings, which will be expanded to parts of the date resultant string format of date

* `%Y` - 4 digit year, zero-padded
* `%m` - Zero-padded month of year, e.g. `"07"` for July
* `%B` - Full month name, e.g. `"July"`
* `%b` - Abbreviated month name, e.g. `"Jul"`
* `%d` - Zero-padded day of month, e.g `"02"`
* `%e` - Space-padded day of month, e.g `" 2"`
* `%a` - Day of week, abbreviated to three letters, e.g. `"Wed"`
* `%A` - Day of week in full, e.g. `"Wednesday"`
* `%H` - Hour of the day, 24-hour clock, zero-padded
* `%k` - Hour of the day, 24-hour clock, space-padded
* `%I` - Hour of the day, 12-hour clock, zero-padded
* `%l` - (lower ell) Hour of the day, 12-hour clock, space-padded
* `%p` - AM or PM
* `%P` - am or pm
* `%M` - Minute of the hour, zero-padded
* `%S` - Second of the minute, zero-padded
* `%L` - Milliseconds of a second, length 3 zero-padded
* `%z` - time zone offset format "(+/-)HHMM"
* `%:z` - time zone offset format "(+/-)HH:MM"
* `%%` - produces a `%`
