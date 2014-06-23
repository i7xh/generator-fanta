seajs.config

  alias:
    #common path
    utils: 'common_path/utils.js'
    puconst: 'common_path/const.js'

    #cell path <% if (includeSmartTree) { %>
    ztree: 'cell_path/tree.js' <% } %> <% if (includeAutoComplete) { %>
    acp: 'cell_path/acp.js' <% } %> <% if (includeSmartList) { %>
    zlist: 'cell_path/zlist.js' <% } %> <% if (includeSmartPagination) { %>
    paginator2: 'cell_path/paginator2.js' <% } %>

    #bower path <% if (includeAutoComplete) { %>
    select2: 'bower_path/select2/select2.min.js' <% } %> <% if (includeSmartTree) { %>
    jstree: 'bower_path/jstree/dist/jstree.min.js' <% } %> <% if (includeSmartList) { %>
    listjs: 'bower_path/list.js/dist/list.min.js' <% } %> <% if (includeSmartUrl) { %>
    purl: 'bower_path/purl/purl.js' <% } %> <% if (includeSmartPagination) { %>
    simplepaginator: 'bower_path/jquery.simplePagination/jquery.simplePagination.js' <% } %>

    #css <% if (includeAutoComplete) { %>
    select2css: 'bower_path/select2/select2.css' <% } %> <% if (includeSmartTree) { %>
    jstree2css: 'bower_path/jstree/dist/themes/default/style.min.css' <% } %> <% if (includeSmartPagination) { %>
    simplepaginator2css: 'bower_path/jquery.simplePagination/simplePagination.css' <% } %>


  paths:
    root_path: '<%= root_path %>/scripts'
    common_path: '<%= root_path %>/scripts/common'
    cell_path: '<%= root_path %>/scripts/common'
    bower_path: '<%= root_path %>/scripts/bower_components'
