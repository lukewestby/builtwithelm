module Model exposing (Project, Model, model, decodeProject)

import Json.Decode as Decode exposing ((:=))


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
    Decode.object2 (<|)


decodeProject : Decode.Decoder Project
decodeProject =
    Decode.succeed Project
        |: ("previewImageUrl" := Decode.string)
        |: ("name" := Decode.string)
        |: ("primaryUrl" := Decode.string)
        |: ("description" := Decode.string)
        |: ("repositoryUrl" := (Decode.maybe Decode.string))
