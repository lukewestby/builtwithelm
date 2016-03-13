module ProjectStyles (css) where

import Css exposing (..)
import Css.Elements exposing (..)
import SharedStyles exposing (..)


css =
  [ ((.) Link)
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
  ]
