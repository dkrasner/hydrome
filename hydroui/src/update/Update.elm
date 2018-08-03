module Update exposing (..)

import Model exposing (Model)
import Messages as M
import Messages exposing (Msg)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        M.ChangeArea area ->
            ( { model | area = area }, Cmd.none )
