App = Ember.Application.create {}

App.Router.map ->
  this.resource 'parties', { path: '/'}
  this.resource 'party', { path: 'party/:party_id' }
  this.resource 'new'

App.PartyRoute = Ember.Route.extend
  model: (params)->
    parties.findBy 'id', params.party_id

App.PartiesRoute = Ember.Route.extend
  model: ->
    parties

App.ApplicationController = Ember.Controller.extend
  back: ->
    window.history.back()

Handlebars.registerHelper 'partyIndex', (options)->
  index = options.data.view.contentIndex
  return 'party' + index








parties = [
  {
    "id": 1,
    "name": "Kappa Sigma",
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
    "name": "Sigma Alpha Epsilon",
    "location": {
      "x": 124.5875,
      "y": 825.9827
    },
    "numPeople": 13,
    "numSongs": 4,
    "currSongID": "kh6k6g"
  },
  {
    "id": 2,
    "name": "Sigma Alpha Epsilon",
    "location": {
      "x": 124.5875,
      "y": 825.9827
    },
    "numPeople": 13,
    "numSongs": 4,
    "currSongID": "kh6k6g"
  },
  {
    "id": 2,
    "name": "Sigma Alpha Epsilon",
    "location": {
      "x": 124.5875,
      "y": 825.9827
    },
    "numPeople": 13,
    "numSongs": 4,
    "currSongID": "kh6k6g"
  },
  {
    "id": 2,
    "name": "Sigma Alpha Epsilon",
    "location": {
      "x": 124.5875,
      "y": 825.9827
    },
    "numPeople": 13,
    "numSongs": 4,
    "currSongID": "kh6k6g"
  },
  {
    "id": 2,
    "name": "Sigma Alpha Epsilon",
    "location": {
      "x": 124.5875,
      "y": 825.9827
    },
    "numPeople": 13,
    "numSongs": 4,
    "currSongID": "kh6k6g"
  },
  {
    "id": 2,
    "name": "Sigma Alpha Epsilon",
    "location": {
      "x": 124.5875,
      "y": 825.9827
    },
    "numPeople": 13,
    "numSongs": 4,
    "currSongID": "kh6k6g"
  },
  {
    "id": 2,
    "name": "Sigma Alpha Epsilon",
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
    "name": "Theta Delta Chi",
    "location": {
      "x": 121.5875,
      "y": 824.9827
    },
    "numPeople": 3,
    "numSongs": 123,
    "currSongID": "gv5g5v"
  }
]