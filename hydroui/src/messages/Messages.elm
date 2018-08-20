module Messages exposing (..)


type Msg
    = ChangeArea String
    | Display String HydroObject String -- display string, object type, object id
    | UpdateArgValue HydroObject String String -- HydroObject ArgName ArgValue
    | AddToInstances


type HydroObject
    = HydroModelObject
    | HydroDomainObject
    | HydroJobsObject
    | HydroSchedulerObject
    | NoObject
