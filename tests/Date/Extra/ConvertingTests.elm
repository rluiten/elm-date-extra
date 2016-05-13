module Date.Extra.ConvertingTests exposing (..)

{- Test conversion of dates

Copyright (c) 2016 Robin Luiten
-}
import Date exposing (Date)
import ElmTest exposing (..)


import Date.Extra.Config.Config_en_au exposing (config)
import Date.Extra.Format as Format exposing (format, formatUtc, isoMsecOffsetFormat)


tests : Test
tests =
  suite "Date conversion tests"
    [ convertingDates
    ]


robDateToISO = Format.utcIsoString


dateToISO : Date -> String
dateToISO date =
  formatUtc config isoMsecOffsetFormat date


convertingDates : Test
convertingDates =
  suite
    "Converting a date to ISO String"
    [ test
        "output is exactly the same as iso input v1"
        (assertEqual
          (Ok "2016-03-22T17:30:00.000+0000")
          (Date.fromString "2016-03-22T17:30:00.000Z" `Result.andThen` (Ok << dateToISO))
        )
    , test
      "output is exactly the same as iso input v2"
      (assertEqual
        (Ok "2016-03-22T17:30:00.000Z")
        (Date.fromString "2016-03-22T17:30:00.000Z" `Result.andThen` (Ok << robDateToISO)
      )
    )
    ]
