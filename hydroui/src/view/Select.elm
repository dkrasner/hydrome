module Select exposing (selectArea)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, placeholder, style, id, property, attribute, type_)
import List
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
            List.indexedMap modelBlock model.hydroModels

        domainBlocks =
            List.indexedMap domainBlock model.hydroDomains
    in
        div [ class "row h-100 justify-content-center align-items-center select" ]
            [ controller model Nav
            , div [ selectClass ]
                [ div [ class "row" ] modelBlocks ]
            , div [ selectClass ]
                [ div [ class "row" ] domainBlocks ]
            ]


domainBlock : Int -> Model.HydroDomain -> Html Msg
domainBlock index hydrodomain =
    div
        [ class "block border border-secondary rounded"
        , id (toString index)
        , onClick (DomainSelect index)
        ]
        [ div [] [ text hydrodomain.name ]
        ]


modelBlock : Int -> Model.HydroModel -> Html Msg
modelBlock index hydromodel =
    div
        [ class "block border border-secondary rounded"
        , id (toString index)
        , onClick (ModelSelect index)
        ]
        [ div [] [ text hydromodel.name ]
        ]
