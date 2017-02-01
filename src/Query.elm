module Query exposing (pageUrl, parsePage)

import Navigation exposing (Location)
import UrlParser exposing (..)


pageParser : Parser (Maybe Int -> a) a
pageParser =
    map (\_ n -> n) <| string <?> intParam "page"


parsePage : Location -> Int
parsePage =
    parsePath pageParser
        >> Maybe.withDefault Nothing
        >> Maybe.withDefault 0


pageUrl : Int -> String
pageUrl page =
    if page == 0 then
        "/"
    else
        "?page=" ++ (toString page)
