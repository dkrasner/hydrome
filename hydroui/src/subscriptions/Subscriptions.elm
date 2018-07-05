module Subscriptions exposing (..)

import Model exposing (Model, model)
import Update exposing (Msg)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
