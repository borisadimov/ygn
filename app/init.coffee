require 'scripts/utils'



isMenuOpened = false
isMenuOpening = false
toggleMenu = ->
  if isMenuOpening then return
  isMenuOpening = true
  if isMenuOpened
    $('.toggle_menu').removeClass 'open'
    $('.menu').removeClass 'showed'
    $('body').removeClass 'noscroll'
    runNext 400, =>
      $('.menu').removeClass 'opened'
      isMenuOpening = false
      isMenuOpened = false


  else
    $('.toggle_menu').addClass 'open'
    $('.menu').addClass 'opened'
    $('body').addClass 'noscroll'

    runNext 100, =>
      $('.menu').addClass 'showed'
      isMenuOpening = false
      isMenuOpened = true








ready ->



  runNext 100, ->
    $('.main_slide .logo, .main_slide .subtitle').addClass('appeared')


  $('.toggle_menu').click toggleMenu

  if $('body').hasClass('index')
    window.screens = new (require('scripts/screens'))
    screens.init()

  if $('body').hasClass('supporter')
    window.supporter = new (require('scripts/supporter'))


  if $('body').hasClass('challenge')
    window.challenge = new (require('scripts/challenge'))
    challenge.init()










