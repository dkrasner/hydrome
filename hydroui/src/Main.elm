module Main exposing (..)

import Html
import View exposing (view)
import Update exposing (update)
import Messages exposing (Msg)
import Model exposing (Model, model)
import Subscriptions exposing (subscriptions)


init : ( Model, Cmd Msg )
init =
    ( model, Cmd.none )


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
