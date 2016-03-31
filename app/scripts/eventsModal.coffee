module.exports = class Events

  constructor: ->

    body = document.body

    window.addEventListener 'scroll', ->
      clearTimeout timer

      if !body.classList.contains('events-modalDisableHover')
        body.classList.add 'events-modalDisableHover'

      timer = setTimeout((->
        body.classList.remove 'events-modalDisableHover'
      ), 500)

    $('.thirdSection .thirdSection-event').click ->
      className = $(this).attr('class').split(' ').slice(-1)[0]
      console.log className
      # if className is 'transition_process' then return
      $('body').addClass('events-modalFixed')
      $('html').addClass('events-modalFixed')
      $('.modal-container').addClass('showed')
      $(".modal-container .#{className}").addClass('showed')
      runNext 10, =>
        $(".modal-container .#{className}").addClass('visible')



    $('.modal .cross').click ->
      $('body').removeClass('events-modalFixed')
      $('html').removeClass('events-modalFixed')
      $('.modal-container').removeClass('showed')
      $('.modal-container .modal').removeClass('showed visible')
