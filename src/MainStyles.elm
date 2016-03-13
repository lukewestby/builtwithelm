module MainStyles (css) where

import Css exposing (..)
import Css.Elements exposing (..)
import SharedStyles exposing (..)


css =
  [ body
      [ margin (px 0)
      , height (pct 100)
      ]
  , nav
      [ display inlineBlock
      , paddingBottom (px 12)
      ]
  , ((.) Button)
      [ property "font-family" "Helvetica"
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
      , property "outline" "0px"
      , property "cursor" "pointer"
      , disabled
          [ color (hex "e5e5e5")
          ]
      ]
  , ((.) Container)
      [ property "display" "flex"
      , height (pct 100)
      , position relative
      , property "font-family" "Source Sans Pro"
      ]
  , ((.) Sidebar)
      [ width (px 240)
      , height (pct 100)
      , padding (px 20)
      , position fixed
      ]
  , ((.) Content)
      [ marginLeft (px 240)
      , property "width" "calc(100% - 240px)"
      , paddingTop (px 20)
      , paddingRight (px 0)
      , paddingBottom (px 20)
      , paddingLeft (px 0)
      ]
  , ((.) ListContainer)
      [ paddingTop (px 0)
      , paddingRight (px 20)
      , paddingBottom (px 0)
      , paddingLeft (px 20)
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
  ]
