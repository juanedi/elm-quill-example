module Editor
    exposing
        ( Document
        , State
        , document
        , documentDecoder
        , init
        , initWithContent
        , onChange
        , rawText
        , view
        )

import Html exposing (..)
import Html.Attributes exposing (property)
import Html.Events as Events
import Json.Decode as Decode
import Json.Encode as Encode


type State
    = State Content


type alias Content =
    { text : String
    , document : Document
    }


type Attribute msg
    = Attr (Html.Attribute msg)


type alias Document =
    Decode.Value



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


initWithContent : Document -> State
initWithContent content =
    State
        { -- TODO: represent initializing state in which there is no text yet
          text = ""
        , document = content
        }


onChange : (State -> msg) -> Attribute msg
onChange tagger =
    Attr <| Events.on "change" (Decode.map tagger stateDecoder)


rawText : State -> String
rawText (State state) =
    state.text


document : State -> Document
document (State state) =
    state.document


stateDecoder : Decode.Decoder State
stateDecoder =
    Decode.at [ "target", "value" ] <|
        Decode.map State <|
            Decode.map2 Content
                (Decode.field "text" Decode.string)
                (Decode.field "document" documentDecoder)


documentDecoder : Decode.Decoder Document
documentDecoder =
    Decode.value


unattr : Attribute msg -> Html.Attribute msg
unattr (Attr attr) =
    attr


view : List (Attribute msg) -> State -> Html msg
view attributes (State state) =
    node "quill-editor"
        (property "value" state.document :: List.map unattr attributes)
        []
