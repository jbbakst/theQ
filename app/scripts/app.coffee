App = window.App = Ember.Application.create
  rootElement: $('#app')
  LOG_TRANSITIONS: true

# Order and include as you please.
# require('scripts/routes/*')
# require('scripts/controllers/*')
# require('scripts/models/*')
# require('scripts/views/*')

# App.Router.map ->
  # this.route 'login'

# App.Store = DS.Store.extend {
# }

# App.ExampleRoute = Ember.Route.extend
#   renderTemplate: (controller, model)->

#     # Render the base template
#     this._super controller, model

#     # Render the template into the named outlet
#     this.render 'template', outlet: 'outletName'