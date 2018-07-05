module View exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, placeholder, style, id, property, attribute, type_)
import Model exposing (Model, model)
import Update exposing (..)
import Select exposing (selectArea)
import Stage exposing (stageArea)
import Run exposing (runArea)
import Feedback exposing (feedbackArea)
import Controller exposing (..)


view : Model -> Html Msg
view model =
    div [ class "container-fluid h-100 main" ]
        [ areaSelector model ]


areaSelector : Model -> Html Msg
areaSelector model =
    case model.area of
        "Landing" ->
            landingArea model

        "Select" ->
            selectArea model

        "Stage" ->
            stageArea model

        "Run" ->
            runArea model

        "Feedback" ->
            feedbackArea model

        _ ->
            div [] [ text "Outer space" ]


landingArea : Model -> Html Msg
landingArea model =
    div [ class "row h-100 justify-content-center align-items-center" ]
        [ controller model.controller Landing ]
