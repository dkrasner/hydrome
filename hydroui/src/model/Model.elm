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
    , hydroModels : List HydroModel
    , hydroDomains : List HydroDomain
    , stageModel : HydroModel
    , stageDomain : HydroDomain
    }


type alias HydroModel =
    { name : String
    , args : List String
    }


type alias HydroDomain =
    { name : String
    }


model : Model
model =
    { area = "Landing"
    , controllerXY = Position 580 -250
    , drag = Draggable.init
    , hydroModels =
        [ hydroModel1
        , hydroModel2
        , hydroModel3
        , hydroModel
        , hydroModel
        , hydroModel
        , hydroModel
        ]
    , hydroDomains =
        [ hydroDomain1
        , hydroDomain2
        , hydroDomain
        , hydroDomain
        , hydroDomain
        , hydroDomain
        ]
    , stageModel = HydroModel "TestModel" [ "test" ]
    , stageDomain = HydroDomain "TestDomain"
    }



-- TODO: temp holder for models/domain, get from api later


hydroDomain : HydroDomain
hydroDomain =
    { name = "HydroDomain"
    }


hydroDomain1 : HydroDomain
hydroDomain1 =
    { name = "HydroDomain1"
    }


hydroDomain2 : HydroDomain
hydroDomain2 =
    { name = "HydroDomain2"
    }


hydroModel : HydroModel
hydroModel =
    { name = "HydroModel"
    , args = [ "a1", "a2", "a3" ]
    }


hydroModel1 : HydroModel
hydroModel1 =
    { name = "HydroModel1"
    , args = [ "a1", "a2", "a3" ]
    }


hydroModel2 : HydroModel
hydroModel2 =
    { name = "HydroModel2"
    , args = [ "a1", "a2", "a3" ]
    }


hydroModel3 : HydroModel
hydroModel3 =
    { name = "HydroModel3"
    , args = [ "a3", "a2", "a3" ]
    }
