module Main exposing (..)

import Html exposing (..)
import NriEditor
import Regex


type alias Model =
    { editor : NriEditor.State
    }


type Msg
    = EditorUpdate NriEditor.State


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , subscriptions = always Sub.none
        , view = view
        , update = update
        }


init : ( Model, Cmd Msg )
init =
    ( { editor = NriEditor.init }, Cmd.none )


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
        , NriEditor.view
            [ NriEditor.onChange EditorUpdate ]
        , div
            []
            [ span [] [ text <| "word count: " ++ (toString <| wordCount (NriEditor.rawText model.editor)) ]
            ]
        ]


wordCount : String -> Int
wordCount text =
    text
        |> Regex.find Regex.All (Regex.regex "\\w+")
        |> List.length
