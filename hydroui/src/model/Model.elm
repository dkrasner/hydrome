module Model exposing (..)

import Mouse exposing (Position)


-- MODEL


type alias Model =
    { area : String
    , controllermodel : ControllerModel
    }


model : Model
model =
    { area = "Landing"
    , controllermodel = controllerModel
    }


controllerModel : ControllerModel
controllerModel =
    { position = Position 25 25
    , drag = Nothing
    }


type alias ControllerModel =
    { position : Position
    , drag : Maybe Drag
    }


type alias Drag =
    { start : Position
    , current : Position
    }
