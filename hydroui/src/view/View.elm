module View exposing (..)

import Html exposing (..)
import Html.Events
    exposing
        ( onClick
        , onFocus
        , onMouseOver
        , onMouseLeave
        , onInput
        )
import Html.Attributes
    exposing
        ( class
        , placeholder
        , style
        , id
        , property
        , attribute
        , type_
        , tabindex
        , defaultValue
        , value
        , for
        )
import String
import List
import Regex
import Html5.DragDrop as DragDrop
import Model exposing (Model, model)
import Messages as M
import Messages exposing (Msg)


view : Model -> Html Msg
view model =
    div [ class "container-fluid h-100 main" ]
        [ areaSelector model ]


areaSelector : Model -> Html Msg
areaSelector model =
    case model.area of
        "Main" ->
            mainArea model

        _ ->
            div [] [ text "Outer space" ]


mainArea : Model -> Html Msg
mainArea model =
    div [ class "row h-100 justify-content-center align-items-center" ]
        [ div [ class "control-view-panel row" ]
            [ leftPanel model
            , display model
            , rightPanel model
            ]
        , simulationPanel model
        ]


display : Model -> Html Msg
display model =
    let
        mainDisplay =
            if (Regex.contains (Regex.regex "^simulation") model.displayObjectId) then
                displaySimulation model
            else if (Regex.contains (Regex.regex "^template") model.displayObjectId) then
                inputArgsDisplay model
            else if (model.displayObjectId == "") then
                span [] []
            else
                argsDisplay model
    in
        div [ class "display col" ]
            [ div [ class "d-flex flex-column justify-content-center align-items-center h-75 m-4" ]
                [ div [ class "row name" ]
                    [ text model.display ]
                , mainDisplay
                ]
            , div [ class "row justify-content-center align-items-center" ]
                [ displayButton model.displayObjectId
                ]
            ]



{- only "template*" Id objects can be initialized into classes;
   all others are assumed to be instances and therefor can only be inspected
   and deleted
-}


displaySimulation : Model -> Html Msg
displaySimulation model =
    let
        simulation =
            model.hydroSimulation

        hydroObjectInfo hydroObject =
            case hydroObject of
                Just object ->
                    div [ class "row p-2 w-100 h-50 justify-content-center align-item-center" ]
                        [ div [] [ text object.id ]
                        , div [ class "d-flex flex-wrap p-1 args" ]
                            (List.map argGroup object.args)
                        ]

                Nothing ->
                    div [ class "row p-2 w-100 h-50 justify-content-center align-item-center" ]
                        [ div [] [ text "No info" ]
                        ]
    in
        div [ class "row h-100 w-100" ]
            [ div [ class "col w-50 h-100" ]
                [ hydroObjectInfo simulation.model
                , hydroObjectInfo simulation.domain
                ]
            , div [ class "col w-50 h-100" ]
                [ hydroObjectInfo simulation.jobs
                , hydroObjectInfo simulation.scheduler
                ]
            ]


displayButton : String -> Html Msg
displayButton displayId =
    if (Regex.contains (Regex.regex "^template|^simulation") displayId) then
        button
            [ class "init"
            , tabindex 5
            , onClick M.AddToInstances
            ]
            [ text "init" ]
    else if (displayId == "") then
        span [] []
    else
        button
            [ class "init text-danger"
            , tabindex 5
            , onClick M.DeleteFromInstances
            ]
            [ text "delete" ]


inputArgsDisplay : Model -> Html Msg
inputArgsDisplay model =
    let
        args =
            model.displayMode
                |> \object ->
                    case object of
                        M.HydroModelObject ->
                            model.hydroModel.args

                        M.HydroDomainObject ->
                            model.hydroDomain.args

                        M.HydroJobsObject ->
                            model.hydroJobs.args

                        M.HydroSchedulerObject ->
                            model.hydroScheduler.args

                        _ ->
                            []

        argInputGroup a =
            div [ class "w-100 d-flex" ]
                [ div [ class "input-group input-group-sm mb-3" ]
                    [ div
                        [ class "input-group-prepend"
                        , style [ ( "cursor", "help" ) ]
                        , attribute "data-toggle" "popover"
                        , attribute "title" a.doc
                        ]
                        [ span [ class "input-group-text" ] [ text a.name ] ]
                    , input
                        [ type_ "text"
                        , class "form-control"
                        , value a.default
                        , for a.name
                        , onInput (M.UpdateArgValue model.displayMode a.name)
                        ]
                        []
                    ]
                ]

        argsDiv =
            div [ class "d-flex flex-wrap p-4 args" ]
                (List.map argInputGroup args)
    in
        argsDiv


argsDisplay : Model -> Html Msg
argsDisplay model =
    let
        args =
            ( model.displayMode, model.displayObjectId )
                |> \( object, id ) ->
                    case object of
                        M.HydroModelObject ->
                            getArgsById id model.hydroModelInstances

                        M.HydroDomainObject ->
                            getArgsById id model.hydroDomainInstances

                        M.HydroJobsObject ->
                            getArgsById id model.hydroJobsInstances

                        M.HydroSchedulerObject ->
                            getArgsById id model.hydroSchedulerInstances

                        _ ->
                            []

        getArgsById id instances =
            let
                instance =
                    instances
                        |> List.filter
                            (\i -> (i.id == id))
                        |> (\items ->
                                case (List.head items) of
                                    Just i ->
                                        i

                                    Nothing ->
                                        { id = "placeholder", args = [] }
                           )
            in
                instance.args

        argsDiv =
            div [ class "d-flex flex-wrap p-4 args" ]
                (List.map argGroup args)
    in
        argsDiv


argGroup : Model.HydroArg -> Html Msg
argGroup a =
    div [ class "w-100 d-flex" ]
        [ div [ class "input-group input-group-sm mb-3" ]
            [ div
                [ class "input-group-prepend"
                , style [ ( "cursor", "help" ) ]
                , attribute "data-toggle" "popover"
                , attribute "title" a.doc
                ]
                [ span [ class "input-group-text" ] [ text a.name ] ]
            , div
                [ class "form-control"
                ]
                [ text a.default ]
            ]
        ]



{--Left Panel Area --}


leftPanel : Model -> Html Msg
leftPanel model =
    let
        controllerCss =
            """
            row h-25
            justify-content-center align-items-center
            """

        dialCss =
            """
            dial
            d-flex
            justify-content-center align-items-center
            """

        controller name hydroObject symbol model =
            div [ class controllerCss ]
                [ button
                    [ class dialCss
                    , style (dialStyle model ("template" ++ name))
                    , tabindex 1
                    , onFocus (M.Display name hydroObject ("template" ++ name))
                    , onMouseOver (M.Display name hydroObject ("template" ++ name))
                    ]
                    [ text symbol ]
                ]
    in
        div [ class "panel left col" ]
            [ controller "Model" M.HydroModelObject "M" model
            , controller "Domain" M.HydroDomainObject "D" model
            , controller "Jobs" M.HydroJobsObject "J" model
            , controller "Scheduler" M.HydroSchedulerObject "S" model
            ]


dialStyle : Model -> String -> List ( String, String )
dialStyle model id =
    if (model.displayObjectId == id) then
        [ ( "color", "teal" ), ( "border-color", "teal" ) ]
    else
        []



{--Right  Panel Area --}


rightPanel : Model -> Html Msg
rightPanel model =
    let
        panelCss =
            """
            panel right
            col
            d-flex flex-column
            justify-content-center align-items-center
            """

        controllerCss =
            """
            row h-25 w-100
            d-flex flex-column
            justify-content-center align-items-center
            """

        dialCss =
            """
            dial
            small
            d-flex
            justify-content-center align-items-center
            """

        instanceDials hydroObject model defaultString =
            let
                instances =
                    case hydroObject of
                        M.HydroModelObject ->
                            model.hydroModelInstances

                        M.HydroDomainObject ->
                            model.hydroDomainInstances

                        M.HydroJobsObject ->
                            model.hydroJobsInstances

                        M.HydroSchedulerObject ->
                            model.hydroSchedulerInstances

                        _ ->
                            []
            in
                case (List.length instances) of
                    0 ->
                        [ span
                            [ class "text-center font-weight-bold"
                            , style [ ( "font-size", "1vw" ) ]
                            ]
                            [ text defaultString ]
                        ]

                    _ ->
                        List.map
                            (\i ->
                                button
                                    ([ class dialCss
                                     , style (dialStyle model i.id)
                                     , tabindex 1
                                     , onClick (M.Display i.id hydroObject i.id)
                                     ]
                                        ++ DragDrop.draggable M.DragDropMsg i.id
                                    )
                                    [ text i.id ]
                            )
                            instances

        instanceController hydroObject model defaultString =
            div
                [ class controllerCss
                , style [ ( "overflow-x", "auto" ) ]
                ]
                (instanceDials hydroObject model defaultString)
    in
        div [ class panelCss ]
            [ instanceController M.HydroModelObject model "Model Instances"
            , instanceController M.HydroDomainObject model "Domain Instances"
            , instanceController M.HydroJobsObject model "Jobs Instances"
            , instanceController M.HydroSchedulerObject model "Scheduler Instances"
            ]



{--Simulation Panel Area --}


simulationPanel : Model -> Html Msg
simulationPanel model =
    let
        hydroSimulation =
            model.hydroSimulation

        controllerCss =
            """
            col w-25
            d-flex
            justify-content-center align-items-center
            """

        dialCss =
            """
            dial
            d-flex
            justify-content-center align-items-center
            """

        simStyle =
            if
                (List.all checkIfJust
                    [ hydroSimulation.model
                    , hydroSimulation.domain
                    , hydroSimulation.jobs
                    , hydroSimulation.scheduler
                    ]
                )
            then
                [ ( "background-color", "#30543f" ), ( "cursor", "pointer" ) ]
            else
                []

        dragId =
            DragDrop.getDragId model.dragDrop

        {--TODO: to have the appropriate dial light up on drag, we match on dragId;
        i.e. if (String.startsWith matchSymbol dragId) is True (for example,
        matchSymbol is "M" and dragId is "M_1") then we know to light up the correspoding
        dial. This does not seem to be ideal but currently drag&drop works only on
        element id --}
        controller defaultSymbol matchSymbol hydroSimInstance =
            let
                defaultDialStyle =
                    case dragId of
                        Just id ->
                            if (String.startsWith matchSymbol id) then
                                style
                                    [ ( "cursor", "help" )
                                    , ( "opacity", "1.0" )
                                    , ( "background-color", "#EE6E3F" )
                                    , ( "font-size", "1vw" )
                                    ]
                            else
                                style [ ( "cursor", "help" ), ( "opacity", ".4" ), ( "font-size", "1vw" ) ]

                        Nothing ->
                            style [ ( "cursor", "help" ), ( "opacity", ".4" ), ( "font-size", "1vw" ) ]
            in
                case hydroSimInstance of
                    Just object ->
                        div [ class controllerCss ]
                            [ button
                                [ class dialCss
                                , style
                                    [ ( "cursor", "pointer" )
                                    , ( "opacity", "1.0" )
                                    , ( "font-size", "2vw" )
                                    , ( "background-color", "teal" )
                                    ]

                                --, onFocus (M.Display name hydroObject ("template" ++ name))
                                --, onClick (M.Display i.id hydroObject i.id)
                                ]
                                [ text object.id ]
                            ]

                    Nothing ->
                        div [ class controllerCss ]
                            [ button
                                [ class dialCss
                                , defaultDialStyle
                                , attribute "data-toggle" "popover"
                                , attribute "title" "drag & drop instance object to include in simulation"

                                --, onFocus (M.Display name hydroObject ("template" ++ name))
                                --, onClick (M.Display i.id hydroObject i.id)
                                ]
                                [ text defaultSymbol ]
                            ]
    in
        div
            [ class "panel lower row justify-content-center align-items-center" ]
            [ div [ class "w-25 text-center" ] [ text ("# of sims: " ++ (toString <| List.length <| model.hydroSimulationInstances)) ]
            , div
                ([ class "w-50 justify-content-center align-items-center" ]
                    ++ DragDrop.droppable M.DragDropMsg "simulation"
                )
                [ div [ class "simulation row w-100", style simStyle, onClick (M.Display "Simulation" M.HydroSimulationObject "simulationTemp") ]
                    [ controller "Model Instance" "M" hydroSimulation.model
                    , controller "Domain Instance" "D" hydroSimulation.domain
                    , controller "Jobs Instance" "J" hydroSimulation.jobs
                    , controller "Scheduler Instance" "S" hydroSimulation.scheduler
                    ]
                ]
            , div [ class "w-25 text-center" ] [ text "placeholder" ]
            ]



{--helper function to check if an object is of type Just a or Nothing --}


checkIfJust : Maybe a -> Bool
checkIfJust a =
    case a of
        Just _ ->
            True

        Nothing ->
            False
