module Update exposing (..)

import Debug
import Model exposing (Model)


type Msg
    = ChangeArea String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeArea area ->
            ( { model | area = area }, Cmd.none )
