#!/bin/bash
elm-css src/Stylesheets.elm
elm-make src/Main.elm --output build/main.js
uglifyjs ./build/main.js --output ./build/main.js --screw-ie8 --compress dead_code,pure_getters,negate_iife,cascade,hoist_funs --mangle toplevel=true 
