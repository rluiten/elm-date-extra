module BDate where

{-| Another Date, many functions. Though experiment around a type ?
-}

import Date exposing (Day, Date, Month)
import Date.I18n.En English

type alias BDateConfig =
  { -- i18n list of lookups Day, Month names for a start.
    i18n :
      { dayShort : Day -> String
      , dayName : Day -> String
      , monthShort : Month -> String
      , monthName : Month -> String
      }
  }

defaultConfig : BDateConfig
defaultConfig =
  { i18n =
      { isoDayShort : English.dayShort
      , isoDayName : English.dayName
      , monthShort : English.monthShort
      , monthName : English.monthName
      }
  }

{-| BDate

Queries
* From Noda Time using ticks it can represent years in range
 * 27000 BCE to around 31000 CE Gregorian
 * Arbitrarily going to BDate to +-9999 ?

BDate Constructors
* Instant
 * ticks since epoch, no offset, no zone, no calendar
 * for when something happened

-}
type BDate
  = Instant Int
  | LocalDate
  | LocalDateTime
  | BOffset Int Int -- offset, ticks
  | BZoned String -- timezone string





{-

IDEA:

case myDate of
  split date into parts.... in pattern
  
A record might be better can match on just field names wanted ?
- though it still does work of pulling it all apart

Joda-Time features:
* LocalDate - date without time
type LocalDateTime = ?

type LocalDate = ?

* LocalTime - time without date
type LocalTime = ?

* Instant - an instantaneous point on the time-line
type Instant = ?

* DateTime - full date and time with time-zone
type DateTime = ?

* DateTimeZone - a better time-zone
type DateTimeZone = ?

* Duration and Period - amounts of time

type Duration = ? -- its fixed time periods no Month, Year Stuff.
type Period = ? -- calendar based periods

* Interval - the time between two instants

* A comprehensive and flexible formatter-parser


Periods for actions on
  LocalDateTime, LocalDate LocalTime

Durations for actions on
  Intant, ZonedDateTime

  work fine but ZoneDatetime if you add time
  to something that moves into or out of daylight
  saving your answer isnt obvious....

  Then comparison betwen the types as needed
  by allowing typed parameters.


  Pull in tz database (olson database)
  Not sure format yet. maybe Decoder ?

-}
