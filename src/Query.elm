module Query exposing (pageUrl, parsePage)

import Url exposing (Url)
import Url.Parser exposing ((<?>), Parser)
import Url.Parser.Query


pageParser : Parser (Maybe Int -> a) a
pageParser =
    Url.Parser.top <?> Url.Parser.Query.int "page"


parsePage : Url -> Int
parsePage =
    Url.Parser.parse pageParser
        >> Maybe.withDefault Nothing
        >> Maybe.withDefault 0


pageUrl : Int -> String
pageUrl page =
    if page == 0 then
        "/"

    else
        "?page=" ++ String.fromInt page
