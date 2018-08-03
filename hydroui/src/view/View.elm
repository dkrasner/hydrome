module View exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, placeholder, style, id, property, attribute, type_)
import Model exposing (Model, model)
import Update exposing (..)


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
        [ text "this is the landing area" ]
