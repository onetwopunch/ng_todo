$ ->
  new Dispatcher()

class Dispatcher
  constructor: ->
    page = $('body').data('page')
    if page.split(':')[0] == 'user'
      new Login()
