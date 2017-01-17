module Model exposing (Project, Model, decodeProject)

import Json.Decode as Decode exposing (field)


type alias Project =
    { previewImageUrl : String
    , name : String
    , primaryUrl : String
    , description : String
    , repositoryUrl : Maybe String
    }


type alias Model =
    { projects : List Project
    , isLoading : Bool
    , loadFailed : Bool
    , page : Int
    , pageSize : Int
    , searchQuery : String
    }


(|:) : Decode.Decoder (a -> b) -> Decode.Decoder a -> Decode.Decoder b
(|:) =
    Decode.map2 (<|)


decodeProject : Decode.Decoder Project
decodeProject =
    Decode.succeed Project
        |: (field "previewImageUrl" Decode.string)
        |: (field "name" Decode.string)
        |: (field "primaryUrl" Decode.string)
        |: (field "description" Decode.string)
        |: (field "repositoryUrl" (Decode.maybe Decode.string))
