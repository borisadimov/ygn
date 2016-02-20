module.exports = class Directors


  screens = null
  active = null

  arrow = null

  directors = null
  links = null

  currentState = 0

  @scrollDisabled: false


  constructor: ->
    @move = _.throttle @_move, 1200



  init: =>

    # $('.vide_wrapper').vide('videos/hero')

    container = document.querySelector('body')
    @createScrollListener(container, @onScroll)
    arrow = $('.next_arrow')

    directors = $('.directors .director')
    links = $('.directors .directors_view .links a')

    @setHandlers()

    @setState(0)


  createScrollListener: (elem, handler) =>
    if elem.addEventListener
      if 'onScroll' of document
        elem.addEventListener "wheel", handler
      else if 'onmousewheel' of document
        elem.addEventListener "mousewheel", handler
      else
        elem.addEventListener "MozMousePixelScroll", handler
    else
      elem.attachEvent "onmousewheel", handler



  onScroll: (e) =>
    if $('body').hasClass('noscroll') then return
    e = e || window.event
    scrollInfo = lethargy.check(e)
    if scrollInfo != false
      unless @scrollDisabled
        @scrollDisabled = true
        @move(scrollInfo)
        runNext 1200, =>
          @scrollDisabled = false

    if e.preventDefault
      e.preventDefault()
    else
      (e.returnValue = false)
    return false


  _move: (direction) =>
    if direction is 'next' || direction is -1
      @moveNext()
    else if direction is 'prev' || direction is 1
      @movePrev()
    else
      return false


  moveNext: =>
    if currentState < links.length - 1
      currentState++
      @setState(currentState)
    else
      currentState = 0
      @setState(currentState)



  movePrev: =>
    console.log('movePrev', currentState)
    if currentState > 0
      currentState--
      @setState(currentState)
    else
      currentState = links.length - 1
      @setState(currentState)


  setState: (index) =>
    directors.removeClass('showed')
    links.removeClass('active')
    runNext 310, =>
      directors.eq(index).addClass('showed')
      link = links.eq(index)
      console.log link

      link.addClass('active')

  setHandlers: =>
    arrow.click =>
      unless @scrollDisabled
        @scrollDisabled = true
        @move('next')
        runNext 1200, =>
          @scrollDisabled = false
    that = this
    links.click (event) ->
      event.preventDefault()
      index = $(this).index()
      currentState = index
      that.setState(index)
      event.returnValue = false
      return false










