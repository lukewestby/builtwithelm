module SharedStyles (..) where

import Html.CssHelpers exposing (namespace)


type CssClasses
  = Container
  | Sidebar
  | Content
  | ListContainer
  | Paging
  | Button


type CssIds
  = ReactiveLogo
  | BuyTickets


builtwithelmNamespace =
  namespace "builtwithelm"
