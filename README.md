# hubot-fav

A Hubot script for favoriting a tweet.

## Installation

    $ npm install git://github.com/bouzuya/hubot-fav.git

or

    $ # TAG is the package version you need.
    $ npm install 'git://github.com/bouzuya/hubot-fav.git#TAG'

## Configuration

    $ export HUBOT_FAV_API_KEY='...'
    $ export HUBOT_FAV_API_SECRET='...'
    $ export HUBOT_FAV_ACCESS_TOKEN='...'
    $ export HUBOT_FAV_ACCESS_TOKEN_SECRET='...'

## Commands

    bouzuya> hubot help fav
    hubot> hubot fav <tweet url> - favoriting a tweet

    bouzuya> hubot fav https://twitter.com/bouzuya/status/489046087445929985
    hubot> https://twitter.com/bouzuya/status/489046087445929985

## License

MIT

## Badges

[![Build Status][travis-status]][travis]

[travis]: https://travis-ci.org/bouzuya/hubot-fav
[travis-status]: https://travis-ci.org/bouzuya/hubot-fav.svg?branch=master
