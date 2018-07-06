module Feedback exposing (feedbackArea)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, placeholder, style, id, property, attribute, type_)
import Model exposing (Model)
import Update exposing (..)
import Controller exposing (..)


feedbackArea : Model -> Html Msg
feedbackArea model =
    div [ class "row h-100 justify-content-center align-items-center" ]
        [ controller model Nav
        , div []
            [ text "Feedback Area" ]
        ]
