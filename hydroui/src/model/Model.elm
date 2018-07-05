module Model exposing (..)

import Draggable


-- MODEL


type alias Position =
    { x : Float
    , y : Float
    }


type alias Model =
    { area : String
    , controllerXY : Position
    , drag : Draggable.State String
    }


model : Model
model =
    { area = "Landing"
    , controllerXY = Position 580 -250
    , drag = Draggable.init
    }
