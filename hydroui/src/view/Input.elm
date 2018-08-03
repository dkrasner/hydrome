module Input exposing (..)

import Html exposing (..)
import Model exposing (HydroArg)
import Update exposing (Msg)


{-| Various input, arg modifiers etc
-}
slider : Html Msg
slider =
    div [] [ text "slider" ]
