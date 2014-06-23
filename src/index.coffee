'use strict'

util = require 'util'
path = require 'path'
yeoman = require 'yeoman-generator'
yosay = require 'yosay'
chalk = require 'chalk'


class FantaGenerator extends yeoman.generators.Base
  constructor: ->
    yeoman.generators.Base.apply @, arguments
    @manifest = {}
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
        name: 'apptype'
        message: 'Would you like to create app below?'
        choices: [
          'web-app'
          'chrome-extension'
          'node-app'
        ]
      }
      {
        type: 'checkbox'
        name: 'uifeatures'
        message: 'What more would you like?'
        choices: [
          {
            name: 'bootstrap'
            value: 'includeBootstrap'
            checked: true
          }
          {
            value: 'less'
            name: 'includeLess'
            checked: true
          }
          {
            value: 'modernizr'
            name: 'includeModernizr'
            checked: false
          }
        ]
      }
    ]
    @prompt prompts, (answers) =>
        isChecked = (choices, value) -> return choices.indexOf(value) > -1
        @appname = @manifest.name = answers.appname.replace /\"/g, '\\"'
        @manifest.description = answers.description.replace /\"/g, '\\"'
        @manifest.apptype = answers.apptype
        @manifest.includeBootstrap = isChecked answers.uifeatures, 'bootstrap'
        @manifest.includeLess = isChecked answers.uifeatures, 'less'
        @manifest.includeModernizr = isChecked answers.uifeatures, 'modernizr'
        done()


FantaGenerator.prototype.projectfiles = ->
  @copy 'editorconfig', '.editorconfig'
  @copy 'jshintrc', '.jshintrc'

FantaGenerator.prototype.gruntfile = ->
  @template 'Gruntfile.js'

FantaGenerator.prototype.packageJSON = ->
  @template '_package.json', 'package.json'

FantaGenerator.prototype.bowerJSON = ->
  @template '_bower.json', 'bower.json'

FantaGenerator.prototype.app = ->
  @mkdir 'app'
  @mkdir 'app/scripts'
  @mkdir 'app/styles'
  @mkdir 'app/views'
  @mkdir 'app/templates'

FantaGenerator.prototype.manifest = ->
  switch @manifest.apptype
    when 'app-web'
      return
    when 'chrome-extension'
      return
    when 'node-app'
      return
module.exports = FantaGenerator
