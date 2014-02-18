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
    applicationController = this.controllerFor 'application'
    applicationController.set 'title', 'THE Q'
    applicationController.set 'back', no
    applicationController.set 'leave', no
    applicationController.set 'newParty', yes
    applicationController.set 'newSong', no

  model: ->
    Ember.$.getJSON('/allParties').then (data)->
      App.parties = data
      console.log data
      return data

App.NewPartyRoute = Ember.Route.extend
  beforeModel: ->
    applicationController = this.controllerFor 'application'
    applicationController.set 'title', 'New Party'
    applicationController.set 'back', yes
    applicationController.set 'leave', no
    applicationController.set 'newParty', no
    applicationController.set 'newSong', no

App.PartyRoute = Ember.Route.extend
  beforeModel: ->
    applicationController = this.controllerFor 'application'
    applicationController.set 'back', no
    applicationController.set 'leave', no
    applicationController.set 'newParty', no
    applicationController.set 'newSong', no
    if applicationController.get('party')?
      applicationController.set 'back', no
      applicationController.set 'leave', yes
    else
      applicationController.set 'back', yes
      applicationController.set 'leave', no

  model: (params)->
    App.parties.findBy 'id', parseInt params['party_id']

  afterModel: (model)->
    applicationController = this.controllerFor 'application'
    applicationController.set 'title', model.name

App.QueueRoute = Ember.Route.extend
  beforeModel: ->
    applicationController = this.controllerFor 'application'
    applicationController.set 'title', 'QUEUE'
    applicationController.set 'back', no
    applicationController.set 'leave', yes
    applicationController.set 'newParty', no
    applicationController.set 'newSong', yes

  model: ->
    Ember.$.getJSON('/allSongs').then (data)->
      App.songs = data
      return data

App.NewSongRoute = Ember.Route.extend
  beforeModel: ->
    applicationController = this.controllerFor 'application'
    applicationController.set 'title', 'New Song'
    applicationController.set 'back', yes
    applicationController.set 'leave', no
    applicationController.set 'newParty', no
    applicationController.set 'newSong', no

App.NowPlayingRoute = Ember.Route.extend
  beforeModel: ->
    applicationController = this.controllerFor 'application'
    applicationController.set 'title', 'Now Playing'
    applicationController.set 'back', no
    applicationController.set 'leave', yes
    applicationController.set 'newParty', no
    applicationController.set 'newSong', yes





App.ApplicationController = Ember.Controller.extend
  title: 'THE Q'

  actions:
    back: ->
      window.history.back()

    leave: ->
      this.transitionToRoute '/'
      this.set 'party', undefined

App.PartyController = Ember.Controller.extend
  needs: ['application']

  currentParty: (->
    current = this.get 'controllers.application.party'
    if current?
      this.set 'controllers.application.back', no
      this.set 'controllers.application.leave', yes
      return yes
    else
      this.set 'controllers.application.back', yes
      this.set 'controllers.application.leave', no
      return no
  ).property 'controllers.application.party'

  actions:
    joinParty: (party)->
      this.set 'controllers.application.party', party
      this.transitionToRoute '/queue'

    leaveParty: ->
      this.transitionToRoute '/'
      this.set 'controllers.application.party', undefined

App.NewPartyController = Ember.Controller.extend
  needs: ['application']

  creating: false
  error: false

  actions:
    create: ->
      this.set 'error', false
      this.set 'creating', true

      $.post('/addParty',
        name: this.get 'name'
      ).then (res)=>
        this.set 'creating', false
        this.set 'controllers.application.party', res['party']
        this.transitionToRoute 'queue'
      , =>
        this.set 'creating', false
        this.set 'error', true

App.NewSongController = Ember.Controller.extend
  needs: ['application']

  adding: false
  error: false

  actions:
    create: ->
      this.set 'error', false
      this.set 'adding', true

      $.post('/addSong',
        name: this.get 'name'
        artist: this.get 'artist'
        album: this.get 'album'
      ).then =>
        this.set 'adding', false
        this.transitionToRoute 'queue'
      , =>
        this.set 'adding', false
        this.set 'error', true

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