require '../helper'

describe 'fav', ->

  beforeEach (done) ->
    @kakashi.scripts = [require '../../src/scripts/fav']
    @kakashi.users = [{ id: 'bouzuya', room: 'hitoridokusho' }]
    @kakashi.start().then done, done

  afterEach (done) ->
    @kakashi.stop().then done, done

  describe '''
    receive "@hubot fav https://twitter.com/bouzuya/status/489046087445929985"
    ''', ->
    beforeEach ->
      Twitter = require 'twitter'
      originalPost = Twitter.prototype.post
      @sinon.stub(
        Twitter.prototype,
        'post',
        (url, content, contentType, callback) ->
          if url is '/favorites/create.json'
            callback
              user: { screen_name: 'bouzuya' }
              id_str: '489046087445929985'
          else
            originalPost url, content, contentType, callback
      )

    it 'send "https://twitter.com/bouzuya/status/489046087445929985"', (done) ->
      tweet = 'https://twitter.com/bouzuya/status/489046087445929985'
      sender = id: 'bouzuya', room: 'hitoridokusho'
      message = '@hubot fav ' + tweet
      @kakashi
        .receive sender, message
        .then =>
          expect(@kakashi.send.callCount).to.equal(1)
          expect(@kakashi.send.firstCall.args[1]).to.equal(tweet)
        .then (-> done()), done

  describe 'receive "@hubot fav https://twitter.com/... (error)"', ->
    beforeEach ->
      Twitter = require 'twitter'
      originalPost = Twitter.prototype.post
      @sinon.stub(
        Twitter.prototype,
        'post',
        (url, content, contentType, callback) ->
          if url is '/favorites/create.json'
            callback new Error('error message')
          else
            originalPost url, content, contentType, callback
      )

    it 'send "https://twitter.com/bouzuya/status/489046087445929985"', (done) ->
      tweet = 'https://twitter.com/bouzuya/status/489046087445929985'
      sender = id: 'bouzuya', room: 'hitoridokusho'
      message = '@hubot fav ' + tweet
      @kakashi
        .receive sender, message
        .then =>
          expect(@kakashi.send.callCount).to.equal(1)
          expect(@kakashi.send.firstCall.args[1]).to.equal('fav error')
        .then (-> done()), done
