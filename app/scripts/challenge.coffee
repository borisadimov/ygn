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
    else
      toggleMenu.removeClass('reversed')
      donateLink.removeClass('reversed')


  setHandlers: =>
    arrow.click =>
      unless @scrollDisabled
        @scrollDisabled = true
        @move('next')
        runNext 1200, =>
          @scrollDisabled = false

    point_issue.click =>
      @setState(1)
      @scrollDisabled = true
      runNext 1200, =>
        @scrollDisabled = false
    point_opportunity.click =>
      @setState(2)
      @scrollDisabled = true
      runNext 1200, =>
        @scrollDisabled = false
    point_solution.click =>
      @setState(3)
      @scrollDisabled = true
      runNext 1200, =>
        @scrollDisabled = false









