module Update exposing (..)

import Model exposing (Model)
import Messages as M
import Messages exposing (Msg)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        M.ChangeArea area ->
            ( { model | area = area }, Cmd.none )

        M.Display name hydroObject ->
            ( { model | display = name, displayMode = hydroObject }, Cmd.none )

        M.AddToInstances ->
            ( model.displayMode
                |> \mode ->
                    case mode of
                        M.HydroModelObject ->
                            { model | hydroModelInstances = model.hydroModel :: model.hydroModelInstances }

                        M.HydroDomainObject ->
                            { model | hydroDomainInstances = model.hydroDomain :: model.hydroDomainInstances }

                        M.HydroJobsObject ->
                            { model | hydroJobsInstances = model.hydroJobs :: model.hydroJobsInstances }

                        M.HydroSchedulerObject ->
                            { model | hydroSchedulerInstances = model.hydroScheduler :: model.hydroSchedulerInstances }

                        M.NoObject ->
                            model
            , Cmd.none
            )

        M.UpdateArgValue object arg value ->
            ( object
                |> \n ->
                    case object of
                        M.HydroModelObject ->
                            { model
                                | hydroModel =
                                    let
                                        hydro =
                                            model.hydroModel
                                    in
                                        { hydro | args = List.map (updateArgValue arg value) hydro.args }
                            }

                        M.HydroDomainObject ->
                            { model
                                | hydroDomain =
                                    let
                                        hydro =
                                            model.hydroDomain
                                    in
                                        { hydro | args = List.map (updateArgValue arg value) hydro.args }
                            }

                        M.HydroJobsObject ->
                            { model
                                | hydroJobs =
                                    let
                                        hydro =
                                            model.hydroJobs
                                    in
                                        { hydro | args = List.map (updateArgValue arg value) hydro.args }
                            }

                        M.HydroSchedulerObject ->
                            { model
                                | hydroScheduler =
                                    let
                                        hydro =
                                            model.hydroScheduler
                                    in
                                        { hydro | args = List.map (updateArgValue arg value) hydro.args }
                            }

                        M.NoObject ->
                            model
            , Cmd.none
            )


updateArgValue : String -> String -> Model.HydroArg -> Model.HydroArg
updateArgValue argName argValue hydroArg =
    if (hydroArg.name == argName) then
        { hydroArg | default = argValue }
    else
        hydroArg
