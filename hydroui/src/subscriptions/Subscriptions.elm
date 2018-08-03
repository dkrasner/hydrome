module Subscriptions exposing (..)

import Model exposing (Model, model)
import Messages exposing (Msg)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
