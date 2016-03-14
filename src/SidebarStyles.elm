module SidebarStyles (css) where

import Css exposing (..)
import Css.Elements exposing (..)
import SharedStyles exposing (..)


css =
  [ h1
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
  ]
