module Controller exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, placeholder, style, id, property, attribute, type_)
import Model exposing (Model, model)
import Update exposing (..)


{-| Controller button object

typeof : either "landing" or "nav"

-}
controller : String -> Html Msg
controller typeof =
    div [ class ("controller " ++ typeof) ]
        [ controllerButton "top" "Select"
        , controllerButton "right" "Stage"
        , controllerButton "bottom" "Run"
        , controllerButton "left" "Feedback"
        ]


controllerButton : String -> String -> Html Msg
controllerButton position name =
    div [ class position, onClick (ChangeArea name) ]
        [ div [ class "controller-text" ] [ text name ] ]
