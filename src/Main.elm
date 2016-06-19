module Main exposing (..)

-- where

import Html.App exposing (program)
import Update exposing (update, initialize)
import View exposing (view)
import Model exposing (model)


main : Program Never
main =
    program
        { init = ( model, initialize )
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }
