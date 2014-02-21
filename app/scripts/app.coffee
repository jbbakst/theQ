App = Ember.Application.create {}

App.Router.map ->
  this.resource 'parties', { path: '/'}
  this.resource 'party', { path: 'party/:party_id' }
  this.resource 'new-party'
  this.resource 'queue'
  this.resource 'new-song'
  this.resource 'now-playing'





App.PartiesRoute = Ember.Route.extend
  beforeModel: ->
    this.controllerFor('application').setProperties
      title: 'THE Q'
      back: no
      leave: no
      newParty: yes
      newSong: no

  model: ->
    Ember.$.getJSON('/allParties')

App.NewPartyRoute = Ember.Route.extend
  beforeModel: ->
    this.controllerFor('application').setProperties
    title: 'New Party'
    back: yes
    leave: no
    newParty: no
    newSong: no

App.PartyRoute = Ember.Route.extend
  beforeModel: ->
    applicationController = this.controllerFor 'application'
    properties =
      newParty: no
      newSong: no
    if applicationController.get('party')?
      properties.back = no
      properties.leave = yes
    else
      properties.back = yes
      properties.leave = no
    applicationController.setProperties properties

  model: (params)->
    Ember.$.getJSON('/allParties').then (parties)->
      parties.findBy 'id', parseInt params['party_id']

  afterModel: (model)->
    this.controllerFor('application').set 'title', model.name

App.QueueRoute = Ember.Route.extend
  beforeModel: ->
    this.controllerFor('application').setProperties
      title: 'QUEUE'
      back: no
      leave: yes
      newParty: no
      newSong: yes

  model: ->
    Ember.$.getJSON('/allSongs').then (data)->
      App.songs = data
      return data

App.NewSongRoute = Ember.Route.extend
  beforeModel: ->
    this.controllerFor('application').setProperties
      title: 'New Song'
      back: yes
      leave: no
      newParty: no
      newSong: no

App.NowPlayingRoute = Ember.Route.extend
  beforeModel: ->
    this.controllerFor('application').setProperties
      title: 'Now Playing'
      back: no
      leave: yes
      newParty: no
      newSong: yes





App.ApplicationController = Ember.Controller.extend
  actions:
    back: ->
      window.history.back()

    leave: ->
      this.transitionToRoute '/'
      this.set 'party', undefined

App.PartyController = Ember.Controller.extend
  needs: ['application']

  currentParty: (->
    return this.get 'controllers.application.party'
  ).property 'controllers.application.party'

  actions:
    joinParty: (party)->
      this.transitionToRoute '/queue'
      this.set 'controllers.application.party', party

    leaveParty: ->
      this.set 'controllers.application.party', undefined
      this.transitionToRoute '/'

App.QueueController = Ember.ArrayController.extend
  actions:
    upvote: (song)->
      console.log song
      $.post('/upvote',
        id: song.id
      ).then (res)=>
        console.log res
        this.set 'model', res
      , (err)->
        console.log err


App.NewPartyController = Ember.Controller.extend
  needs: ['application']

  creating: false
  error: false

  actions:
    create: ->
      this.setProperties
        error: false
        creating: true

      $.post('/addParty',
        name: this.get 'name'
      ).then (res)=>
        this.set 'creating', false
        this.set 'controllers.application.party', res
        this.transitionToRoute 'queue'
      , =>
        this.setProperties
          creating: false
          error: true

App.NewSongController = Ember.Controller.extend
  needs: ['application']

  adding: false
  error: false

  actions:
    create: ->
      this.setProperties
        error: false
        adding: true

      $.post('/addSong',
        name: this.get 'name'
        artist: this.get 'artist'
        album: this.get 'album'
      ).then =>
        this.set 'adding', false
        this.transitionToRoute 'queue'
      , =>
        this.setProperties
          adding: false
          error: true

App.TabBarController = Ember.Controller.extend
  needs: ['application']

  currentPartyId: (->
    currentParty = this.get 'controllers.application.party'
    if currentParty?
      return currentParty.id
    else
      return -1
  ).property 'controllers.application.party'





Handlebars.registerHelper 'partyIndex', (options)->
  index = options.data.view.contentIndex
  return 'party' + index