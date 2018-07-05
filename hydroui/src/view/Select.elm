module Select exposing (selectArea)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, placeholder, style, id, property, attribute, type_)
import Model exposing (controllerModel)
import Update exposing (..)
import Controller exposing (..)


selectArea : Html Msg
selectArea =
    div [ class "row h-100 justify-content-center align-items-center" ]
        [ controller controllerModel Nav
        , div []
            [ text "Select Area" ]
        ]
