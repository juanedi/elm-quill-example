module Main exposing (..)

import Html exposing (..)


type alias Model =
    ()


type alias Msg =
    ()


main : Program Never Model Msg
main =
    Html.program
        { init = ( (), Cmd.none )
        , subscriptions = always Sub.none
        , view = view
        , update = update
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( (), Cmd.none )


view : Model -> Html Msg
view model =
    div
        []
        [ h1 [] [ text "Quill" ]
        , div [] []
        ]
