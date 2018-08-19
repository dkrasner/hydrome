module Messages exposing (..)


type Msg
    = ChangeArea String
    | Display String HydroObject
    | UpdateArgValue HydroObject String String -- HydroObjectName ArgName ArgValue


type HydroObject
    = HydroModelObject
    | HydroDomainObject
    | HydroJobsObject
    | HydroSchedulerObject
    | NoObject
