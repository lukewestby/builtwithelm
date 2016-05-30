module Request exposing (getWithRetries, Error)

import Task exposing (Task)
import Http
import Json.Decode exposing (..)


type alias Error =
    Http.Error


getWithRetries : String -> Decoder a -> Int -> Task Error a
getWithRetries url decoder maxTries =
    getWithRetries' url decoder 0 maxTries


getWithRetries' : String -> Decoder a -> Int -> Int -> Task Http.Error a
getWithRetries' url decoder currentRetry maxRetries =
    let
        onError error =
            if currentRetry == maxRetries then
                Task.fail error
            else
                getWithRetries' url decoder (currentRetry + 1) maxRetries
    in
        Http.get decoder url
            |> flip Task.onError onError
