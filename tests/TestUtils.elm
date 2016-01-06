module TestUtils where

{-| Useful for testing with ElmTest.

Copyright (c) 2016 Robin Luiten
-}
import Date exposing (Date)
import ElmTest exposing (..)
import Time exposing (Time)

import Date.Core as Core
import Date.Format as Format
import Date.Utils as DateUtils


dateStr = Format.isoString -- probably bad idea for now using.


{-| Helper for testing Date transform functions.
Time for comparison, as Date equality comparisons
in Elm dont work right as of 2016/01/01.
-}
assertDateFunc :
       String
    -> String
    -> (Date -> Date)
    -> Assertion
assertDateFunc inputDate expectedDate dateFunc =
  assertEqual
    ( Result.map
        Date.toTime
        (DateUtils.fromString expectedDate)
    )
    ( Result.map
        ( \testDate ->
            -- let _ = debugDumpDateFunc expectedDate testDate dateFunc
            -- in
            Date.toTime (dateFunc testDate)
        )
        ( let
            resultDate = DateUtils.fromString inputDate
            -- _ = Debug.log("assertDateFunc (inputDate, resultDate)")
            --   ( inputDate
            --   , case resultDate of
            --       Ok date -> Format.isoString date
            --       Err msg -> "Err " ++ msg
            --   )
          in
            resultDate
        )
    )


debugDumpDateFunc expectedDate testDate dateFunc =
  let
    _ = Debug.log("expectedDate")
      ( expectedDate
      , Result.map Core.toTime (DateUtils.fromString expectedDate)
      , Result.map Format.isoString (DateUtils.fromString expectedDate)
      )
    _ = Debug.log("testDate, toTime testDate")
      ( dateStr testDate
      , Date.toTime testDate
      )
    _ = Debug.log("dateFunc testDate, toTime dateFunc testDate")
      ( dateStr (dateFunc testDate)
      , Date.toTime (dateFunc testDate)
      )
  in
    True


{-| Helper to compare Results with an offset on there Ok value.
Initially created for makeDateTicksTest2.
-}
assertResultEqualWithOffset :
     Result String Float
  -> Result String Float
  -> Int
  -> Assertion
assertResultEqualWithOffset expected test offset =
  case expected of
    Ok expectedTicks ->
      case test of
        Ok testTicks ->
          let _ = Debug.log("ooo") (expectedTicks - testTicks)
          in
          assertEqual expectedTicks (testTicks + (toFloat offset))
        Err msg ->
          let
            _ = Debug.log ("assertResultEqualWithOffset Err ") (msg)
          in
            assert False
    Err msg ->
      let
        _ = Debug.log ("assertResultEqualWithOffset Err ") (msg)
      in
        assert False





logResultDate : String -> Result String Date -> Bool
logResultDate str result =
  case result of
    Ok date ->
      let _ = Debug.log(str) (Format.utcIsoString date)
      in  False
    Err msg ->
      let _ = Debug.log(str) ("Err " ++ msg)
      in  False


logDate : Date -> Date
logDate date =
  let
    _ = Debug.log("logDate") (Format.utcIsoString date)
  in
    date
