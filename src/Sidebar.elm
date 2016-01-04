module Sidebar (..) where

import Html exposing (..)
import Html.Attributes exposing (..)


view : Html
view =
    div
        [ style
            [ ( "width", "240px" )
            , ( "height", "100%" )
            , ( "padding", "20px" )
            , ( "box-sizing", "border-box" )
            , ( "position", "fixed" )
            ]
        ]
        [ img [ src "assets/logo.svg" ] []
        , h1
            [ style
                [ ( "font-weight", "normal" )
                , ( "text-align", "center" )
                , ( "padding-bottom", "20px" )
                , ( "border-bottom", "1px solid #999999" )
                ]
            ]
            [ span
                [ style
                    [ ( "color", "#999999" ) ]
                ]
                [ text "builtwith" ]
            , span [] [ text "elm" ]
            ]
        , div
            [ style
                [ ( "border-bottom", "1px solid #999999" )
                , ( "margin-bottom", "20px" )
                ]
            ]
            [ h3
                [ style
                    [ ( "text-align", "center" ) ]
                ]
                [ text "Submit a project" ]
            , p
                [ style
                    [ ( "text-align", "justfied" ) ]
                ]
                [ span [] [ text "Submit a pull request or post an issue to " ]
                , a [ href "https://github.com/elm-community/builtwithelm" ] [ text "the Github repo" ]
                , span [] [ text ". Please include a screenshot and ensure it is " ]
                , strong [] [ text "1000px x 800px" ]
                , span [] [ text "." ]
                ]
            ]
        , div
            [ style
                [ ( "font-size", "0.9em" ) ]
            ]
            [ span [] [ text "Built by " ]
            , a [ href "https://twitter.com/luke_dot_js" ] [ text "Luke Westby" ]
            , span [] [ text " and " ]
            , a [ href "https://github.com/elm-community/builtwithelm/graphs/contributors" ] [ text "the amazing Elm community." ]
            ]
        ]
