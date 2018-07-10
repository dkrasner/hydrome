module Stage exposing (stageArea)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, placeholder, style, id, property, attribute, type_)
import Model exposing (Model)
import Update exposing (..)
import Controller exposing (..)


stageArea : Model -> Html Msg
stageArea model =
    let
        rowStageClass =
            class "row w-75 pr-4 pl-4 h-50 justify-content-center"
    in
        div [ class "row h-100 justify-content-center align-items-center stage" ]
            [ controller model Nav
            , div [ rowStageClass ]
                [ div [ class "col mt-5 mr-4 justify-content-center area border rounded" ]
                    [ stageModelArea model ]
                , div [ class "col mt-5 ml-4 justify-content-center area border rounded" ]
                    [ stageDomainArea model ]
                ]
            , div [ rowStageClass ]
                [ div [ class "col mt-5 mb-5 justify-content-center area border rounded" ]
                    [ stageSchedulerArea model ]
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


stageSchedulerArea : Model -> Html Msg
stageSchedulerArea model =
    h3 [] [ text "Scheduler" ]
