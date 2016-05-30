module Project exposing (Project, decoder, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Json.Decode exposing (..)
import SharedStyles exposing (..)


{ class } =
    builtwithelmNamespace
type alias Project =
    { previewImageUrl : String
    , name : String
    , primaryUrl : String
    , description : String
    , repositoryUrl : Maybe String
    }


decoder : Decoder (List Project)
decoder =
    Json.Decode.list
        <| object5 Project
            ("previewImageUrl" := string)
            ("name" := string)
            ("primaryUrl" := string)
            ("description" := string)
            (maybe ("repositoryUrl" := string))


viewOpenSourceLink : Project -> Html
viewOpenSourceLink project =
    case project.repositoryUrl of
        Just url ->
            a
                [ href url
                , class [ Link ]
                ]
                [ img
                    [ src "assets/github.svg"
                    , class [ GithubLogo ]
                    ]
                    []
                ]

        Nothing ->
            span [] []


view : Project -> Html
view project =
    div
        [ class [ SharedStyles.Project ]
        ]
        [ div
            [ class [ ProjectHeader ]
            ]
            [ a
                [ href project.primaryUrl
                , class [ Link ]
                ]
                [ h2 []
                    [ text project.name ]
                ]
            , viewOpenSourceLink project
            ]
        , p [] [ text project.description ]
        , div
            [ class [ ProjectScreenshotShell ]
            ]
            [ img
                [ src project.previewImageUrl
                , class [ ProjectImage ]
                ]
                []
            ]
        ]
