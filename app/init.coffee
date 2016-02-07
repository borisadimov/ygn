TRANSITION_END = 'webkitTransitionEnd transitionend msTransitionEnd oTransitionEnd'

lethargy = new Lethargy()
scrollDisabled = false


runNext = (arg1, arg2) =>
  if typeof(arg1) is 'function'
    return setTimeout arg1, 0
  else
    if typeof(arg1) is 'number' and typeof(arg2) is 'function'
      return setTimeout arg2, arg1

  console.error('wrong params for runNext')



window.ready = (fn) ->
  if document.readyState != 'loading'
    do fn
  else
    document.addEventListener 'DOMContentLoaded', fn


createScrollListener = (elem, handler) ->
  if elem.addEventListener
    if 'onwheel' of document
      elem.addEventListener "wheel", handler
    else if 'onmousewheel' of document
      elem.addEventListener "mousewheel", handler
    else
      elem.addEventListener "MozMousePixelScroll", handler
  else
    elem.attachEvent "onmousewheel", handler



nextScreen = ->
  active = $('.screen.visible')
  next = active.next()
  if !next.hasClass('screen') then return
  next.addClass 'shown'
  runNext 10, ->
    active.addClass 'scrolled'
    runNext 800, ->
      active.removeClass 'visible'
      active.removeClass 'shown'

    next.addClass 'visible'





prevScreen = ->
  active = $('.screen.visible')
  next = active.prev()
  if !next.hasClass('screen') then return
  next.addClass 'shown'

  runNext 10, ->
    active.removeClass 'visible'
    next.removeClass 'scrolled'
    next.addClass 'visible'
    runNext 800, ->
      active.removeClass 'shown'















ready ->
  elem = document.querySelector('body')

  info = 0

  onWheel = (e) ->
    e = e || window.event
    scrollInfo = lethargy.check(e)
    if scrollInfo != false
      unless scrollDisabled
        scrollDisabled = true
        if scrollInfo is 1
          prevScreen()
        else
          nextScreen()

        setTimeout ->
          scrollDisabled = false
        , 1000


    if e.preventDefault
      e.preventDefault()
    else
      (e.returnValue = false)
    return false

  createScrollListener(elem, onWheel)





