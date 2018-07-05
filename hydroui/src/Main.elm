module Main exposing (..)

import Html
import Html exposing (..)
import View exposing (view)
import Update exposing (Msg, update)
import Model exposing (Model, model)


-- import Subscriptions exposing (..)


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = update

        -- , subscriptions = subscriptions
        }
