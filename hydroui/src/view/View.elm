module View exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
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
        )
import Model exposing (Model, model)
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
        [ div [ class "row justify-content-center align-items-center h-75" ] [ text "arg area" ]
        , div [ class "row justify-content-center align-items-center h-25" ]
            [ button [ class "init", tabindex 5 ] [ text "init" ]
            ]
        ]


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
                [ button [ class dialCss, tabindex 1 ] [ text "M" ]
                ]
            , div [ class controllerCss ]
                [ button [ class dialCss, tabindex 2 ] [ text "D" ]
                ]
            , div [ class controllerCss ]
                [ button [ class dialCss, tabindex 3 ] [ text "J" ]
                ]
            , div [ class controllerCss ]
                [ button [ class dialCss, tabindex 4 ] [ text "S" ]
                ]
            ]
