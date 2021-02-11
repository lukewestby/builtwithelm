module Update exposing (Msg(..), init, update)

import Browser exposing (UrlRequest(..))
import Browser.Navigation exposing (Key)
import Cmds exposing (loadProjects, newPage, notifyOffsetChanged)
import Http
import Model exposing (Model, Project)
import Query exposing (parsePage)
import Url exposing (Url)


type Msg
    = NoOp
    | Next
    | Prev
    | SetPageSize String
    | LoadProjects (Result Http.Error (List Project))
    | UpdateSearchQuery String
    | OnUrlRequest UrlRequest
    | OnUrlChange Url


init : () -> Url -> Key -> ( Model, Cmd Msg )
init _ url key =
    let
        page =
            parsePage url
    in
    ( { key = key
      , projects = []
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

        Next ->
            ( model, newPage model.key (model.page + 1) )

        Prev ->
            ( model, newPage model.key (model.page - 1) )

        SetPageSize selected ->
            ( { model | pageSize = Maybe.withDefault 5 (String.toInt selected) }
            , Cmd.none
            )

        UpdateSearchQuery query ->
            ( { model
                | searchQuery = query
              }
            , Cmd.none
            )

        OnUrlChange url ->
            ( { model
                | page = parsePage url
              }
            , notifyOffsetChanged
            )

        OnUrlRequest urlRequest ->
            case urlRequest of
                Internal url ->
                    ( model, Browser.Navigation.pushUrl model.key (Url.toString url) )

                External url ->
                    ( model, Browser.Navigation.load url )
