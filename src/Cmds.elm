port module Cmds exposing (loadProjects, newPage, notifyOffsetChanged)

import Browser.Navigation exposing (Key)
import Http
import Json.Decode exposing (Decoder)
import Model exposing (Project, decodeProject)
import Query


projectsDecoder : Decoder (List Project)
projectsDecoder =
    Json.Decode.list decodeProject


port notifyOffsetChangedRaw : () -> Cmd msg


newPage : Key -> Int -> Cmd msg
newPage key page =
    Browser.Navigation.pushUrl key (Query.pageUrl page)


notifyOffsetChanged : Cmd msg
notifyOffsetChanged =
    notifyOffsetChangedRaw ()


loadProjects : (Result Http.Error (List Project) -> msg) -> Cmd msg
loadProjects msg =
    Http.get
        { url = "data/projects.json"
        , expect = Http.expectJson msg (Json.Decode.list decodeProject)
        }
