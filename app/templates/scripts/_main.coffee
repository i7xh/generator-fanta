define (require, exports, module) ->

  exports =
    load: ->
      console.log "hello, <%= _.slugify(appname) %>"
