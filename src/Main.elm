module Main exposing (..)

import Model exposing (Model)
import Navigation
import Query exposing (parsePage)
import Update exposing (Msg(NewPage), update, init)
import View exposing (view)


main : Program Never Model Msg
main =
    Navigation.program
        (NewPage << parsePage)
        { init = init << parsePage
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }
