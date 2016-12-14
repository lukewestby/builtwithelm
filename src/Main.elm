module Main exposing (..)

import Html
import Update exposing (Msg, update, initialize)
import View exposing (view)
import Model exposing (Model, model)


main : Program Never Model Msg
main =
    Html.program
        { init = ( model, initialize )
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }
