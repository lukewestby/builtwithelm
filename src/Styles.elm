module Styles exposing (CssClasses(..), builtWithElmNamespace)


builtWithElmNamespace : String
builtWithElmNamespace =
    "builtwithelm-"


type CssClasses
    = Container
    | Sidebar
    | SidebarHeader
    | SidebarLogoContainer
    | Content
    | ListContainer
    | Paging
    | Button
    | Dropdown
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
    | SearchContainer
    | SearchInput
