define (require, exports, module) ->

  require 'select2'
  require 'select2css'
  utils = require 'utils'
  puconst = require 'puconst'

  acp = (_width, _placeholder, _url, _initUrl)->
    width: _width
    multiple: true
    placeholder: _placeholder
    minimumInputLength: 1
    ajax:
      url: _url
      dataType: 'json'
      data: (term, page) ->
        q: term
        limit: 10
      results: (data, page) ->
        ret = results: []
        ret.results.push {text: item.name, id: item.id} for item in data
        return ret
    initSelection: (element, callback) ->
      ids = element.val()
      utils.jsonRequest _initUrl, ids: ids,
        (data) ->
          selections = []
          selections.push {id: elem.id, text: elem.name} for elem in data
          callback selections

  exports =
    createACP: (
      id,
      width,
      placeholder,
      url,
      initUrl
    ) ->
      $(id).select2 acp(width, placeholder, url, initUrl)
