module Stage exposing (stageArea)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, placeholder, style, id, property, attribute, type_)
import Model exposing (Model)
import Update exposing (..)
import Controller exposing (..)


stageArea : Model -> Html Msg
stageArea model =
    div [ class "row h-100 justify-content-center align-items-center stage" ]
        [ controller model Nav
        , div [ class "row w-100 h-50 justify-content-center" ]
            [ div [ class "col col-5 mt-5 mr-4 ml-5 area" ]
                [ text "Model Stage Area" ]
            , div [ class "col col-5 mt-5 ml-4 mr-5 area" ]
                [ text "Domain Stage Area" ]
            ]
        , div [ class "row w-100 h-50 justify-content-center" ]
            [ div [ class "col col-5 mt-5 mr-4 ml-5 mb-5 area" ]
                [ text "Run Stage Area" ]
            , div [ class "col col-5 mt-5 ml-4 mr-5 mb-5  area" ]
                [ text "Scheduler Stage Area" ]
            ]
        ]
