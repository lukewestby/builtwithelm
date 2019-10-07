module Styles exposing (..)

import Css exposing (..)
import Css.Global exposing (Snippet, descendants, everything, selector)
import Css.Media exposing (MediaQuery)
import Html.Styled exposing (Attribute, Html)
import Html.Styled.Attributes exposing (css)


mediumScreen : List MediaQuery
mediumScreen =
    [ Css.Media.only Css.Media.screen [ Css.Media.maxWidth (px 768) ] ]


smallScreen : List MediaQuery
smallScreen =
    [ Css.Media.only Css.Media.screen [ Css.Media.maxWidth (px 570) ] ]


p : List (Attribute msg) -> List (Html msg) -> Html msg
p attrs children =
    Html.Styled.p (css [ textAlign justify ] :: attrs) children


h1 : List (Attribute msg) -> List (Html msg) -> Html msg
h1 attrs children =
    Html.Styled.h1
        (css
            [ property "font-weight" "normal"
            , textAlign center
            , paddingBottom (px 20)
            , borderBottom3 (px 1) solid (hex "999999")
            , Css.Media.withMedia mediumScreen
                [ flex (int 1)
                , borderStyle none
                , property "display" "flex"
                , flexDirection column
                , property "justify-content" "center"
                , fontSize (em 3)
                , paddingBottom (px 0)
                ]
            , Css.Media.withMedia smallScreen [ fontSize (em 1.8) ]
            ]
            :: attrs
        )
        children


h2 : List (Attribute msg) -> List (Html msg) -> Html msg
h2 attrs children =
    Html.Styled.h2 (css [ margin (px 0) ] :: attrs) children


a : List (Attribute msg) -> List (Html msg) -> Html msg
a attrs children =
    Html.Styled.a (css [ property "color" "inherit" ] :: attrs) children


body : Snippet
body =
    selector "body"
        [ margin (px 0)
        , height (pct 100)
        , descendants
            [ everything
                [ boxSizing borderBox
                ]
            ]
        ]


container : List Style
container =
    [ property "display" "flex"
    , height (pct 100)
    , position relative
    , fontFamilies [ qt "Source Sans Pro" ]
    , Css.Media.withMedia mediumScreen [ flexDirection column ]
    ]


content : List Style
content =
    [ marginLeft (px 240)
    , property "width" "calc(100% - 240px)"
    , paddingTop (px 20)
    , paddingRight (px 0)
    , paddingBottom (px 20)
    , paddingLeft (px 20)
    , Css.Media.withMedia mediumScreen
        [ marginLeft auto
        , width auto
        , paddingLeft (px 0)
        ]
    ]


listContainer : List Style
listContainer =
    [ padding4 (px 0) (px 20) (px 0) (px 20)
    , maxWidth (px 920)
    , marginTop (px 0)
    , marginBottom (px 0)
    , marginLeft auto
    , marginRight auto
    ]


paging : List Style
paging =
    [ property "display" "flex"
    , flexDirection row
    , property "justify-content" "center"
    , property "align-items" "center"
    , width (pct 50)
    , margin auto
    ]


button : List Style
button =
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


dropdown : List Style
dropdown =
    [ fontFamilies [ "Helvetica" ]
    , backgroundColor (rgb 255 255 255)
    , margin (px 1)
    , padding (px 3)
    , flexBasis (pct 50)
    , minWidth (px 100)
    , property "outline" "0"
    ]


link : List Style
link =
    [ property "color" "inherit"
    ]


githubLogo : List Style
githubLogo =
    [ width (em 2)
    ]


project : List Style
project =
    [ marginBottom (px 40)
    ]


projectHeader : List Style
projectHeader =
    [ property "display" "flex"
    , property "justify-content" "space-between"
    ]


projectScreenshotShell : List Style
projectScreenshotShell =
    [ property "background-image" "url(screenshot_shell.svg)"
    , property "background-size" "contain"
    , maxWidth (px 1040)
    , maxHeight (px 850)
    , padding (pct 1.875)
    , paddingTop (pct 2.875)
    , property "background-repeat" "no-repeat"
    ]


projectImage : List Style
projectImage =
    [ width (pct 100)
    ]


sidebar : List Style
sidebar =
    [ width (px 240)
    , height (pct 100)
    , padding (px 20)
    , position fixed
    , overflow auto
    , Css.Media.withMedia mediumScreen
        [ position static
        , height auto
        , width auto
        ]
    ]


sidebarHeader : List Style
sidebarHeader =
    [ property "display" "flex"
    , flexDirection column
    , Css.Media.withMedia mediumScreen
        [ flexDirection row
        , paddingBottom (px 20)
        , borderBottomStyle solid
        , borderBottomColor (hex "999999")
        , borderBottomWidth (px 1)
        ]
    ]


sidebarLogoContainer : List Style
sidebarLogoContainer =
    [ Css.Media.withMedia mediumScreen
        [ flex (int 1)
        , maxWidth (pct 40)
        ]
    ]


builtWithText : List Style
builtWithText =
    [ color (hex "999999") ]


builtWithLink : List Style
builtWithLink =
    [ textDecoration none ]


submitProject : List Style
submitProject =
    [ borderBottom3 (px 1) solid (hex "999999")
    , marginBottom (px 20)
    ]


submitProjectHeader : List Style
submitProjectHeader =
    [ textAlign center ]


builtBy : List Style
builtBy =
    [ fontSize (em 0.9) ]


searchInput : List Style
searchInput =
    [ width (px 191)
    , fontSize (em 1)
    , padding (px 4)
    , margin2 (px 10) zero
    , border3 (px 1) solid (hex "eeeeee")
    , borderRadius (px 6)
    , Css.Media.withMedia mediumScreen [ width (pct 100) ]
    ]


searchContainer : List Style
searchContainer =
    [ borderBottom3 (px 1) solid (hex "999999")
    , marginBottom (px 20)
    ]


logo : List Style
logo =
    [ Css.Media.withMedia mediumScreen
        [ display block
        , margin (px 0)
        , maxWidth (pct 100)
        ]
    ]
