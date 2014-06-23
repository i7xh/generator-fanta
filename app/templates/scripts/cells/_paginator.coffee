define (require, exports, module) ->

  require 'simplepaginator'
  require 'purl'
  utils = require 'utils'

  exports =
    create: (selector) ->
      param = $.url(location.href).param()
      param.page = if param.page then param.page else 1
      req = action: 'get_paging_info'
      utils.jsonRequest location.href, req, (data) ->
        if data
          $(selector).pagination
            items: data.total
            itemsOnPage: data.per_page_num
            hrefTextPrefix: '?page='
            currentPage: param.page
