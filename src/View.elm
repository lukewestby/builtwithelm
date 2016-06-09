module View exposing (..)

-- where

import Html exposing (Html, button, div, text, h2, a, img, span, strong, h1, p, h3, input)
import Html.Attributes exposing (style, disabled, href, src, type', placeholder, value, autofocus)
import Html.Events exposing (onClick, onInput)
import Model exposing (Model, Project)
import Update exposing (Msg(..))
import String


view : Model -> Html Msg
view model =
  let
    disablePrev =
      model.offset - model.limit < 0

    disableNext =
      model.offset + model.limit >= List.length model.projects
  in
    div
      [ style
          [ ( "display", "flex" )
          , ( "height", "100%" )
          , ( "position", "relative" )
          , ( "font-family", "Source Sans Pro" )
          ]
      ]
      [ viewSidebar model
      , div
          [ style
              [ ( "margin-left", "240px" )
              , ( "width", "calc(100% - 240px)" )
              , ( "padding", "20px 0" )
              ]
          ]
          [ div
              [ style
                  [ ( "padding", "0 20px" )
                  , ( "max-width", "920px" )
                  , ( "margin", "0 auto" )
                  ]
              ]
              <| viewList model
          , div
              [ style
                  [ ( "display", "flex" )
                  , ( "flex-direction", "row" )
                  , ( "justify-content", "center" )
                  , ( "width", "40%" )
                  , ( "margin", "auto" )
                  , ( "padding", "20px 0" )
                  ]
              ]
              [ viewPageButton Prev disablePrev "Newer"
              , viewPageButton Next disableNext "Older"
              ]
          ]
      ]


viewPageButton : Msg -> Bool -> String -> Html Msg
viewPageButton msg isDisabled label =
  let
    textColor =
      if isDisabled then
        "#e5e5e5"
      else
        "#5cb5cd"
  in
    button
      [ onClick msg
      , disabled isDisabled
      , style
          [ ( "font-family", "Helvetica" )
          , ( "font-size", "1.6em" )
          , ( "font-weigth", "400" )
          , ( "color", textColor )
          , ( "background-color", "#ffffff" )
          , ( "border", "2px solid #e5e5e5" )
          , ( "margin", "1px" )
          , ( "border-radius", "5px" )
          , ( "padding", "3px" )
          , ( "flex-basis", "50%" )
          , ( "outline", "0" )
          , ( "cursor", "pointer" )
          ]
      ]
      [ text label ]


viewList : Model -> List (Html Msg)
viewList model =
  let
    filterCriteria project =
      String.contains (String.toLower model.searchQuery) (String.toLower project.name)
  in
    if model.isLoading then
      [ h2 [] [ text "Loading" ] ]
    else if model.loadFailed then
      [ h2 [] [ text "Unable to load projects" ] ]
    else
      model.projects
        |> List.filter filterCriteria
        |> List.drop model.offset
        |> List.take model.limit
        |> List.map viewProject


viewOpenSourceLink : Project -> Html Msg
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
            [ src "assets/github.svg"
            , style
                [ ( "width", "2em" ) ]
            ]
            []
        ]

    Nothing ->
      span [] []


viewProject : Project -> Html Msg
viewProject project =
  div
    [ style
        [ ( "margin", "20px 0" )
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
            [ ( "background-image", "url(assets/screenshot_shell.svg)" )
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
                ]
            ]
            []
        ]
    ]


viewSidebar : Model -> Html Msg
viewSidebar model =
  div
    [ style
        [ ( "width", "240px" )
        , ( "height", "100%" )
        , ( "padding", "20px" )
        , ( "box-sizing", "border-box" )
        , ( "position", "fixed" )
        ]
    ]
    [ a
        [ href "" ]
        [ img [ src "assets/logo.svg" ] [] ]
    , h1
        [ style
            [ ( "font-weight", "normal" )
            , ( "text-align", "center" )
            , ( "padding-bottom", "20px" )
            , ( "border-bottom", "1px solid #999999" )
            ]
        ]
        [ a
            [ href ""
            , style
                [ ( "text-decoration", "none" )
                , ( "color", "inherit" )
                ]
            ]
            [ span
                [ style
                    [ ( "color", "#999999" ) ]
                ]
                [ text "builtwith" ]
            , span [] [ text "elm" ]
            ]
        ]
    , div
        [ style
            [ ( "border-bottom", "1px solid #999999" )
            , ( "margin-bottom", "20px" )
            ]
        ]
        [ input
            [ type' "text"
            , placeholder "Search"
            , value model.searchQuery
            , autofocus True
            , onInput UpdateSearchQuery
            , style
                [ ("width", "191px")
                , ("font-size", "1em")
                , ("padding", "4px")
                , ("margin", "10px 0")
                , ("border", "1px solid #eeeeee")
                , ("border-radius", "6px")
                ]
            ] []
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
