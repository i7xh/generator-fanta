define (require, exports, module) ->

  require 'listjs'

  _bindSortEvent = (sortContainer, selection) ->
    $(sortContainer).on 'click', selection, (evt) ->
      spanSort = $(evt.target).closest(selection).find 'span'
      if $(evt.target).closest(selection).hasClass 'asc'
        spanSort.removeClass('glyphicon-chevron-down').addClass 'glyphicon-chevron-up'
      else
        spanSort.removeClass('glyphicon-chevron-up').addClass 'glyphicon-chevron-down'

  exports =

    createList: (id, fields)->
      listOptions =
        valueNames: fields
      new List id, listOptions

    bindSortEvent: _bindSortEvent
