module Update exposing (..)

import Model exposing (Model)


type Msg
    = ChangeArea String


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeArea area ->
            { model | area = area }
