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
import List
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
        , div [ class "panel lower row " ] [ text "lower panel" ]
        ]


display : Model -> Html Msg
display model =
    div [ class "display col" ]
        [ div [ class "d-flex flex-column justify-content-center align-items-center h-75 m-4" ]
            [ div [ class "row name" ]
                [ text model.display ]
            , argsDisplay model
            ]
        , div [ class "row justify-content-center align-items-center" ]
            [ button
                [ class "init"
                , tabindex 5
                , onClick M.AddToInstances
                ]
                [ text "init" ]
            ]
        ]


argsDisplay : Model -> Html Msg
argsDisplay model =
    let
        args =
            ( model.displayMode, model.displayObjectId )
                |> \( object, id ) ->
                    case object of
                        M.HydroModelObject ->
                            case id of
                                "templateModel" ->
                                    model.hydroModel.args

                                _ ->
                                    getArgsById id model.hydroModelInstances

                        M.HydroDomainObject ->
                            case id of
                                "templateDomain" ->
                                    model.hydroDomain.args

                                _ ->
                                    getArgsById id model.hydroDomainInstances

                        M.HydroJobsObject ->
                            case id of
                                "templateJobs" ->
                                    model.hydroJobs.args

                                _ ->
                                    getArgsById id model.hydroJobsInstances

                        M.HydroSchedulerObject ->
                            case id of
                                "templateScheduler" ->
                                    model.hydroScheduler.args

                                _ ->
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

        argInputGroup a =
            div [ class "w-100 d-flex" ]
                [ div [ class "input-group input-group-sm mb-3" ]
                    [ div
                        [ class "input-group-prepend"
                        , attribute "data-toggle" "popover"
                        , attribute "data-placement" "left"
                        , attribute "title" "This is a title"
                        , attribute "data-content" "Vivamus sagittis lacus vel augue laoreet rutrum faucibus."
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
        case model.display of
            "**** READY ****" ->
                span [] []

            _ ->
                argsDiv



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

                        M.NoObject ->
                            []
            in
                case (List.length instances) of
                    0 ->
                        [ span [ class "text-center font-weight-bold" ] [ text defaultString ] ]

                    _ ->
                        List.map
                            (\i ->
                                button
                                    [ class dialCss
                                    , style (dialStyle model i.id)
                                    , tabindex 1
                                    , onClick (M.Display i.id hydroObject i.id)
                                    ]
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
