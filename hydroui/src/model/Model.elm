module Model exposing (Model, model)

import Array exposing (Array, fromList)


-- MODEL


type alias Model =
    { area : String
    }


model : Model
model =
    { area = "Main"
    }



--Hydro types


{-| All possible argument types; Note these are explicit and the compiler
will force us to check on every type branch for all arg related functions
-}
type HydroArgType
    = Int
    | String
    | Bool


type alias HydroArg =
    { name : String
    , default : String -- all arguments are strings; they arrive this way over http
    , options : List String
    , argtype : HydroArgType --TODO: this is reduntant but maybe ok for now
    }


{-| TODO: it might be ok to combine HydroModel and HydroDomain into a single type
-}
type alias HydroModel =
    { name : String
    , args : List HydroArg
    , compile_args : List HydroArg
    , id : Int
    }


type alias HydroDomain =
    { name : String
    , id : Int
    , args : List HydroArg
    }


type alias HydroScheduler =
    { job_name : HydroArg
    , account : HydroArg
    , nproc : HydroArg
    , ppn : HydroArg
    , email_when : HydroArg
    , walltime : HydroArg
    }


hydroScheduler : HydroScheduler
hydroScheduler =
    { job_name = HydroArg "job_name" "Your Job Name" [] String
    , account = HydroArg "account" "Your Account" [] String
    , nproc = HydroArg "nproc" "1" [ "1:100" ] Int
    , ppn = HydroArg "ppn" "36" [ "1:100" ] Int
    , email_when = HydroArg "email_when" "abe" [ "abe" ] Int
    , walltime = HydroArg "walltime" "Current Time" [] String --TODO: update this with current time
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
        , args =
            [ HydroArg
                "source_dir"
                "/wrf_hydro_nwm_public/trunk/NDHMS/"
                [ "/wrf_hydro_nwm_public/trunk/NDHMS/" ]
                String
            ]
        }


hydroModel : Int -> HydroModel
hydroModel mid =
    let
        name =
            "HydroModel" ++ toString mid
    in
        { name = name
        , args =
            [ HydroArg
                "source_dir"
                "/wrf_hydro_nwm_public/trunk/NDHMS/"
                [ "/wrf_hydro_nwm_public/trunk/NDHMS/" ]
                String
            , HydroArg
                "model_config"
                "NWM"
                [ "NWM" ]
                String
            ]
        , compile_args =
            [ HydroArg
                "compiler"
                "gfort"
                [ "gfort" ]
                String
            , HydroArg
                "compile_dir"
                "/tmp"
                [ "/tmp" ]
                String
            , HydroArg
                "overwrite"
                "True"
                [ "True", "False" ]
                Bool
            ]
        , id = mid
        }
