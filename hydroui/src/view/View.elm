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
            [ button
                [ class "init"
                , tabindex 5
                ]
                [ text "init" ]
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

        controller name symbol model =
            div [ class controllerCss ]
                [ button
                    [ class dialCss
                    , style (dialStyle model name)
                    , tabindex 1
                    , onFocus (M.Display name)
                    , onMouseOver (M.Display name)
                    ]
                    [ text symbol ]
                ]
    in
        div [ class "panel left col col-2" ]
            [ controller "Model" "M" model
            , controller "Domain" "D" model
            , controller "Jobs" "J" model
            , controller "Scheduler" "S" model
            ]


dialStyle : Model -> String -> List ( String, String )
dialStyle model name =
    if (model.display == name) then
        [ ( "color", "teal" ), ( "border-color", "teal" ) ]
    else
        []
