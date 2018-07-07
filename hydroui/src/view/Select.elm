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

        modelBlocks =
            Array.toList (Array.indexedMap modelBlock model.hydroModels)

        stageDomainId =
            getStageId "domain" model

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


getStageId : String -> Model -> Int
getStageId stageType model =
    case model.stageDomain of
        Nothing ->
            -1

        Just stageDomain ->
            stageDomain.id


domainBlock : Int -> Model.HydroDomain -> Html Msg
domainBlock stageId hydrodomain =
    let
        domainId =
            hydrodomain.id

        classString =
            blockClass domainId stageId
    in
        div
            [ class classString
            , id (toString domainId)
            , onClick (DomainSelect domainId)
            ]
            [ div [ class "align-self-center" ] [ text hydrodomain.name ]
            ]


blockClass : Int -> Int -> String
blockClass did sid =
    if did == sid then
        "block selected d-flex justify-content-center border border-secondary rounded"
    else
        "block d-flex justify-content-center border border-secondary rounded"


modelBlock : Int -> Model.HydroModel -> Html Msg
modelBlock index hydromodel =
    div
        [ class "block d-flex justify-content-center border border-secondary rounded"
        , id (toString index)
        , id (toString index)
        , onClick (ModelSelect index)
        ]
        [ div [ class "align-self-center" ] [ text hydromodel.name ]
        ]
