'use strict'

util = require 'util'
path = require 'path'
yeoman = require 'yeoman-generator'
yosay = require 'yosay'
chalk = require 'chalk'


class FantaGenerator extends yeoman.generators.Base
  constructor: ->
    yeoman.generators.Base.apply @, arguments
    @sourceRoot path.join(__dirname, 'templates')
    @pkg = require '../package.json';
    @on 'end', ->
      if not @options['skip-install']
        @installDependencies()

  askFor: ->
    done = @async()
    @log yosay 'Welcome to the marvelous Fanta generator!'
    prompts = [
      {
        name: 'appname'
        message: 'Set Your App Name(default: fantaApp)'
        default : if @appname then @appname else 'fantaApp'
      }
      {
        name: 'description'
        message: 'How would you like to describe this extension?'
        default: 'My Fanta App'
      }
      {
        type: 'list'
        name: 'selectStyle'
        message: 'Set Your Style below?'
        choices: [
          'Less'
          'Sass'
        ]
      }
      {
        name: 'root_path'
        message: 'Set Your App Static Path(default: "/static")'
        default: if @root_path then @root_path else "/static"
      }
      {
        type: 'checkbox'
        name: 'uifeatures'
        message: 'What more would you like?'
        choices: [
          {
            name: 'Bootstrap'
            value: 'includeBootstrap'
            checked: true
          }
          {
            name: 'Modernizr'
            value: 'includeModernizr'
            checked: true
          }
          {
            name: 'Bootstrap Javascript files'
            value: 'includeJsBootstrap'
            checked: true
          }
          {
            name: 'FontAwesome',
            value: 'includeFontAwesome',
            checked: true
          }
        ]
      }
      {
        type: 'checkbox'
        name: 'uicomponents'
        message: 'What more components would you like to support?'
        choices: [
          {
            name: 'AutoComplete'
            value: 'includeAutoComplete'
            checked: true
          }
          {
            name: 'SmartTree'
            value: 'includeSmartTree'
            checked: true
          }
          {
            name: 'SmartUrl'
            value: 'includeSmartUrl'
            checked: true
          }
          {
            name: 'SmartList'
            value: 'includeSmartList'
            checked: true
          }
          {
            name: 'SmartPagination'
            value: 'includeSmartPagination'
            checked: true
          }
        ]
      }
    ]
    @prompt prompts, (answers) =>
        isChecked = (choices, value) -> return value in choices
        @appname = answers.appname.replace /\"/g, '\\"'
        @description = answers.description.replace /\"/g, '\\"'
        @selectStyle = answers.selectStyle
        @root_path = answers.root_path
        @includeBootstrap = isChecked answers.uifeatures, 'includeBootstrap'
        @includeModernizr = isChecked answers.uifeatures, 'includeModernizr'
        @includeJsBootstrap = isChecked answers.uifeatures, 'includeJsBootstrap'
        @includeFontAwesome = isChecked answers.uifeatures, 'includeFontAwesome'
        @includeAutoComplete = isChecked answers.uicomponents, 'includeAutoComplete'
        @includeSmartList = isChecked answers.uicomponents, 'includeSmartList'
        @includeSmartTree = isChecked answers.uicomponents, 'includeSmartTree'
        @includeSmartUrl = isChecked answers.uicomponents, 'includeSmartUrl'
        @includeSmartPagination = isChecked answers.uicomponents, 'includeSmartPagination'
        done()


FantaGenerator.prototype.projectfiles = ->
  @copy 'editorconfig', '.editorconfig'
  @copy 'jshintrc', '.jshintrc'

FantaGenerator.prototype.gruntfile = ->
  @copy 'Gruntfile.js', 'Gruntfile.js'

FantaGenerator.prototype.packageJSON = ->
  @template '_package.json', 'package.json'

FantaGenerator.prototype.bowerJSON = ->
  @template '_bower.json', 'bower.json'

FantaGenerator.prototype.coffeelint = ->
  @copy '_coffeelint.json', 'coffeelint.json'

FantaGenerator.prototype.app = ->
  @mkdir 'app'
  @mkdir 'app/scripts'
  @mkdir 'app/scripts/cells'
  @mkdir 'app/scripts/common'
  @mkdir 'app/styles'
  @mkdir 'app/views'
  @mkdir 'app/templates'
  @mkdir 'app/jade'
  @mkdir 'app/jade/layouts'
  @mkdir 'dist'

FantaGenerator.prototype.h5bp = ->
  @copy 'favicon.ico', 'app/favicon.ico'
  @copy '404.html', 'app/404.html'
  @copy 'robots.txt', 'app/robots.txt'

FantaGenerator.prototype.jade = ->
  @template 'jade/_index.jade', 'app/jade/index.jade'
  @template 'jade/_default.jade', 'app/jade/layouts/_default.jade'

FantaGenerator.prototype.style = ->
  switch @selectStyle
    when "Less" then @template 'styles/_main.less', 'app/styles/main.less'
    when "Sass" then @template 'styles/_main.scss', 'app/styles/main.scss'


FantaGenerator.prototype.seajs = ->
  @template '_seajs-config.coffee', 'app/scripts/seajs-config.coffee'

FantaGenerator.prototype.uicomponents = ->
  #copy common
  @template 'scripts/_main.coffee', 'app/scripts/main.coffee'
  @copy 'scripts/common/_const.coffee', 'app/scripts/common/const.coffee'
  @copy 'scripts/common/_utils.coffee', 'app/scripts/common/utils.coffee'

  #copy cells
  if @includeAutoComplete
    @copy 'scripts/cells/_acp.coffee', 'app/scripts/cells/acp.coffee'
  if @includeSmartTree
    @copy 'scripts/cells/_tree.coffee', 'app/scripts/cells/tree.coffee'
  if @includeSmartList
    @copy 'scripts/cells/_zlist.coffee', 'app/scripts/cells/zlist.coffee'
  if @includeSmartPagination
    @copy 'scripts/cells/_paginator.coffee', 'app/scripts/cells/paginator.coffee'

module.exports = FantaGenerator
