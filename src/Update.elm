module Update exposing (update, Msg(..), initialize)

import Cmds exposing (loadProjects, notifyOffsetChanged)
import Http
import Model exposing (Model, Project)


type Msg
    = NoOp
    | Prev
    | Next
    | LoadProjects (Result Http.Error (List Project))
    | UpdateSearchQuery String


initialize : Cmd Msg
initialize =
    loadProjects LoadProjects


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

        LoadProjects (Ok projects) ->
            ( { model
                | projects = projects
                , isLoading = False
              }
            , Cmd.none
            )

        LoadProjects (Err _) ->
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
