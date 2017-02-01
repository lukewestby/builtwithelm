port module Cmds exposing (loadProjects, newPage, notifyOffsetChanged)

import Http
import HttpBuilder exposing (withExpect)
import Json.Decode as Decode
import Model exposing (Project, decodeProject)
import Navigation
import Query
import Task


projectsDecoder : Decode.Decoder (List Project)
projectsDecoder =
    Decode.list decodeProject


port notifyOffsetChangedRaw : () -> Cmd msg


newPage : Int -> Cmd msg
newPage =
    Navigation.newUrl << Query.pageUrl


notifyOffsetChanged : Cmd msg
notifyOffsetChanged =
    notifyOffsetChangedRaw ()


loadProjects : (Result Http.Error (List Project) -> msg) -> Cmd msg
loadProjects msg =
    HttpBuilder.get "data/projects.json"
        |> withExpect (Http.expectJson projectsDecoder)
        |> HttpBuilder.send msg
