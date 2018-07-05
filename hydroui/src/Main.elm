module Main exposing (..)

import Html
import Html exposing (..)
import View exposing (view)
import Update exposing (Msg, update)
import Model exposing (Model, model)
import Subscriptions exposing (..)


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
