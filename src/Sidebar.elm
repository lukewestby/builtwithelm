module Sidebar (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
import SharedStyles exposing (..)


{ class } =
  builtwithelmNamespace


view : Html
view =
  div
    [ class [ Sidebar ]
    ]
    [ div
        [ class [ SidebarHeader ] ]
        [ div
            [ class [ SidebarLogoContainer ]
            ]
            [ a
                [ href "" ]
                [ img [ src "assets/logo.svg", class [ Logo ] ] [] ]
            ]
        , h1
            []
            [ a
                [ href ""
                , class [ BuiltWithLink ]
                ]
                [ span
                    [ class [ BuiltWithText ]
                    ]
                    [ text "builtwith" ]
                , span [] [ text "elm" ]
                ]
            ]
        ]
    , div
        [ class [ SubmitProject ]
        ]
        [ h3
            [ class [ SubmitProjectHeader ]
            ]
            [ text "Submit a project" ]
        , p
            []
            [ span [] [ text "Submit a pull request or post an issue to " ]
            , a [ href "https://github.com/elm-community/builtwithelm" ] [ text "the Github repo" ]
            , span [] [ text ". Please include a screenshot and ensure it is " ]
            , strong [] [ text "1000px x 800px" ]
            , span [] [ text "." ]
            ]
        ]
    , div
        [ class [ BuiltBy ]
        ]
        [ span [] [ text "Built by " ]
        , a [ href "https://twitter.com/luke_dot_js" ] [ text "Luke Westby" ]
        , span [] [ text " and " ]
        , a [ href "https://github.com/elm-community/builtwithelm/graphs/contributors" ] [ text "the amazing Elm community." ]
        ]
    ]
