module Main (..) where

import StartApp
import Task exposing (Task)
import Effects exposing (Effects)
import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Debug
import Request
import Project exposing (Project)
import Sidebar
import Signal exposing (Address)


-- Init

limit : Int
limit = 5


type alias Model =
    { projects : List Project
    , isLoading : Bool
    , loadFailed : Bool
    , offset : Int
    }


init : ( Model, Effects Action )
init =
    ( Model [] True False 0
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
    Debug.log "model"
        <| case action of
            None ->
                ( model, Effects.none )

            Prev ->
                if model.offset - limit >= 0 then
                    ( { model
                        | offset = model.offset - limit
                      }
                    , Effects.none
                    )
                else
                    ( model, Effects.none )

            Next ->
                if model.offset + limit < List.length model.projects then
                    ( { model
                        | offset = model.offset + limit
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
    div
        [ style
            [ ( "display", "flex" )
            , ( "height", "100%" )
            , ( "position", "relative" )
            , ( "font-family", "Source Sans Pro" )
            ]
        ]
        [ Sidebar.view
        , div
            [ style
                [ ( "margin-left", "240px" )
                , ( "width", "calc(100% - 240px)" )
                ]
            ]
            [ div
                [ style
                    [ ( "padding", "20px" )
                    , ( "max-width", "920px" )
                    , ( "margin", "0 auto" )
                    ]
                ]
                <| viewList model
            , div
                [ style
                    [ ( "display", "flex" )
                    , ( "flex-direction", "row" )
                    ]
                ]
                [ pageButton address Prev "Newer"
                , pageButton address Next "Older"
                ]
            ]
        ]

pageButton : Address a -> a -> String -> Html
pageButton address action label =
    button
        [ onClick address action ]
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
            |> List.take limit
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
