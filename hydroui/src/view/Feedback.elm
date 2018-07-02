module Feedback exposing (feedbackArea)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, placeholder, style, id, property, attribute, type_)
import Model exposing (Model, model)
import Update exposing (..)


feedbackArea : Html Msg
feedbackArea =
    div [ class "row h-100 justify-content-center align-items-center" ]
        [ div [ class "controller" ]
            [ text "Feedback Area" ]
        ]
