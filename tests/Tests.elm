module Tests exposing (..)

import TestUtils exposing (getZoneOffsets)

_ =
    Debug.log "Tests Current Zone Offsets"
        (getZoneOffsets 2016)