module Controller exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, placeholder, style, id, property, attribute, type_)
import Model exposing (Model, model)
import Update exposing (..)


{-| Controller button object

controllertype : either "landing" or "nav"

-}
type Controllertype
    = Landing
    | Nav


controller : Controllertype -> Html Msg
controller controllertype =
    let
        attrs =
            controllerAttr controllertype

        cls =
            controllerClass controllertype
    in
        div [ cls, attrs ]
            [ controllerButton "top" "Select"
            , controllerButton "right" "Stage"
            , controllerButton "bottom" "Run"
            , controllerButton "left" "Feedback"
            ]


controllerAttr : Controllertype -> Attribute msg
controllerAttr controllertype =
    case controllertype of
        Nav ->
            attribute "draggable" "true"

        Landing ->
            attribute "draggable" "false"


controllerClass : Controllertype -> Attribute msg
controllerClass controllertype =
    case controllertype of
        Nav ->
            class "controller nav"

        Landing ->
            class "controller landing"


controllerButton : String -> String -> Html Msg
controllerButton position name =
    div [ class position, onClick (ChangeArea name) ]
        [ div [ class "controller-text" ] [ text name ] ]
