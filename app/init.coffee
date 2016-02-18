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

  if window.location.hostname.indexOf('github') > -1
    $('head').prepend('<base href="http://flywithmemsl.github.io/ygn/" />')

  if window.location.hostname.indexOf('citytocoast') > -1
    $('head').prepend('<base href="http://citytocoast.com/ygn/" />')

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



  if $('body').hasClass('transition')

    window.transition = new (require('scripts/transition'))
    transition.init()




  if $('body').hasClass('contact') || $('body').hasClass('directors') || $('body').hasClass('blog') || $('body').hasClass('sponsors') || $('body').hasClass('host')
    $('.donate_link').addClass('reversed')
    $('.toggle_menu').addClass('reversed')


  if $('body').hasClass('press') || $('body').hasClass('blog')
    $('.badge').addClass('reversed')
