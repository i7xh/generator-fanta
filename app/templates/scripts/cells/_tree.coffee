define (require, exports, module) ->

  require 'jstree'
  require 'jstree2css'

  _createTopicTree = (id, rootUrl, nodeUrl, searchId, nodeMenu) ->
    myTree = $(id).jstree
      ui:
        initially_select: ['#']

      core:
        animation: 0
        check_callback: true
        themes:
          theme: "bootstrap"
          dots: false
        data:
          url: (node) ->
            if node.id is '#' then rootUrl else nodeUrl
          data: (node) ->
            data =
              id: node.id
              text: node.text
              state:
                opened: true
                selected: node.state.selected
            return data

      types:
        "#":
          max_children: 10000
          max_depth: 10
          valid_children: ["root"]
        root:
          icon: "glyphicon glyphicon-map-marker"
          valid_children: ["default"]
        default:
          valid_children: ["default", "topic"]
        topic:
          icon: "glyphicon glyphicon-tag"
          "valid_children": ['default', 'topic']

      checkbox:
        three_state: false
        real_checkboxes: true
        keep_selected_style: false

      search:
        show_only_matches: true

      contextmenu: nodeMenu

      plugins: ["themes", "search", "types", "state", "checkbox", "contextmenu"]

    $(searchId).keyup ()->
      if to
        clearTimeout to
      to = setTimeout(
        ->
          v = $(searchId).val()
          $(id).jstree(true).search(v)
        , 250
      )
    return myTree

  exports =

    createTopicTree: _createTopicTree
