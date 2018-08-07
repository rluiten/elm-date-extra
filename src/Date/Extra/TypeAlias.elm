module Date.Extra.TypeAlias
    exposing
        ( DateFromFields
        , TimeFromFields
        )

{-| Extra types for sharing between Internal and External interface.

@docs TimeFromFields
@docs DateFromFields

Copyright (c) 2016-2018 Robin Luiten

-}

import Date exposing (Month(..))


{-| Alternate signature for Create.timeFromFields
-}
type alias TimeFromFields =
    { hour : Int
    , minute : Int
    , second : Int
    , millisecond : Int
    }


{-| Alternate signature for Create.dateFromFieldsRecord

See Core.inToMonth for converting an integer month to a Month.

-}
type alias DateFromFields =
    { year : Int
    , month : Month
    , day : Int
    , hour : Int
    , minute : Int
    , second : Int
    , millisecond : Int
    }
