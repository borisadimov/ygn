module.exports = class Events

  constructor: ->

    body = document.body

    window.addEventListener 'scroll', ->
      clearTimeout timer

      if !body.classList.contains('events-disableHover')
        body.classList.add 'events-disableHover'

      timer = setTimeout((->
        body.classList.remove 'events-disableHover'
      ), 500)

    $('.events_view .events_town').click ->
      className = $(this).attr('class').split(' ').slice(-1)[0]
      console.log className
      # if className is 'transition_process' then return
      $('body').addClass('events-scroll')
      $('html').addClass('events-scroll')
      $('.overlay').addClass('showed')
      $(".overlay .#{className}").addClass('showed')
      runNext 10, =>
        $(".overlay .#{className}").addClass('visible')


    $('.thirdSection .thirdSection-event').click ->
      className = $(this).attr('class').split(' ').slice(-1)[0]
      console.log className
      # if className is 'transition_process' then return
      $('body').addClass('events-fixed')
      $('html').addClass('events-fixed')
      $('.events_modalWrapper').addClass('showed')
      $(".events_modalWrapper .#{className}").addClass('showed')
      runNext 10, =>
        $(".events_modalWrapper .#{className}").addClass('visible')



    $('.events_modalInner .cross').click ->
      $('body').removeClass('events-fixed')
      $('html').removeClass('events-fixed')
      $('.events_modalWrapper').removeClass('showed')
      $('.events_modalWrapper .events_modalInner').removeClass('showed visible')


    $('.overlay .cross').click ->
      $('body').removeClass('events-scroll')
      $('html').removeClass('events-scroll')
      $('.overlay').removeClass('showed')
      $('.overlay .events_modal').removeClass('showed visible')
