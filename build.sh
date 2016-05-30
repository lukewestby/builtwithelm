#!/bin/bash
elm-css src/Stylesheets.elm
elm-make src/Main.elm --output build/main.js
