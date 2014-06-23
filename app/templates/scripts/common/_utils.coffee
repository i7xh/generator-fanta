define (require, exports, module) ->
  puconst = require 'puconst'

  _showSlideMessage = (
    message,
    type='success',
    timeout=3000,
    callback= -> console.log 'default callback'
  ) ->
    $('div#top-alert-message').attr 'class', "alert bg-#{type}"
    $('div#top-alert-message strong').text message
    $('div#top-alert-message').slideDown 'fast'
    setTimeout ->
      $('div#top-alert-message').slideUp()
    , timeout

  exports =

    showSlideMessage: _showSlideMessage

    jsonRequest: (url, jsonData, callback, type='post', timeout=60*1000) ->
      $.ajax
        url: url
        type: type
        timeout: timeout
        dataType: "json"
        data: jsonData
        traditional: true
        success: (data) ->
          callback data

    submitRequest: (
      url,
      data,
      callback= (data) ->
        return
    ) ->
      $.post(url, data)
      .done (data) ->
        callback(data)
      .error (data) ->
        _showSlideMessage puconst.SUBMIT_ERROR, 'danger'

