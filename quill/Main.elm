module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (style)
import Json.Encode as Encode
import NriEditor
import Regex


type alias Model =
    { editor : NriEditor.State
    }


type Msg
    = EditorUpdate NriEditor.State


main : Program Encode.Value Model Msg
main =
    Html.programWithFlags
        { init = init
        , subscriptions = always Sub.none
        , view = view
        , update = update
        }


init : Encode.Value -> ( Model, Cmd Msg )
init document =
    ( { editor = NriEditor.initWithContent document }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        EditorUpdate editor ->
            ( { model | editor = editor }, Cmd.none )


view : Model -> Html Msg
view model =
    div
        []
        [ h1 [] [ text "Quill" ]
        , div [ style [ ( "display", "flex" ), ( "width", "100%" ) ] ]
            [ div [ style [ ( "flex", "2" ) ] ]
                [ NriEditor.view [ NriEditor.onChange EditorUpdate ]
                    model.editor
                ]
            , div [ style [ ( "flex", "1" ) ] ]
                [ viewDocumentInspector model.editor
                ]
            ]
        ]


viewDocumentInspector : NriEditor.State -> Html msg
viewDocumentInspector editor =
    div
        []
        [ div []
            [ h2 [] [ text <| "word count: " ++ (toString <| wordCount (NriEditor.rawText editor)) ]
            ]
        , div []
            [ h2 [] [ text "document" ]
            , pre [] [ text <| Encode.encode 2 (NriEditor.document editor) ]
            ]
        ]


wordCount : String -> Int
wordCount text =
    text
        |> Regex.find Regex.All (Regex.regex "\\w+")
        |> List.length
