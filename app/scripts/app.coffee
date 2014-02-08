parties = [
  {
    "id": 1,
    "name": "Kappa Sigma",
    "location": {
      "x": 123.5875,
      "y": 826.9827
    },
    "numPeople": 325,
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
    "currSongID": "gv5g5v"
  }
]






App = Ember.Application.create {}

App.Router.map ->
  this.resource 'parties'
  this.resource 'party', { path: 'party/:party_id' }

App.PartiesRoute = Ember.Route.extend
  model: ->
    parties

App.PartyRoute = Ember.Route.extend
  model: (params)->
    parties.findBy 'id', params.party_id

# Order and include as you please.
# require('scripts/routes/*')
# require('scripts/controllers/*')
# require('scripts/models/*')
# require('scripts/views/*')

# App.Store = DS.Store.extend {
# }

# App.ExampleRoute = Ember.Route.extend
#   renderTemplate: (controller, model)->

#     # Render the base template
#     this._super controller, model

#     # Render the template into the named outlet
#     this.render 'template', outlet: 'outletName'