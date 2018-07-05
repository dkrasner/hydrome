module Controller exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick, on)
import Html.Attributes exposing (class, placeholder, style, id, property, attribute, type_)
import Draggable
import Model exposing (Model)
import Update exposing (..)


{-| Controller button object

controllertype : either "landing" or "controller"

-}
type Controllertype
    = Landing
    | Nav


controller : Model -> Controllertype -> Html Msg
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


controllerAttrs : Model -> Controllertype -> List (Attribute Msg)
controllerAttrs model controllertype =
    case controllertype of
        Nav ->
            let
                xy =
                    model.controllerXY

                translate =
                    "translate(" ++ (toString xy.x) ++ "px, " ++ (toString xy.y) ++ "px)"
            in
                [ Draggable.mouseTrigger "my-element" DragMsg
                , class "controller nav"
                , style [ ( "transform", translate ) ]
                ]

        Landing ->
            [ class "controller landing"
            ]


controllerButton : String -> String -> Html Msg
controllerButton position name =
    div [ class position, onClick (ChangeArea name) ]
        [ div [ class "controller-text" ] [ text name ] ]
