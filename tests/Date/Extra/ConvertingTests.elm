module Date.Extra.ConvertingTests where

{- Test conversion of dates

Copyright (c) 2016 Robin Luiten
-}
import Date exposing (Date)
import ElmTest exposing (..)


import Date.Extra.Format as Format


tests : Test
tests =
  suite "Date conversion tests"
    [ convertingDates
    ]


dateToISO = Format.utcIsoString


convertingDates : Test
convertingDates =
  suite
    "Converting a date to ISO String"
    [ test
        "output is exactly the same as iso input"
        (assertEqual
          (Ok "2016-03-22T17:30:00.000Z")
          (Date.fromString "2016-03-22T17:30:00.000Z" `Result.andThen` (Ok << dateToISO))
        )
    ]
