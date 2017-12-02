module Update exposing (update, Msg(..), init)

import Cmds exposing (loadProjects, newPage, notifyOffsetChanged)
import Http
import Model exposing (Model, Project)


type Msg
    = NoOp
    | NewPage Int
    | Next
    | Prev
    | SetPageSize String
    | LoadProjects (Result Http.Error (List Project))
    | UpdateSearchQuery String


init : Int -> ( Model, Cmd Msg )
init page =
    ( { projects = []
      , isLoading = True
      , loadFailed = False
      , page = page
      , pageSize = 5
      , searchQuery = ""
      }
    , loadProjects LoadProjects
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
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

        NewPage page ->
            ( { model
                | page = page
              }
            , notifyOffsetChanged
            )

        Next ->
            ( model, newPage <| model.page + 1 )

        Prev ->
            ( model, newPage <| model.page - 1 )

        SetPageSize selected ->
            ( { model
                | pageSize = String.toInt selected |> Result.toMaybe |> Maybe.withDefault 5
              }
            , Cmd.none
            )

        UpdateSearchQuery query ->
            ( { model
                | searchQuery = query
              }
            , Cmd.none
            )
