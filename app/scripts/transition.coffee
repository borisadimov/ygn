module.exports = class Transition


  screens = null
  active = null

  arrow = null

  right_arrow = null
  left_arrow = null


  donateLink = null
  toggleMenu = null
  badge = null


  transition_view = null




  states = ['', 'state-1']

  currentState = 0

  phase = 0

  @scrollDisabled: false


  constructor: ->
    @move = _.throttle @_move, 1200



  init: =>

    # $('.vide_wrapper').vide('videos/hero')

    container = document.querySelector('body')
    @createScrollListener(container, @onScroll)
    arrow = $('.next_arrow')

    right_arrow = $('.right_arrow .arrow')
    left_arrow = $('.left_arrow .arrow')

    donateLink = $('.donate_link')
    toggleMenu = $('.toggle_menu')
    badge = $('.badge')

    toggleMenu.addClass('reversed')
    donateLink.addClass('reversed')

    transition_view = $('.transition_view')


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
        runNext 600, =>
          @scrollDisabled = false

    if e.preventDefault
      e.preventDefault()
    else
      (e.returnValue = false)
    return false


  _move: (direction) =>
    if direction is 'next' || direction is -1
      @moveNext()
    else
      return false


  moveNext: =>
    if currentState < states.length - 1
      currentState++
      @setState(currentState)

  setPhase: (index) =>
    unless @scrollDisabled
      if currentState is 0
        transition_view.removeClass(states.join(' '))
        transition_view.addClass(states[1])

      @scrollDisabled = true
      $('.phases .phase').removeClass('active')
      $('.phase_content').hide()
      $(".phases .phase_#{index}").addClass('active')
      $(".phase_content.phase_#{index}").fadeIn('300')
      phase = index
      runNext 400, =>
        @scrollDisabled = false




  setState: (index) =>
    transition_view.removeClass(states.join(' '))
    transition_view.addClass(states[index])
    if phase is 0
      $('.phases .phase_1').addClass('active')
      $('.phase_content.phase_1').fadeIn('300')
      phase = 1


  setHandlers: =>
    arrow.click =>
      unless @scrollDisabled
        @scrollDisabled = true
        @move('next')
        runNext 600, =>
          @scrollDisabled = false

    right_arrow.click =>
      if phase < 4
        phase++
        @setPhase(phase)

    left_arrow.click =>
      if phase > 1
        phase--
        @setPhase(phase)
        $('.transition').scrollTop(0)

    that = @
    $('.phase').click ->
      return false if $(this).hasClass('active')

      index = $(this).data('index')
      that.setPhase(index)





