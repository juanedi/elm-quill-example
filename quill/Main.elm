module Main exposing (..)

import Editor
import Html exposing (..)
import Html.Attributes exposing (style)
import Json.Encode as Encode
import Regex


type alias Model =
    { editor : Editor.State
    }


type Msg
    = EditorUpdate Editor.State


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
    ( { editor = Editor.initWithContent document }
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
        [ h1 [] [ text "Elm + Quill + CustomElement" ]
        , div [ style [ ( "display", "flex" ), ( "width", "100%" ) ] ]
            [ div [ style [ ( "flex", "2" ) ] ]
                [ Editor.view [ Editor.onChange EditorUpdate ]
                    model.editor
                ]
            , div [ style [ ( "flex", "1" ) ] ]
                [ viewDocumentInspector model.editor
                ]
            ]
        ]


viewDocumentInspector : Editor.State -> Html msg
viewDocumentInspector editor =
    div
        []
        [ div []
            [ h2 [] [ text <| "word count: " ++ (toString <| wordCount (Editor.rawText editor)) ]
            ]
        , div []
            [ h2 [] [ text "document" ]
            , pre [] [ text <| Encode.encode 2 (Editor.document editor) ]
            ]
        ]


wordCount : String -> Int
wordCount text =
    text
        |> Regex.find Regex.All (Regex.regex "\\w+")
        |> List.length
