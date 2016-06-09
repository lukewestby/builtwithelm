module Update exposing (update, Msg(..), initialize)

-- where

import Model exposing (Model, Project)
import Cmds exposing (loadProjects, notifyOffsetChanged)


type Msg
  = NoOp
  | Prev
  | Next
  | LoadProjectsSuccess (List Project)
  | LoadProjectsError
  | UpdateSearchQuery String


initialize : Cmd Msg
initialize =
  loadProjects LoadProjectsError LoadProjectsSuccess


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    NoOp ->
      ( model, Cmd.none )

    Prev ->
      if model.offset - model.limit >= 0 then
        ( { model
            | offset = model.offset - model.limit
          }
        , notifyOffsetChanged
        )
      else
        ( model, Cmd.none )

    Next ->
      if model.offset + model.limit < List.length model.projects then
        ( { model
            | offset = model.offset + model.limit
          }
        , notifyOffsetChanged
        )
      else
        ( model, Cmd.none )

    LoadProjectsSuccess projects ->
      ( { model
          | projects = projects
          , isLoading = False
        }
      , Cmd.none
      )

    LoadProjectsError ->
      ( { model
          | loadFailed = True
          , isLoading = False
        }
      , Cmd.none
      )

    UpdateSearchQuery query ->
      ( { model
          | searchQuery = query
        }
      , Cmd.none
      )
