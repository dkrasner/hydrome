module Messages exposing (..)


type Msg
    = ChangeArea String
    | Display String
    | UpdateArgValue String String String -- HydroObjectName ArgName ArgValue
