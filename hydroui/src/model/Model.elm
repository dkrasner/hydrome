module Model exposing (..)

import Mouse exposing (Position)


-- MODEL


type alias Model =
    { area : String
    , controller : ControllerModel
    }


model : Model
model =
    { area = "Landing"
    , controller = controllerModel
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
