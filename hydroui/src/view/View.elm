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


areaSelector : String -> Html Msg
areaSelector area =
    case area of
        "Landing" ->
            landingArea

        _ ->
            div [] [ text "Outer space" ]


landingArea : Html Msg
landingArea =
    div [ class "row h-100 justify-content-center align-items-center" ]
        [ div [ class "controller" ]
            [ controller "top" "Select"
            , controller "right" "Stage"
            , controller "bottom" "Run"
            , controller "left" "Feedback"
            ]
        ]



-- Controller button object, as seen on landing page


controller : String -> String -> Html Msg
controller position name =
    div [ class position, onClick (ChangeArea name) ]
        [ div [ class "controller-text" ] [ text name ] ]
