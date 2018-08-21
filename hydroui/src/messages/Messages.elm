module Messages exposing (..)

import Html5.DragDrop as DragDrop


type Msg
    = ChangeArea String
    | Display String HydroObject String -- display string, object type, object id
    | UpdateArgValue HydroObject String String -- HydroObject ArgName ArgValue
    | AddToInstances
    | DeleteFromInstances
    | DragDropMsg (DragDrop.Msg DragId DropId)


type alias DragId =
    String


type alias DropId =
    String


type HydroObject
    = HydroModelObject
    | HydroDomainObject
    | HydroJobsObject
    | HydroSchedulerObject
    | NoObject
