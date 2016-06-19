port module Cmds exposing (loadProjects, notifyOffsetChanged)

import Json.Decode as Decode
import Task
import HttpBuilder exposing (jsonReader, stringReader)
import Model exposing (Project, decodeProject)


projectsReader : HttpBuilder.BodyReader (List Project)
projectsReader =
    jsonReader <| Decode.list decodeProject


port notifyOffsetChangedRaw : () -> Cmd msg


notifyOffsetChanged : Cmd msg
notifyOffsetChanged =
    notifyOffsetChangedRaw ()


loadProjects : msg -> (List Project -> msg) -> Cmd msg
loadProjects failure success =
    HttpBuilder.get "data/projects.json"
        |> HttpBuilder.send projectsReader stringReader
        |> Task.map .data
        |> Task.perform (always failure) success
