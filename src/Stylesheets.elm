module Stylesheets (..) where

import Css exposing (stylesheet)
import Css.File exposing (..)
import SharedStyles exposing (builtwithelmNamespace)
import Css.Namespace exposing (namespace)
import MainStyles
import ProjectStyles
import SidebarStyles


rules =
  (stylesheet << namespace builtwithelmNamespace.name)
    (List.concat
      [ MainStyles.css
      , ProjectStyles.css
      , SidebarStyles.css
      ]
    )


port files : CssFileStructure
port files =
  toFileStructure
    [ ( "assets/styles.css", compile rules ) ]
