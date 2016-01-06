# Date Extra Function

** Temporary github repository **

Collected and fairly tested date utilities created while working on a
date picker.


The format code originally came from and was modified and extended.
https://github.com/mgold/elm-date-format/blob/1.0.4/src/Date/Format.elm

Format.format is not fully integrated and a bit of an add on at the moment.
The date hack stuff with utc and offset stuff is new. There is likely a bunch of other
code that could be removed in favor of format when its stabilises with the modifications and interface I think will be required.


There is some fudging done to make timezone offset available in Elm without need it added at a native level. It may be a better idea to extend the
existing Native to cover this, not sure.

Put on github to have a backup, and to let people see it.

It will be published as a package eventually, but likely merged with something
else or under a different name or name space.


BDate.elm does not even compile, its some ideas around NodaTime concepts and organization with types.
