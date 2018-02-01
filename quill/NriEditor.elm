module NriEditor exposing (view)

import Html exposing (..)


{-
   TODO:

   - [ ] communicate editor contents to Elm
   - [ ] preload editor contents based on initial Elm mode
   - [ ] maybe add attributes to component to enable/disable formatting features?
-}


view : Html msg
view =
    node "nri-editor" [] []
