#!/bin/bash
elm-css src/Stylesheet.elm
elm-make src/Main.elm --output build/main.js
