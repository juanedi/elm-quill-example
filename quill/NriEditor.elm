module NriEditor exposing (State, init, onChange, rawText, view)

import Html exposing (..)
import Html.Events as Events
import Json.Decode as Decode


type State
    = State { text : String }


type Attribute msg
    = Attr (Html.Attribute msg)



{-
   TODO:

   - [ ] communicate editor contents to Elm
     - [X] plainText
     - [ ] formatted document
   - [ ] preload editor contents based on initial Elm mode
   - [ ] maybe add attributes to component to enable/disable formatting features?
-}


init : State
init =
    State { text = "" }


onChange : (State -> msg) -> Attribute msg
onChange tagger =
    Attr <| Events.on "change" (Decode.map tagger stateDecoder)


rawText : State -> String
rawText (State state) =
    state.text


stateDecoder : Decode.Decoder State
stateDecoder =
    Decode.map
        (\value -> State { text = value })
        Events.targetValue


unattr : Attribute msg -> Html.Attribute msg
unattr (Attr attr) =
    attr


view : List (Attribute msg) -> Html msg
view attributes =
    node "nri-editor" (List.map unattr attributes) []
