module Main exposing (..)

import StartApp
import Task exposing (Task)
import Effects exposing (Effects)
import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Request
import Project exposing (Project)
import Sidebar
import Signal exposing (Address)
import SharedStyles exposing (..)


{ class } =
    builtwithelmNamespace



-- Init


type alias Model =
    { projects : List Project
    , isLoading : Bool
    , loadFailed : Bool
    , offset : Int
    , limit : Int
    }


init : ( Model, Effects Action )
init =
    ( Model [] True False 0 5
    , loadList ()
    )



-- Update


type Action
    = None
    | Prev
    | Next
    | LoadProjectsStart
    | LoadProjectsSuccess (List Project)
    | LoadProjectsError Request.Error


update : Action -> Model -> ( Model, Effects Action )
update action model =
    case action of
        None ->
            ( model, Effects.none )

        Prev ->
            let
                offset =
                    model.offset

                limit =
                    model.limit
            in
                if offset - limit >= 0 then
                    ( { model
                        | offset = offset - limit
                      }
                    , Effects.none
                    )
                else
                    ( model, Effects.none )

        Next ->
            let
                offset =
                    model.offset

                limit =
                    model.limit
            in
                if offset + limit < List.length model.projects then
                    ( { model
                        | offset = offset + limit
                      }
                    , Effects.none
                    )
                else
                    ( model, Effects.none )

        LoadProjectsStart ->
            ( { model
                | isLoading = True
              }
            , loadList ()
            )

        LoadProjectsSuccess projects ->
            ( { model
                | projects = projects
                , isLoading = False
              }
            , Effects.none
            )

        LoadProjectsError error ->
            ( { model
                | loadFailed = True
              }
            , Effects.none
            )



-- Effects


loadList : () -> Effects Action
loadList () =
    Request.getWithRetries "data/projects.json" Project.decoder 5
        |> Task.map LoadProjectsSuccess
        |> flip Task.onError (LoadProjectsError >> Task.succeed)
        |> Effects.task



-- View


view : Signal.Address Action -> Model -> Html
view address model =
    let
        offset =
            model.offset

        limit =
            model.limit

        disablePrev =
            offset - limit < 0

        disableNext =
            offset + limit >= List.length model.projects
    in
        div
            [ class [ Container ]
            ]
            [ Sidebar.view
            , div
                [ class [ Content ]
                ]
                [ div
                    [ class [ ListContainer ]
                    ]
                    <| viewList model
                , div
                    [ class [ Paging ]
                    ]
                    [ pageButton address Prev disablePrev "Newer"
                    , pageButton address Next disableNext "Older"
                    ]
                ]
            ]


pageButton : Address a -> a -> Bool -> String -> Html
pageButton address action disabled' label =
    button
        [ onClick address action
        , disabled disabled'
        , class [ Button ]
        ]
        [ text label ]


viewList : Model -> List Html
viewList model =
    if model.isLoading then
        [ h2 [] [ text "Loading" ] ]
    else if model.loadFailed then
        [ h2 [] [ text "Unable to load projects" ] ]
    else
        model.projects
            |> List.drop model.offset
            |> List.take model.limit
            |> List.map Project.view



-- StartApp


app : StartApp.App Model
app =
    StartApp.start
        { init = init
        , update = update
        , view = view
        , inputs = []
        }


main : Signal Html
main =
    app.html


port tasks : Signal (Task Effects.Never ())
port tasks =
    app.tasks


port currentOffset : Signal Int
port currentOffset =
    app.model
        |> Signal.map .offset
        |> Signal.dropRepeats
