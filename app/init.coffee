TRANSITION_END = 'webkitTransitionEnd transitionend msTransitionEnd oTransitionEnd'

lethargy = new Lethargy()
scrollDisabled = false


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
  setTimeout ->
    active.addClass 'scrolled'
      .on TRANSITION_END, ->
        $(this).off TRANSITION_END
        $(this).removeClass 'visible'
        $(this).removeClass 'shown'


      next.addClass 'visible'
  , 2




prevScreen = ->
  active = $('.screen.visible')
  next = active.prev()
  if !next.hasClass('screen') then return

  next.addClass 'shown'

  setTimeout ->
    active.removeClass 'visible'
      .on TRANSITION_END, ->
        $(this).off TRANSITION_END
        $(this).removeClass 'shown'


      next.addClass 'visible'

    setTimeout ->
      next.removeClass 'scrolled'
  , 2












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





