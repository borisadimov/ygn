module.exports = class Directors


  screens = null
  active = null

  arrow = null
  prev_arrow = null

  directors = null
  links = null

  currentState = 0

  @scrollDisabled: false


  constructor: ->
    @move = _.throttle @_move, 1200

    @handleTouchMove = _.debounce @_handleTouchMove, 100

    @addTouchHandler()




  init: =>

    # $('.vide_wrapper').vide('videos/hero')

    container = document.querySelector('body')
    @createScrollListener(container, @onScroll)
    arrow = $('.next_arrow')
    prev_arrow = $('.prev_arrow')

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


    prev_arrow.click =>
      unless @scrollDisabled
        @scrollDisabled = true
        @move('prev')
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




  isTouchDevice = navigator.userAgent.match(/(iPhone|iPod|iPad|Android|playbook|silk|BlackBerry|BB10|Windows Phone|Tizen|Bada|webOS|IEMobile|Opera Mini)/)
  isTouch = (('ontouchstart' in window) || (navigator.msMaxTouchPoints > 0) || (navigator.maxTouchPoints))

  touchStartY = 0
  touchStartX = 0
  touchEndY = 0
  touchEndX = 0

  touchMenu: (event) =>
    e = event || window.event or e or e.originalEvent
    e.stopPropagation()

  touchMoveHandler: (event) =>
    e = event || window.event or e or e.originalEvent
    @preventDefault(e)
    if @isReallyTouch(e)

      @preventDefault(e)
      unless @scrollDisabled
        @handleTouchMove(e)


  _handleTouchMove: (e) =>
    touchEvents = @getEventsPage(e)
    touchEndY = touchEvents.y
    touchEndX = touchEvents.x
    if Math.abs(touchStartX - touchEndX) < Math.abs(touchStartY - touchEndY)
      if Math.abs(touchStartY - touchEndY) > $(window).height() / 100 * 5
        console.log('touchmove')
        if touchStartY > touchEndY
          @move('next')
        else if touchEndY > touchStartY
          @move('prev')



    return

  isReallyTouch: (e) =>
    typeof e.pointerType == 'undefined' or e.pointerType != 'mouse'

  touchStartHandler: (event) =>
    e = event || window.event or e or e.originalEvent
    if @isReallyTouch(e)
      touchEvents = @getEventsPage(e)
      touchStartY = touchEvents.y
      touchStartX = touchEvents.x
    return


  addTouchHandler: =>
    if isTouchDevice or isTouch
      wrapper = $('body')[0]
      menu_wrapper = $('.menu')[0]
      if document.addEventListener
        MSPointer = @getMSPointer()
        wrapper.removeEventListener 'touchstart', @touchStartHandler
        wrapper.removeEventListener MSPointer.down, @touchStartHandler
        wrapper.removeEventListener 'touchmove', @touchMoveHandler
        wrapper.removeEventListener MSPointer.move, @touchMoveHandler
        @addListenerMulti wrapper, 'touchstart ' + MSPointer.down, @touchStartHandler
        @addListenerMulti wrapper, 'touchmove ' + MSPointer.move, @touchMoveHandler
        @addListenerMulti menu_wrapper, 'touchmove ' + MSPointer.move, @touchMenu
    return

  getMSPointer: =>
    pointer = undefined
    if window.PointerEvent
      pointer =
        down: 'pointerdown'
        move: 'pointermove'
    else
      pointer =
        down: 'MSPointerDown'
        move: 'MSPointerMove'
    pointer

  addListenerMulti: (el, s, fn) =>
    evts = s.split(' ')
    i = 0
    iLen = evts.length
    while i < iLen
      if document.addEventListener
        el.addEventListener evts[i], fn, false
      else
        el.attachEvent evts[i], fn, false
        #IE 6/7/8
      i++
    return

  getEventsPage: (e) =>
    events = []
    events.y = if typeof e.pageY != 'undefined' and (e.pageY or e.pageX) then e.pageY else e.touches[0].pageY
    events.x = if typeof e.pageX != 'undefined' and (e.pageY or e.pageX) then e.pageX else e.touches[0].pageX
    if isTouch and @isReallyTouch(e)
      events.y = e.touches[0].pageY
      events.x = e.touches[0].pageX
    events


  preventDefault: (event) =>
    if event.preventDefault then event.preventDefault() else event.returnValue = false









