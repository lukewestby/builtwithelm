module Project (Project, decoder, view) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Json.Decode exposing (..)


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
        <| object5
            Project
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
                , style
                    [ ( "color", "inherit" )
                    ]
                ]
                [ img
                    [ src "/assets/github.svg"
                    , style
                        [ ( "width", "2em" ) ]
                    ]
                    []
                ]

        Nothing ->
            span [] []


view : Project -> Html
view project =
    div
        [ style
            [ ( "box-sizing", "border-box" )
            , ( "margin-bottom", "60px" )
            ]
        ]
        [ div
            [ style
                [ ( "display", "flex" )
                , ( "justify-content", "space-between" )
                ]
            ]
            [ a
                [ href project.primaryUrl
                , style
                    [ ( "color", "inherit" ) ]
                ]
                [ h2
                    [ style
                        [ ( "margin", "0" ) ]
                    ]
                    [ text project.name ]
                ]
            , viewOpenSourceLink project
            ]
        , p [] [ text project.description ]
        , div
            [ style
                [ ( "background-image", "url(/assets/screenshot_shell.svg)" )
                , ( "background-size", "contain" )
                , ( "max-width", "1040px" )
                , ( "max-height", "850px" )
                , ( "padding", "1.875%" )
                , ( "padding-top", "2.875%" )
                , ( "background-repeat", "no-repeat" )
                ]
            ]
            [ img
                [ src project.previewImageUrl
                , style
                    [ ( "width", "100%" )
                    , ( "min-height", "75%" )
                    ]
                ]
                []
            ]
        ]
