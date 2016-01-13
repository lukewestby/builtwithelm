module MainStyles (css) where

import Css exposing (..)
import Css.Elements exposing (..)
import ClassNames exposing (..)

css =
  stylesheet { name = "Main" }
    . OuterContainer
