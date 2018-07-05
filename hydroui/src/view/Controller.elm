module Controller exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, placeholder, style, id, property, attribute, type_)
import DragEvents exposing (onDragStart, onDragEnd)
import Model exposing (ControllerModel, controllerModel)
import Update exposing (..)


{-| Controller button object

controllertype : either "landing" or "controller"

-}
type Controllertype
    = Landing
    | Nav


controller : ControllerModel -> Controllertype -> Html Msg
controller model controllertype =
    let
        attrs =
            controllerAttrs model controllertype
    in
        div (attrs)
            [ controllerButton "top" "Select"
            , controllerButton "right" "Stage"
            , controllerButton "bottom" "Run"
            , controllerButton "left" "Feedback"
            ]


controllerAttrs : ControllerModel -> Controllertype -> List (Attribute msg)
controllerAttrs model controllertype =
    case controllertype of
        Nav ->
            let
                x =
                    toString model.position.x ++ "px"

                y =
                    toString model.position.y ++ "px"
            in
                [ attribute "draggable" "true"
                , class "controller nav"
                , style [ ( "top", x ), ( "right", y ) ]
                ]

        Landing ->
            [ class "controller landing"
            ]


controllerButton : String -> String -> Html Msg
controllerButton position name =
    div [ class position, onClick (ChangeArea name) ]
        [ div [ class "controller-text" ] [ text name ] ]
