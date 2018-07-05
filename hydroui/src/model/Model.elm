module Model exposing (..)

import Draggable


-- MODEL


type alias Model =
    { area : String
    , controllerXY : Position
    , drag : Draggable.State String
    }


model : Model
model =
    { area = "Landing"
    , controllerXY = Position 200 200
    , drag = Draggable.init
    }


controllerModel : ControllerModel
controllerModel =
    { position = Position 25 25
    , drag = Draggable.init
    }


type alias Position =
    { x : Float
    , y : Float
    }


type alias ControllerModel =
    { position : Position
    , drag : Draggable.State String
    }
