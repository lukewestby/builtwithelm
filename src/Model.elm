module Model exposing (Model, Project, decodeProject)

import Browser.Navigation exposing (Key)
import Json.Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (required)


type alias Project =
    { previewImageUrl : String
    , name : String
    , primaryUrl : String
    , description : String
    , repositoryUrl : Maybe String
    }


type alias Model =
    { key : Key
    , projects : List Project
    , isLoading : Bool
    , loadFailed : Bool
    , page : Int
    , pageSize : Int
    , searchQuery : String
    }


decodeProject : Decoder Project
decodeProject =
    Json.Decode.succeed Project
        |> required "previewImageUrl" Json.Decode.string
        |> required "name" Json.Decode.string
        |> required "primaryUrl" Json.Decode.string
        |> required "description" Json.Decode.string
        |> required "repositoryUrl" (Json.Decode.nullable Json.Decode.string)
