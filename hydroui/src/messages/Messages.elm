module Messages exposing (..)


type Msg
    = ChangeArea String
    | Display String HydroObject
    | UpdateArgValue HydroObject String String -- HydroObject ArgName ArgValue
    | AddToInstances


type HydroObject
    = HydroModelObject
    | HydroDomainObject
    | HydroJobsObject
    | HydroSchedulerObject
    | NoObject
