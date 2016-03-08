module Stylesheets (..) where

import Css exposing (stylesheet)
import Css.File exposing (..)
import Css.Namespace exposing (namespace)
import SharedStyles exposing (builtwithelmNamespace)
import MainStylesheet


rules = (stylesheet << namespace builtwithelmNamespace.name)
  (List.concat
    [ MainStylesheet.css
    ]
  )

port files : CssFileStructure
port files =
  toFileStructure
    [ ( "assets/styles.css", compile rules ) ]
