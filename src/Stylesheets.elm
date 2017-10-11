port module Stylesheets exposing (..)

import Css exposing (..)
import Css.Elements exposing (..)
import Css.Namespace exposing (namespace)
import Css.File exposing (..)
import Styles exposing (CssClasses(..), builtWithElmNamespace)


port files : CssFileStructure -> Cmd msg


css : Stylesheet
css =
    (stylesheet << namespace builtWithElmNamespace)
        [ body
            [ margin (px 0)
            , height (pct 100)
            , descendants
                [ everything
                    [ boxSizing borderBox
                    ]
                ]
            ]
        , nav
            [ display inlineBlock
            , paddingBottom (px 12)
            ]
        , ((.) Button)
            [ fontFamilies [ "Helvetica" ]
            , fontSize (em 1.6)
            , fontWeight (int 400)
            , color (hex "5cb5cd")
            , backgroundColor (rgb 255 255 255)
            , property "border-width" "2px"
            , borderStyle solid
            , borderColor (hex "e5e5e5")
            , margin (px 1)
            , borderRadius (px 5)
            , padding (px 3)
            , flexBasis (pct 50)
            , minWidth (px 100)
            , property "outline" "0"
            , property "cursor" "pointer"
            , disabled
                [ color (hex "e5e5e5")
                ]
            ]
        , ((.) Container)
            [ property "display" "flex"
            , height (pct 100)
            , position relative
            , fontFamilies [ qt "Source Sans Pro" ]
            ]
        , ((.) Sidebar)
            [ width (px 240)
            , height (pct 100)
            , padding (px 20)
            , position fixed
            , overflow auto
            ]
        , ((.) Content)
            [ marginLeft (px 240)
            , property "width" "calc(100% - 240px)"
            , paddingTop (px 20)
            , paddingRight (px 0)
            , paddingBottom (px 20)
            , paddingLeft (px 20)
            ]
        , ((.) ListContainer)
            [ padding4 (px 0) (px 20) (px 0) (px 20)
            , maxWidth (px 920)
            , marginTop (px 0)
            , marginBottom (px 0)
            , marginLeft auto
            , marginRight auto
            ]
        , ((.) Paging)
            [ property "display" "flex"
            , flexDirection row
            , property "justify-content" "center"
            , width (pct 40)
            , margin auto
            ]
        , ((.) Link)
            [ property "color" "inherit"
            ]
        , ((.) GithubLogo)
            [ width (em 2)
            ]
        , ((.) Project)
            [ marginBottom (px 40)
            ]
        , ((.) ProjectHeader)
            [ property "display" "flex"
            , property "justify-content" "space-between"
            ]
        , h2
            [ margin (px 0)
            ]
        , ((.) ProjectScreenshotShell)
            [ property "background-image" "url(screenshot_shell.svg)"
            , property "background-size" "contain"
            , maxWidth (px 1040)
            , maxHeight (px 850)
            , padding (pct 1.875)
            , paddingTop (pct 2.875)
            , property "background-repeat" "no-repeat"
            ]
        , ((.) ProjectImage)
            [ width (pct 100)
            ]
        , h1
            [ property "font-weight" "normal"
            , textAlign center
            , paddingBottom (px 20)
            , borderBottom3 (px 1) solid (hex "999999")
            ]
        , ((.) SidebarHeader)
            [ property "display" "flex"
            , flexDirection column
            ]
        , a
            [ property "color" "inherit"
            ]
        , p
            [ textAlign textJustify
            ]
        , ((.) BuiltWithText)
            [ color (hex "999999")
            ]
        , ((.) BuiltWithLink)
            [ textDecoration none
            ]
        , ((.) SubmitProject)
            [ borderBottom3 (px 1) solid (hex "999999")
            , marginBottom (px 20)
            ]
        , ((.) SubmitProjectHeader)
            [ textAlign center
            ]
        , ((.) BuiltBy)
            [ fontSize (em 0.9)
            ]
        , ((.) SearchInput)
            [ width (px 191)
            , fontSize (em 1)
            , padding (px 4)
            , margin2 (px 10) zero
            , border3 (px 1) solid (hex "eeeeee")
            , borderRadius (px 6)
            ]
        , ((.) SearchContainer)
            [ borderBottom3 (px 1) solid (hex "999999")
            , marginBottom (px 20)
            ]
        , mediaQuery "screen and (max-width: 768px)"
            [ ((.) Container)
                [ flexDirection column
                ]
            , ((.) Sidebar)
                [ position static
                , height auto
                , width auto
                ]
            , ((.) Logo)
                [ display block
                , maxWidth (pct 33)
                , marginTop (px 0)
                , marginBottom (px 0)
                , marginLeft auto
                , marginRight auto
                ]
            , ((.) Content)
                [ marginLeft auto
                , width auto
                , paddingLeft (px 0)
                ]
            , ((.) SidebarHeader)
                [ flexDirection row
                , paddingBottom (px 20)
                , borderBottomStyle solid
                , borderBottomColor (hex "999999")
                , borderBottomWidth (px 1)
                ]
            , ((.) SidebarLogoContainer)
                [ flex (int 1)
                , maxWidth (pct 40)
                ]
            , ((.) SearchInput)
                [ width (pct 100)
                ]
            , h1
                [ flex (int 1)
                , borderStyle none
                , property "display" "flex"
                , flexDirection column
                , property "justify-content" "center"
                , fontSize (em 3)
                , paddingBottom (px 0)
                ]
            , ((.) Logo)
                [ margin (px 0)
                , maxWidth (pct 100)
                ]
            ]
        , mediaQuery "screen and (max-width: 570px)"
            [ h1
                [ fontSize (em 1.8)
                ]
            ]
        ]


cssFiles : CssFileStructure
cssFiles =
    toFileStructure [ ( "assets/styles.css", Css.File.compile [ css ] ) ]


main : CssCompilerProgram
main =
    Css.File.compiler files cssFiles
