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
            [ div [ class "col col-5 mt-5 mr-4 ml-5 justify-content-center area" ]
                [ stageModelArea model ]
            , div [ class "col col-5 mt-5 ml-4 mr-5 justify-content-center area" ]
                [ stageDomainArea model ]
            ]
        , div [ class "row w-100 h-50 justify-content-center" ]
            [ div [ class "col col-5 mt-5 mr-4 ml-5 mb-5 justify-content-center area" ]
                [ text "Run Stage Area" ]
            , div [ class "col col-5 mt-5 ml-4 mr-5 mb-5 justify-content-center area" ]
                [ text "Scheduler Stage Area" ]
            ]
        ]


{-| The following control the layout of their repsecitve areas
-}
stageModelArea : Model -> Html Msg
stageModelArea model =
    case model.stageModel of
        Nothing ->
            h3 [] [ text "No model selected" ]

        Just stageModel ->
            h3 [] [ text stageModel.name ]


stageDomainArea : Model -> Html Msg
stageDomainArea model =
    case model.stageDomain of
        Nothing ->
            h3 [] [ text "No domain selected" ]

        Just stageDomain ->
            h3 [] [ text stageDomain.name ]
