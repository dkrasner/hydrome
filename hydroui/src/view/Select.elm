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
                "col col-4 h-75 m-1 border border-secondary rounded shadow selectarea"

        modelBlocks =
            List.map modelBlock model.hydroModels

        domainBlocks =
            List.map domainBlock model.hydroDomains
    in
        div [ class "row h-100 justify-content-center align-items-center" ]
            [ controller model Nav
            , div [ selectClass ]
                [ div [ class "row" ] modelBlocks ]
            , div [ selectClass ]
                [ div [ class "row" ] domainBlocks ]
            ]


domainBlock : Model.HydroDomain -> Html Msg
domainBlock hydrodomain =
    div [ class "block border" ]
        [ div [] [ text hydrodomain.name ]
        ]


modelBlock : Model.HydroModel -> Html Msg
modelBlock hydromodel =
    div [ class "block border" ]
        [ div [] [ text hydromodel.name ]
        ]
