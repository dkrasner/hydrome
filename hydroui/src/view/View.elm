module View exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, placeholder, style, id, property, attribute, type_)
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
            [ div [ class "panel left col col-2" ] [ text "left panel" ]
            , div [ class "display col" ]
                [ text "display" ]
            , div [ class "panel right col col-2" ] [ text "right panel" ]
            ]
        , div [ class "panel lower row " ] [ text "lower panel" ]
        ]
