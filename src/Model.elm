module Model exposing (Project, Model, model, decodeProject)

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
    , offset : Int
    , limit : Int
    , searchQuery : String
    }


model : Model
model =
    { projects = []
    , isLoading = True
    , loadFailed = False
    , offset = 0
    , limit = 5
    , searchQuery = ""
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
