module Select exposing (selectArea)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, placeholder, style, id, property, attribute, type_)
import Array
import Model exposing (Model)
import Update exposing (..)
import Controller exposing (..)


selectArea : Model -> Html Msg
selectArea model =
    let
        selectClass =
            class
                """
                col col-4 h-75 pt-2 pl-4 m-1
                border border-secondary rounded shadow
                area
                """

        stageModelId =
            getStageModelId model

        modelBlocks =
            Array.toList
                (Array.map
                    (modelBlock
                        stageModelId
                    )
                    model.hydroModels
                )

        stageDomainId =
            getStageDomainId model

        domainBlocks =
            Array.toList
                (Array.map
                    (domainBlock
                        stageDomainId
                    )
                    model.hydroDomains
                )
    in
        div [ class "row h-100 justify-content-center align-items-center select" ]
            [ controller model Nav
            , div [ selectClass ]
                [ div [ class "row" ] modelBlocks ]
            , div [ selectClass ]
                [ div [ class "row" ] domainBlocks ]
            ]


getStageModelId : Model -> Int
getStageModelId model =
    case model.stageModel of
        Nothing ->
            -1

        Just stageModel ->
            stageModel.id


getStageDomainId : Model -> Int
getStageDomainId model =
    case model.stageDomain of
        Nothing ->
            -1

        Just stageDomain ->
            stageDomain.id


{-| Creates a block visual object for domain selection/manipulation
-}
domainBlock : Int -> Model.HydroDomain -> Html Msg
domainBlock stageId hydrodomain =
    let
        domainId =
            hydrodomain.id

        classString =
            blockClass domainId stageId

        name =
            hydrodomain.name
    in
        div
            [ class classString
            , id (toString domainId)
            , onClick (DomainSelect domainId)
            ]
            [ div [ class "align-self-center" ] [ text name ]
            ]


{-| Creates a block visual object for model selection/manipulation
-}
modelBlock : Int -> Model.HydroModel -> Html Msg
modelBlock stageId hydromodel =
    let
        modelId =
            hydromodel.id

        classString =
            blockClass modelId stageId

        name =
            hydromodel.name
    in
        div
            [ class classString
            , id (toString modelId)
            , onClick (ModelSelect modelId)
            ]
            [ div [ class "align-self-center" ] [ text name ]
            ]


{-| Helper function that selects proper css class if bock Id == stage Id, i.e.
the color of a block is different if it has been selected for staging
-}
blockClass : Int -> Int -> String
blockClass blockId stageId =
    if blockId == stageId then
        "block selected d-flex justify-content-center border border-secondary rounded"
    else
        "block d-flex justify-content-center border border-secondary rounded"
