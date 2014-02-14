App = Ember.Application.create {}






App.Router.map ->
  this.resource 'parties', { path: '/'}
  this.resource 'party', { path: 'party/:party_id' }
  this.resource 'new-party'
  this.resource 'queue'
  this.resource 'new-song'
  this.resource 'now-playing'





App.PartiesRoute = Ember.Route.extend
  model: ->
    parties

  setupController: (controller, model)->
    controller.set 'controllers.application.title', 'THE Q'
    controller.set 'controllers.application.back', no
    controller.set 'controllers.application.leave', no
    controller.set 'controllers.application.newParty', yes
    controller.set 'controllers.application.newSong', no
    controller.set 'content', model

App.NewPartyRoute = Ember.Route.extend
  setupController: (controller)->
    controller.set 'controllers.application.title', 'New Party'
    controller.set 'controllers.application.back', yes
    controller.set 'controllers.application.leave', no
    controller.set 'controllers.application.newParty', no
    controller.set 'controllers.application.newSong', no

App.PartyRoute = Ember.Route.extend
  model: (params)->
    parties.findBy 'id', parseInt params['party_id']

  setupController: (controller, model)->
    controller.set 'controllers.application.title', model.name
    controller.set 'controllers.application.newParty', no
    controller.set 'controllers.application.newSong', no
    controller.set 'content', model
    if controller.get('controllers.application.party')?
      controller.set 'controllers.application.back', no
      controller.set 'controllers.application.leave', yes
    else
      controller.set 'controllers.application.back', yes
      controller.set 'controllers.application.leave', no

App.QueueRoute = Ember.Route.extend
  model: ->
    songs

  setupController: (controller, model)->
    controller.set 'controllers.application.title', 'QUEUE'
    controller.set 'controllers.application.back', no
    controller.set 'controllers.application.leave', yes
    controller.set 'controllers.application.newParty', no
    controller.set 'controllers.application.newSong', yes
    controller.set 'content', model

App.NewSongRoute = Ember.Route.extend
  setupController: (controller)->
    controller.set 'controllers.application.title', 'New Song'
    controller.set 'controllers.application.back', yes
    controller.set 'controllers.application.leave', no
    controller.set 'controllers.application.newParty', no
    controller.set 'controllers.application.newSong', no

App.NowPlayingRoute = Ember.Route.extend
  setupController: (controller)->
    controller.set 'controllers.application.title', 'Now Playing'
    controller.set 'controllers.application.back', no
    controller.set 'controllers.application.leave', yes
    controller.set 'controllers.application.newParty', no
    controller.set 'controllers.application.newSong', yes





App.ApplicationController = Ember.Controller.extend
  title: 'THE Q'

  actions:
    back: ->
      window.history.back()

    leave: ->
      this.set 'party', undefined
      this.transitionToRoute '/'

App.PartiesController = Ember.Controller.extend
  needs: ['application']

App.PartyController = Ember.Controller.extend
  needs: ['application']

  currentParty: (->
    current = this.get('controllers.application.party')
    if current?
      this.set 'controllers.application.back', no
      this.set 'controllers.application.leave', yes
      return yes
    else
      this.set 'controllers.application.back', yes
      this.set 'controllers.application.leave', no
      return no
  ).property('controllers.application.party')

  actions:
    joinParty: (party)->
      this.set 'controllers.application.party', party
      this.transitionToRoute '/queue'

App.QueueController = Ember.Controller.extend
  needs: ['application']

App.NewPartyController = Ember.Controller.extend
  needs: ['application']

App.NewSongController = Ember.Controller.extend
  needs: ['application']

App.NowPlayingController = Ember.Controller.extend
  needs: ['application']

App.TabBarController = Ember.Controller.extend
  needs: ['application']

  currentPartyId: (->
    return this.get('controllers.application.party').id
  ).property('controllers.application.party')





Handlebars.registerHelper 'partyIndex', (options)->
  index = options.data.view.contentIndex
  return 'party' + index






parties = [
    {
      "id": 1,
      "name": "Kappa Sig",
      "location": {
        "x": 123.5875,
        "y": 826.9827
      },
      "numPeople": 325,
      "numSongs": 56,
      "currSongID": "kjh4h4"
    },
    {
      "id": 2,
      "name": "SAE",
      "location": {
        "x": 124.5875,
        "y": 825.9827
      },
      "numPeople": 13,
      "numSongs": 4,
      "currSongID": "kh6k6g"
    },
    {
      "id": 3,
      "name": "SAE",
      "location": {
        "x": 124.5875,
        "y": 825.9827
      },
      "numPeople": 13,
      "numSongs": 4,
      "currSongID": "kh6k6g"
    },
    {
      "id": 4,
      "name": "SAE",
      "location": {
        "x": 124.5875,
        "y": 825.9827
      },
      "numPeople": 13,
      "numSongs": 4,
      "currSongID": "kh6k6g"
    },
    {
      "id": 5,
      "name": "SAE",
      "location": {
        "x": 124.5875,
        "y": 825.9827
      },
      "numPeople": 13,
      "numSongs": 4,
      "currSongID": "kh6k6g"
    },
    {
      "id": 6,
      "name": "SAE",
      "location": {
        "x": 124.5875,
        "y": 825.9827
      },
      "numPeople": 13,
      "numSongs": 4,
      "currSongID": "kh6k6g"
    },
    {
      "id": 7,
      "name": "SAE",
      "location": {
        "x": 124.5875,
        "y": 825.9827
      },
      "numPeople": 13,
      "numSongs": 4,
      "currSongID": "kh6k6g"
    },
    {
      "id": 8,
      "name": "SAE",
      "location": {
        "x": 124.5875,
        "y": 825.9827
      },
      "numPeople": 13,
      "numSongs": 4,
      "currSongID": "kh6k6g"
    },
    {
      "id": 9,
      "name": "Theta Delt",
      "location": {
        "x": 121.5875,
        "y": 824.9827
      },
      "numPeople": 3,
      "numSongs": 123,
      "currSongID": "gv5g5v"
    }
  ]




songs = [
    {
      "id": 1,
      "name": "Timber ft. Ke$ha",
      "artist": 'Pitbull',
      "album": 'Meltdown',
      "score": 55,
      "img": "http://upload.wikimedia.org/wikipedia/en/8/8d/AnimalKesha.jpg"
    },
    {
      "id": 2,
      "name": "Timber ft. Ke$ha",
      "artist": 'Pitbull',
      "album": 'Meltdown',
      "score": 55,
      "img": "http://upload.wikimedia.org/wikipedia/en/8/8d/AnimalKesha.jpg"
    },
    {
      "id": 3,
      "name": "Timber ft. Ke$ha",
      "artist": 'Pitbull',
      "album": 'Meltdown',
      "score": 55,
      "img": "http://upload.wikimedia.org/wikipedia/en/8/8d/AnimalKesha.jpg"
    },
    {
      "id": 4,
      "name": "Timber ft. Ke$ha",
      "artist": 'Pitbull',
      "album": 'Meltdown',
      "score": 55,
      "img": "http://upload.wikimedia.org/wikipedia/en/8/8d/AnimalKesha.jpg"
    },
    {
      "id": 5,
      "name": "Timber ft. Ke$ha",
      "artist": 'Pitbull',
      "album": 'Meltdown',
      "score": 55,
      "img": "http://upload.wikimedia.org/wikipedia/en/8/8d/AnimalKesha.jpg"
    },
    {
      "id": 6,
      "name": "Timber ft. Ke$ha",
      "artist": 'Pitbull',
      "album": 'Meltdown',
      "score": 55,
      "img": "http://upload.wikimedia.org/wikipedia/en/8/8d/AnimalKesha.jpg"
    },
    {
      "id": 7,
      "name": "Timber ft. Ke$ha",
      "artist": 'Pitbull',
      "album": 'Meltdown',
      "score": 55,
      "img": "http://upload.wikimedia.org/wikipedia/en/8/8d/AnimalKesha.jpg"
    },
    {
      "id": 8,
      "name": "Timber ft. Ke$ha",
      "artist": 'Pitbull',
      "album": 'Meltdown',
      "score": 55,
      "img": "http://upload.wikimedia.org/wikipedia/en/8/8d/AnimalKesha.jpg"
    },
    {
      "id": 9,
      "name": "Timber ft. Ke$ha",
      "artist": 'Pitbull',
      "album": 'Meltdown',
      "score": 55,
      "img": "http://upload.wikimedia.org/wikipedia/en/8/8d/AnimalKesha.jpg"
    }
  ]