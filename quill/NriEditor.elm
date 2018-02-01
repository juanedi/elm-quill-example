module NriEditor exposing (State, document, init, onChange, rawText, view)

import Html exposing (..)
import Html.Events as Events
import Json.Decode as Decode
import Json.Encode as Encode


type State
    = State Content


type alias Content =
    { text : String
    , document : Decode.Value
    }


type Attribute msg
    = Attr (Html.Attribute msg)



{-
   TODO:
     - [ ] preload editor contents based on elm model
     - [ ] maybe add attributes to component to enable/disable formatting features?
-}


init : State
init =
    State
        { text = ""
        , document = Encode.string ""
        }


onChange : (State -> msg) -> Attribute msg
onChange tagger =
    Attr <| Events.on "change" (Decode.map tagger stateDecoder)


rawText : State -> String
rawText (State state) =
    state.text


document : State -> Decode.Value
document (State state) =
    state.document


stateDecoder : Decode.Decoder State
stateDecoder =
    Decode.at [ "target", "value" ] <|
        Decode.map State <|
            Decode.map2 Content
                (Decode.field "text" Decode.string)
                (Decode.field "document" Decode.value)


unattr : Attribute msg -> Html.Attribute msg
unattr (Attr attr) =
    attr


view : List (Attribute msg) -> Html msg
view attributes =
    node "nri-editor" (List.map unattr attributes) []
