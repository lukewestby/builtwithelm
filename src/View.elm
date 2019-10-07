module View exposing (view)

import Browser exposing (Document)
import Css.Global
import Html.Styled exposing (Html, button, div, h3, img, input, label, option, select, span, strong, text)
import Html.Styled.Attributes exposing (autofocus, css, disabled, href, placeholder, src, style, target, type_, value)
import Html.Styled.Events exposing (onClick, onInput)
import Html.Styled.Keyed
import Model exposing (Model, Project)
import Styles exposing (a, h1, h2, p)
import Update exposing (Msg(..))


view : Model -> Document Msg
view model =
    let
        disablePrev =
            model.page == 0

        disableNext =
            model.page * model.pageSize + model.pageSize >= List.length model.projects
    in
    { title = ""
    , body =
        [ Html.Styled.toUnstyled <|
            div [ css Styles.container ]
                [ viewSidebar model
                , div
                    [ css Styles.content
                    ]
                    [ Html.Styled.Keyed.node "div"
                        [ css Styles.listContainer ]
                        (viewList model)
                    , div [ css Styles.paging ]
                        [ viewPageSizeSelect SetPageSize model.pageSize [ 5, 25, 50, 100 ]
                        , viewPageButton Prev disablePrev "Newer"
                        , viewPageButton Next disableNext "Older"
                        ]
                    ]
                ]
        , Html.Styled.toUnstyled <| Css.Global.global [ Styles.body ]
        ]
    }


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
        , css Styles.button
        ]
        [ text label ]


viewPageSizeSelect : (String -> Msg) -> Int -> List Int -> Html Msg
viewPageSizeSelect msg current options =
    let
        toOption i =
            option [ value <| String.fromInt i ]
                [ text <| String.fromInt i ]
    in
    div [ css Styles.dropdown ]
        [ label []
            [ text "Page size" ]
        , select [ value <| String.fromInt current, onInput msg ]
            (List.map toOption options)
        ]


viewList : Model -> List ( String, Html Msg )
viewList model =
    let
        filterCriteria project =
            String.contains (String.toLower model.searchQuery) (String.toLower project.name)
    in
    if model.isLoading then
        [ ( "", h2 [] [ text "Loading" ] ) ]

    else if model.loadFailed then
        [ ( "", h2 [] [ text "Unable to load projects" ] ) ]

    else
        model.projects
            |> List.filter filterCriteria
            |> List.drop (model.page * model.pageSize)
            |> List.take model.pageSize
            |> List.map (\p -> ( p.primaryUrl, viewProject p ))


viewOpenSourceLink : Project -> Html Msg
viewOpenSourceLink project =
    case project.repositoryUrl of
        Just url ->
            a
                [ href url
                , target "_blank"
                , css Styles.link
                ]
                [ img
                    [ src "assets/github.svg"
                    , css Styles.githubLogo
                    ]
                    []
                ]

        Nothing ->
            span [] []


viewProject : Project -> Html Msg
viewProject project =
    div [ css Styles.project ]
        [ div [ css Styles.projectHeader ]
            [ a
                [ href project.primaryUrl
                , target "_blank"
                , css Styles.link
                ]
                [ h2 []
                    [ text project.name ]
                ]
            , viewOpenSourceLink project
            ]
        , p [] [ text project.description ]
        , div [ css Styles.projectScreenshotShell ]
            [ img
                [ src project.previewImageUrl
                , css Styles.projectImage
                ]
                []
            ]
        ]


viewSidebar : Model -> Html Msg
viewSidebar model =
    div [ css Styles.sidebar ]
        [ div [ css Styles.sidebarHeader ]
            [ div
                [ css Styles.sidebarLogoContainer
                ]
                [ a [ href "/" ]
                    [ img [ src "assets/logo.svg", css Styles.logo ] [] ]
                ]
            , h1 []
                [ a
                    [ href "/"
                    , css Styles.builtWithLink
                    ]
                    [ span
                        [ css Styles.builtWithText
                        ]
                        [ text "builtwith" ]
                    , span [] [ text "elm" ]
                    ]
                ]
            ]
        , div [ css Styles.searchContainer ]
            [ input
                [ type_ "text"
                , placeholder "Search"
                , value model.searchQuery
                , autofocus True
                , onInput UpdateSearchQuery
                , css Styles.searchInput
                ]
                []
            ]
        , div [ css Styles.submitProject ]
            [ h3 [ css Styles.submitProjectHeader ]
                [ text "Submit a project" ]
            , p []
                [ span [] [ text "Submit a pull request or post an issue to " ]
                , a [ href "https://github.com/elm-community/builtwithelm", target "_blank" ] [ text "the Github repo" ]
                , span [] [ text ". Please include a screenshot and ensure it is " ]
                , strong [] [ text "1000px x 800px" ]
                , span [] [ text "." ]
                ]
            ]
        , div [ css Styles.builtBy ]
            [ span [] [ text "Built by " ]
            , a [ href "https://github.com/lukewestby", target "_blank" ] [ text "Luke Westby" ]
            , span [] [ text " and " ]
            , a [ href "https://github.com/elm-community/builtwithelm/graphs/contributors", target "_blank" ] [ text "the amazing Elm community." ]
            ]
        ]
