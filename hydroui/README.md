# Hydrome UI

## Overview
This directory contains all Hydro UI source code.

## Requirements
ELM 0.18.X
Bootstrap 4.X and related js/jquery requirments. (Note: the minified css/js files
required are added to the repo; if you want to run using the bootstrap CDN
uncomment the relevant section in `hydroui/index.html`; you might want to do this
because you don't want these requirement files in the repo or you want to run
from the latest bootstrap release).

## Installation
* [ELM installation documentation](https://guide.elm-lang.org/install.html)
* install ELM packager `elm-package install` (this will install everything in `elm-packager.json`)
* download boostrap 4, from [here](https://getbootstrap.com/) and put into the root dir
  * alternatively you can uncomment the CDN links/refs in index.html

## Style
Please configure your editor as in the ELM installation instruction above.
The ELM linters, syntax checkers, and auto-style libraries will make your life
a lot easier. For vim, use [elm-vim](https://github.com/ElmCast/elm-vim).

## Build/Run
* To build run `elm-make ./src/Main.elm --output main.js` in `hydroui` root dir
  * To build with the ELM UI debugger add `--debug` flag
* open `index.html` and you that's it!
