module Model exposing (Model, model, HydroArg)

import Array exposing (Array, fromList)
import Messages as M


-- MODEL


type alias Model =
    { area : String
    , hydroModel : HydroModel
    , hydroDomain : HydroDomain
    , hydroJobs : HydroJobs
    , hydroScheduler : HydroScheduler
    , display : String
    , displayMode : M.HydroObject
    }


model : Model
model =
    { area = "Main"
    , hydroModel = hydroModel
    , hydroDomain = hydroDomain
    , hydroJobs = hydroJobs
    , hydroScheduler = hydroScheduler
    , display = "**** READY ****"
    , displayMode = M.NoObject
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
    , doc : String
    , argtype : HydroArgType --TODO: this is reduntant but maybe ok for now
    }


type alias HydroModel =
    { id : String
    , args : List HydroArg
    }


type alias HydroDomain =
    { id : String
    , args : List HydroArg
    }


type alias HydroJobs =
    { id : String
    , args : List HydroArg
    }


type alias HydroScheduler =
    { id : String
    , args : List HydroArg
    }



-- TODO: temp holder for class init args, get from api later


hydroModel : HydroModel
hydroModel =
    { id = "template"
    , args =
        [ HydroArg "source_dir"
            "wrf_hydro_nwm/trunk/NDHMS"
            []
            """
            Directory containing the source code, e.g.
            'wrf_hydro_nwm/trunk/NDHMS'.
            """
            String
        , HydroArg "model_config"
            "NWM"
            [ "NWM", "Gridded", "Reach" ]
            """
            The configuration of the model. Used to match a model to a domain
            configuration. Must be one of either 'NWM', 'Gridded', or 'Reach'.
            """
            String
        , HydroArg "machine_spec"
            "cheyenne"
            []
            """
            Optional dictionary of machine specification or string containing the
            name of a known machine. Known machine names include 'cheyenne'. For an
            example of a machine specification see the 'cheyenne' machine specification using
            wrfhydropy.get_machine_spec('cheyenne').
            """
            String
        , HydroArg "compiler"
            "pgi"
            [ "pgi", "gfort", "ifort", "luna" ]
            """
            The compiler to use, must be one of 'pgi','gfort', 'ifort', or 'luna'.
            """
            String
        , HydroArg "compile_options"
            "options json"
            []
            """
            Changes to default compile-time options.
            """
            String
        ]
    }


hydroDomain : HydroDomain
hydroDomain =
    { id = "template"
    , args =
        [ HydroArg "domain_top_dir"
            "dir name"
            []
            "Parent directory containing all domain directories and files."
            String
        , HydroArg "domain_config"
            "NWM"
            [ "NWM", "Gridded", "Reach" ]
            """
            The domain configuration to use, options are 'NWM', 'Gridded', or 'Reach'
            """
            String
        , HydroArg "model_version"
            "model version"
            []
            """
            The WRF-Hydro model version
            """
            String
        , HydroArg "hydro_namelist_patch_file"
            "filename"
            []
            """
            Filename of json file containing namelist patches for hydro namelist
            """
            String
        , HydroArg "hrldas_namelist_patch_file"
            "filename"
            []
            """
            Filename of json file containing namelist patches for hrldas namelist
            """
            String
        ]
    }


hydroJobs : HydroJobs
hydroJobs =
    { id = "template"
    , args =
        [ HydroArg "job_id" "job id" [] "A string identify the job" String
        , HydroArg "model_start_time"
            "HH:MM:SS"
            []
            """
            The model start time to use for the WRF-Hydro model run. Can be
            a pandas.to_datetime compatible string.
            """
            String
        , HydroArg "model_end_time"
            "HH:MM:SS"
            []
            """
            The model end time to use for the WRF-Hydro model run. Can be
            a pandas.to_datetime compatible string.
            """
            String
        , HydroArg "exe_cmd"
            "command here"
            []
            """
            The system-specific command to execute WRF-Hydro, for example 'mpirun -np
            36./wrf_hydro.exe'
            """
            String
        , HydroArg "entry_cmd"
            "command here"
            []
            """
            A command to run prior to executing WRF-Hydro, such as loading modules or
            libraries
            """
            String
        , HydroArg "exit_cmd"
            "command here"
            []
            """
            A command to run after completion of the job
            """
            String
        ]
    }


hydroScheduler : HydroScheduler
hydroScheduler =
    { id = "template"
    , args =
        [ HydroArg "account" "account string" [] "The account string" String
        , HydroArg "email_who" "email@domain" [] "Email address for PBS notifications" String
        , HydroArg "email_when"
            "e"
            [ "a", "b", "e" ]
            """
            PBS email frequency options. Options include 'a' for on abort,
            'b' for before each job, and 'e' for after each job.
            """
            String
        , HydroArg "nproc" "1" [] "Number of processors to request" Int
        , HydroArg "nodes" "1" [] "Number of nodes to request" Int
        , HydroArg "ppn" "8" [] "Number of processors per node" Int
        , HydroArg "queue"
            "regular"
            [ "regular", "priority", "shared" ]
            """
            The queue to use, options are 'regular', 'priority', and 'shared'
            """
            String
        , HydroArg "walltime"
            "HH:MM:SS"
            []
            """
            The wall clock time in HH:MM:SS format, max time is 12:00:00
            """
            String
        ]
    }
