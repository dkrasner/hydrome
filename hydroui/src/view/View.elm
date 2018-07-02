module View exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, placeholder, style, id, property, attribute, type_)
import Model exposing (Model, model)
import Update exposing (..)


view : Model -> Html Msg
view model =
    div [ class "container-fluid h-100 main" ]
        [ areaSelector model.area ]


areaSelector : String -> Html msg
areaSelector area =
    case area of
        "landing" ->
            landingArea

        _ ->
            div [] [ text "Outer space" ]


landingArea : Html msg
landingArea =
    div [ class "row h-100 justify-content-center align-items-center" ]
        [ div [ class "controller" ]
            [ div [ class "top" ] [ div [ class "controller-text" ] [ text "Select" ] ]
            , div [ class "right" ] [ div [ class "controller-text" ] [ text "Stage" ] ]
            , div [ class "bottom" ] [ div [ class "controller-text" ] [ text "Run" ] ]
            , div [ class "left" ] [ div [ class "controller-text" ] [ text "Feedback" ] ]
            ]
        ]
