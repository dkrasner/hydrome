module Model exposing (..)

import Array exposing (Array, fromList)
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
    , hydroModels : Array HydroModel
    , hydroDomains : Array HydroDomain
    , stageModel : Maybe HydroModel
    , stageDomain : Maybe HydroDomain
    }


type alias HydroModel =
    { name : String
    , args : List String
    , id : Int
    }


type alias HydroDomain =
    { name : String
    , id : Int
    }


model : Model
model =
    { area = "Landing"
    , controllerXY = Position 580 -250
    , drag = Draggable.init
    , hydroModels = allModels -- TODO! remove
    , hydroDomains = allDomains -- TODO! remove
    , stageModel = Nothing
    , stageDomain = Nothing
    }



-- TODO: temp holder for models/domain, get from api later


allModels : Array HydroModel
allModels =
    Array.map hydroModel (Array.initialize 10 identity)


allDomains : Array HydroDomain
allDomains =
    Array.map hydroDomain (Array.initialize 10 identity)


hydroDomain : Int -> HydroDomain
hydroDomain did =
    let
        name =
            "HydroDomain" ++ toString did
    in
        { name = name
        , id = did
        }


hydroModel : Int -> HydroModel
hydroModel mid =
    let
        name =
            "HydroModel" ++ toString mid
    in
        { name = name
        , args = [ "a1", "a2", "a3" ]
        , id = mid
        }
