module.exports = class Challenge


  screens = null
  active = null

  arrow = null


  donateLink = null
  toggleMenu = null
  badge = null


  challenge_view = null

  points = null

  point_issue = null
  point_opportunity = null
  point_solution = null



  states = ['', 'state-1', 'state-2', 'state-3', 'state-4']

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

    donateLink = $('.donate_link')
    toggleMenu = $('.toggle_menu')
    badge = $('.badge')

    toggleMenu.addClass('reversed')
    donateLink.addClass('reversed')

    challenge_view = $('.challenge_view')

    points = $('.challenge_view .point')

    point_issue = $('.challenge_view .point.issue')
    point_opportunity = $('.challenge_view .point.opportunity')
    point_solution = $('.challenge_view .point.solution')
    console.log $(window).width()
    if $(window).width() < 767

      states[0] = 'state-0'
      states.unshift('')
      console.log states

    @setHandlers()


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
    if currentState < states.length - 1
      currentState++
      @setState(currentState)


  movePrev: =>
    console.log('movePrev', currentState)
    if currentState > 0
      currentState--
      @setState(currentState)



  setState: (index) =>
    challenge_view.removeClass(states.join(' '))
    challenge_view.addClass(states[index])

    if index is 0
      toggleMenu.addClass('reversed')
      donateLink.addClass('reversed')
      $('.content .social_icons').addClass('reversed')
    else
      toggleMenu.removeClass('reversed')
      donateLink.removeClass('reversed')
      $('.content .social_icons').removeClass('reversed')


  setHandlers: =>
    arrow.click =>
      unless @scrollDisabled
        @scrollDisabled = true
        @move('next')
        runNext 1200, =>
          @scrollDisabled = false

    point_issue.click =>
      @setState(1)
      currentState = 1
      @scrollDisabled = true
      runNext 1200, =>
        @scrollDisabled = false
    point_opportunity.click =>
      @setState(2)
      currentState = 2
      @scrollDisabled = true
      runNext 1200, =>
        @scrollDisabled = false
    point_solution.click =>
      @setState(3)
      currentState = 3
      @scrollDisabled = true
      runNext 1200, =>
        @scrollDisabled = false


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










