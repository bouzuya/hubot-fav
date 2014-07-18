# Description
#   fav
#
# Dependencies:
#   "q": "^1.0.1",
#   "twitter": "^0.2.9"
#
# Configuration:
#   HUBOT_FAV_API_KEY
#   HUBOT_FAV_API_SECRET
#   HUBOT_FAV_ACCESS_TOKEN
#   HUBOT_FAV_ACCESS_TOKEN_SECRET
#
# Commands:
#   hubot fav <tweet> - favoriting a tweet
#
# Author:
#   bouzuya <m@bouzuya.net>
#
{Promise} = require 'q'
Twitter = require 'twitter'

module.exports = (robot) ->
  fav = (id) ->
    new Promise (resolve, reject) ->
      new Twitter(
        consumer_key: process.env.HUBOT_FAV_API_KEY
        consumer_secret: process.env.HUBOT_FAV_API_SECRET
        access_token_key: process.env.HUBOT_FAV_ACCESS_TOKEN
        access_token_secret: process.env.HUBOT_FAV_ACCESS_TOKEN_SECRET
      ).createFavorite { id: id }, (data) ->
        if data instanceof Error
          reject(data)
        else
          name = data.user.screen_name
          id = data.id_str
          url = 'https://twitter.com/' + name + '/status/' + id
          resolve(url)

  pattern = new RegExp 'fav https://twitter.com/[^/]+/status/(\\d+)\\s*$', 'i'
  robot.respond pattern, (res) ->
    fav res.match[1]
      .then (url) ->
        res.send url
      , (err) ->
        robot.logger.error err
        res.send 'fav error'
