# [Built With Elm](http://builtwithelm.co)

[![Build Status](https://travis-ci.org/elm-community/builtwithelm.svg?branch=master)](https://travis-ci.org/elm-community/builtwithelm)

A list of projects and apps built with Elm.

This site is meant to showcase the awesome work the Elm community is doing. I
wanted to create a place for people to have their work recognized, especially if
it is open source (proprietary projects definitely welcome though!), and stand
as examples for those who are new to the language.


## Submitting a project
Just submit a PR with your info added to the beginning of the array in
`/data/projects.json` and a screenshot in `/data/images`! Please ensure that the
screenshot is 1000px x 800px and take care to choose the best format and do some
optimization too. If your project is open source, fill in your repository url as
well as the url of your project. If it is not, just leave it as `null` (this
field is decoded with `Json.Decode.maybe` :smile:).


## Contributing
Want to contribute to this site? Nice! Submit a PR or leave an issue. Feedback
is encouraged and graciously accepted and my hope is that this can be a fun
community project for people of all skill levels to contribute. If you do
decide to submit code, please be sure to run it through
[elm-format](https://github.com/avh4/elm-format) prior to submitting your pull
request.

This project was originally built by
[lukewestby](https://github.com/lukewestby)(@luke in the elmlang Slack). It is
now maintained by [prikhi](https://github.com/prikhi), feel free to get in
touch with me at @lysergia in Slack.


## Updating the Site

If the only changes are additional projects, you should just be able to merge
the `master` branch into the `gh-pages` branch and push:

```bash
git checkout gh-pages
git merge master
git push
```

However, if there have been any code changes, you should rebuild the
application before pushing:

```bash
git checkout gh-pages
git merge master
npm install
npm run build
git commit -a -m"Build Site"
git push
```


-------
- Thanks to @driftyco for the github icon svg from ionicons!
- Thanks to http://builtwithreact.io and @trek's http://beautifulopen.com for
idea and design inspiration!
