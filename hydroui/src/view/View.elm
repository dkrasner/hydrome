module View exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick, onFocus, onMouseOver, onMouseLeave)
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
            [ leftPanel
            , display model
            , div [ class "panel right col col-2" ] [ text "right panel" ]
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
            [ button [ class "init", tabindex 5 ] [ text "init" ]
            ]
        ]


argsDisplay : Model -> Html Msg
argsDisplay model =
    let
        args =
            model.display
                |> \name ->
                    case name of
                        "Model" ->
                            model.hydroModel.args

                        "Domain" ->
                            model.hydroDomain.args

                        "Jobs" ->
                            model.hydroJobs.args

                        "Scheduler" ->
                            model.hydroScheduler.args

                        _ ->
                            []

        argInputGroup a =
            div [ class "input-group input-group-sm mb-3" ]
                [ div [ class "input-group-prepend" ]
                    [ span [ class "input-group-text", id a.name ] [ text a.name ] ]
                , input
                    [ type_ "text"
                    , class "form-control"
                    , placeholder a.default
                    , for a.name
                    ]
                    []
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


leftPanel : Html Msg
leftPanel =
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
    in
        div [ class "panel left col col-2" ]
            [ div [ class controllerCss ]
                [ button
                    [ class dialCss
                    , tabindex 1
                    , onFocus (M.Display "Model")
                    , onMouseOver (M.Display "Model")
                    , onMouseLeave (M.Display "**** READY ****")
                    ]
                    [ text "M" ]
                ]
            , div [ class controllerCss ]
                [ button
                    [ class dialCss
                    , tabindex 2
                    , onFocus (M.Display "Domain")
                    , onMouseOver (M.Display "Domain")
                    , onMouseLeave (M.Display "**** READY ****")
                    ]
                    [ text "D" ]
                ]
            , div [ class controllerCss ]
                [ button
                    [ class dialCss
                    , tabindex 3
                    , onFocus (M.Display "Jobs")
                    , onMouseOver (M.Display "Jobs")
                    , onMouseLeave (M.Display "**** READY ****")
                    ]
                    [ text "J" ]
                ]
            , div [ class controllerCss ]
                [ button
                    [ class dialCss
                    , tabindex 4
                    , onFocus (M.Display "Scheduler")
                    , onMouseOver (M.Display "Scheduler")
                    , onMouseLeave (M.Display "**** READY ****")
                    ]
                    [ text "S" ]
                ]
            ]
