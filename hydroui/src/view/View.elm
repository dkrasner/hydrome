module View exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, placeholder, style, id, property, attribute, type_)
import Model exposing (Model, model)
import Update exposing (..)


view : Model -> Html Msg
view model =
    div [ class "container-fluid h-100 main" ]
        [ div [] [ text "Success!" ] ]
