module.exports = class Supporter


  constructor: ->
    $('.supporter_view .support_type').click ->
      className = $(this).attr('class').split(' ').slice(-1)[0]

      $('.overlay').addClass('showed')
      $(".overlay .#{className}").addClass('showed')
      runNext 10, =>
        $(".overlay .#{className}").addClass('visible')


    $('.popup .close').click ->
      $('.overlay').removeClass('showed')
      $('.overlay .popup').removeClass('showed visible')




