module Date.StringUtils where

{-| String Utils.

@docs trimRightChar

Copyright (c) 2016 Robin Luiten
-}

import String


{-| Trim a char from right of a if its there. -}
trimRightChar : Char -> String -> String
trimRightChar char str =
  let
    rts = String.reverse str
  in
    case String.uncons rts of
      Just (head, rest) ->
        if (char == head) then
          String.reverse rest
        else
          str
      Nothing ->
        str
