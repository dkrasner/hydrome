module Update exposing (..)

import Model exposing (Model)
import Messages as M
import Messages exposing (Msg)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        M.ChangeArea area ->
            ( { model | area = area }, Cmd.none )

        M.Display name hydroObject id ->
            ( { model | display = name, displayMode = hydroObject, displayObjectId = id }, Cmd.none )

        M.AddToInstances ->
            ( model.displayMode
                |> \mode ->
                    case mode of
                        M.HydroModelObject ->
                            { model
                                | hydroModelInstances =
                                    let
                                        l =
                                            List.length model.hydroModelInstances

                                        id =
                                            l |> (\n -> n + 1) |> toString |> (\s -> "M_" ++ s)

                                        hydroModel =
                                            model.hydroModel
                                    in
                                        { hydroModel | id = id } :: model.hydroModelInstances
                            }

                        M.HydroDomainObject ->
                            { model
                                | hydroDomainInstances =
                                    let
                                        l =
                                            List.length model.hydroDomainInstances

                                        id =
                                            l |> (\n -> n + 1) |> toString |> (\s -> "D_" ++ s)

                                        hydroDomain =
                                            model.hydroDomain
                                    in
                                        { hydroDomain | id = id } :: model.hydroDomainInstances
                            }

                        M.HydroJobsObject ->
                            { model
                                | hydroJobsInstances =
                                    let
                                        l =
                                            List.length model.hydroJobsInstances

                                        id =
                                            l |> (\n -> n + 1) |> toString |> (\s -> "J_" ++ s)

                                        hydroJobs =
                                            model.hydroJobs
                                    in
                                        { hydroJobs | id = id } :: model.hydroJobsInstances
                            }

                        M.HydroSchedulerObject ->
                            { model
                                | hydroSchedulerInstances =
                                    let
                                        l =
                                            List.length model.hydroSchedulerInstances

                                        id =
                                            l |> (\n -> n + 1) |> toString |> (\s -> "S_" ++ s)

                                        hydroScheduler =
                                            model.hydroScheduler
                                    in
                                        { hydroScheduler | id = id } :: model.hydroSchedulerInstances
                            }

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
