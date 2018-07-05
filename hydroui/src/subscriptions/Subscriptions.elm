module Subscriptions exposing (..)

import Draggable
import Model exposing (Model, model)
import Update exposing (..)


subscriptions : Model -> Sub Msg
subscriptions { drag } =
    Draggable.subscriptions DragMsg drag
