AppView = require('views/app_view')
Router = require('lib/router')
enUS = require('lib/en-us')

module.exports = ->
  t7e.load(enUS)

  languageManager = new zooniverse.LanguageManager({
    translations: {
      en: { label: "English", strings: enUS }
    }
  })

  languageManager.on('change-language', (e, code, languageStrings) ->
    t7e.load(languageStrings)
    t7e.refresh()
  )

  api = new zooniverse.Api({
    project: 'wise'
    host: 'http://0.0.0.0:3000'
  })

  ga = new zooniverse.GoogleAnalytics({account: 'UA-1224199-50'})

  topBar = new zooniverse.controllers.TopBar()
  topBar.el.appendTo(document.body)

  zooniverse.models.User.fetch()

  appView = new AppView()
  router = new Router(appView)

  Backbone.history.start()