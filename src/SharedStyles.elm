module SharedStyles exposing (..)

import Html.CssHelpers exposing (namespace)


type CssClasses
    = Container
    | Sidebar
    | SidebarHeader
    | SidebarLogoContainer
    | Content
    | ListContainer
    | Paging
    | Button
    | Link
    | GithubLogo
    | Project
    | ProjectScreenshotShell
    | ProjectImage
    | ProjectHeader
    | Logo
    | BuiltWithText
    | BuiltWithLink
    | SubmitProject
    | SubmitProjectHeader
    | BuiltBy


builtwithelmNamespace =
    namespace "builtwithelm-"
