module.exports = class Supporter


  constructor: ->
    $('.supporter_view .support_type').click ->
      className = $(this).attr('class').split(' ').slice(-1)[0]
      console.log className
      # if className is 'transition_process' then return

      $('.overlay').addClass('showed')
      $(".overlay .#{className}").addClass('showed')
      runNext 10, =>
        $(".overlay .#{className}").addClass('visible')


    $('.popup .close').click ->
      $('.overlay').removeClass('showed')
      $('.overlay .popup').removeClass('showed visible')




