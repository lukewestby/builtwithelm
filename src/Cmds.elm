port module Cmds exposing (loadProjects, notifyOffsetChanged)

import Json.Decode as Decode
import Task
import Http
import HttpBuilder exposing (withExpect)
import Model exposing (Project, decodeProject)


projectsDecoder : Decode.Decoder (List Project)
projectsDecoder =
    Decode.list decodeProject


port notifyOffsetChangedRaw : () -> Cmd msg


notifyOffsetChanged : Cmd msg
notifyOffsetChanged =
    notifyOffsetChangedRaw ()


loadProjects : (Result Http.Error (List Project) -> msg) -> Cmd msg
loadProjects msg =
    HttpBuilder.get "data/projects.json"
        |> withExpect (Http.expectJson projectsDecoder)
        |> HttpBuilder.send msg
