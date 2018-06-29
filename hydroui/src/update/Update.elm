module Update exposing (..)

import Model exposing (Model)


type Msg
    = ChangeView String


update : Msg -> Model -> Model
update msg model =
    model
