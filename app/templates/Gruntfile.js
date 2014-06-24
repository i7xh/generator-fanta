'use strict';

module.exports = function(grunt) {

  // Load grunt tasks automatically
  require('load-grunt-tasks')(grunt);

  // Time how long tasks take. Can help when optimizing build times
  require('time-grunt')(grunt);

  // Configurable paths
  var config = {
      uiApp: 'app',
      uiDist: 'dist',
      uiScript: 'app/scripts',
      uiStyle: 'app/styles',
      uiView: 'app/jade',
      uiTemplate: 'app/templates',
      uiBower: 'bower_components'
  };

  grunt.initConfig({

    // Project settings
    config: config,
     
    // Watches files for changes and runs tasks based on the changed files
    watch: {
      gruntfile: {
        files: ['Gruntfile.js']
    },
    shell: {
      files: ['bower.json'],
      tasks: ['shell:bowerInstall', 'copy:bower', 'copy:fonts']
    },
    coffee: {
      files: ['<%%= config.uiScript %>/{,*/}*.{coffee,litcoffee,coffee.md}'],
      tasks: ['coffee:dist'],
      options: {
        livereload: true
      }
    },
    jade: {
      files: ['<%%= config.uiView %>/**/*.jade'],
      tasks: ['jade:compile'],
      options: {
        livereload: true
      }
    },
    less: {
      files: ['<%%= config.uiStyle %>/{,*/}*.less'],
      tasks: ['less:compile'],
      options: {
        livereload: true
      }
    },
    sass: {
        files: ['<%%= config.uiApp %>/styles/{,*/}*.{scss,sass}'],
        tasks: ['sass:server']
    }
  },

  // Empties folders to start fresh
  clean: {
      dist: {
          files: [{
              dot: true,
              src: [
                  '.tmp',
                  '<%%= config.uiDist %>/*',
                  '<%%= config.uiTemplate %>/*',
                  '!<%%= config.uiDist %>/.git*'
              ]
          }]
      },
      server: '.tmp'
  },

  shell: {
    bowerInstall: {
      options: {
        stdout: true
      },
      command: 'bower install'
    }
  },

  // Compiles CoffeeScript to JavaScript
  coffee: {
      dist: {
          files: [{
              expand: true,
              cwd: '<%%= config.uiScript %>',
              src: '{,*/}*.{coffee,litcoffee,coffee.md}',
              dest: '<%%= config.uiDist %>/scripts',
              ext: '.js'
          }]
      },
  },

  jade: {
    compile: {
      options: {
        pretty: true,
        data: {
            debug: false
        }
      },
      files: [
      {
        expand: true,
        cwd: '<%%= config.uiView %>',
        src: ['**/*.jade'],
        dest: '<%%= config.uiTemplate %>',
        ext: '.html'
      }
      ]
    }
  },

  less: { 
    compile: {
      options: {
        paths: ['<%%= config.uiStyle %>']
      },
      files: {
        '<%%= config.uiDist %>/styles/main.css': '<%%= config.uiStyle %>/main.less'
      }
    }
  },

  // Compiles Sass to CSS and generates necessary files if requested
  sass: {
      options: {
          loadPath: [
              'bower_components'
          ]
      },
      dist: {
          files: [{
              expand: true,
              cwd: '<%%= config.uiApp %>/styles',
              src: ['*.scss'],
              dest: '.tmp/styles',
              ext: '.css'
          }]
      },
      server: {
          files: [{
              expand: true,
              cwd: '<%%= config.uiApp %>/styles',
              src: ['*.scss'],
              dest: '.tmp/styles',
              ext: '.css'
          }]
      }
  },

  copy: {
    bower: {
      expand: true, 
      src: ['<%%= config.uiBower %>/**'], 
      dest: '<%%= config.uiDist %>'
    },
    fonts: {
      expand: true,
      src: ['<%%= config.uiBower %>/bootstrap/fonts/**'],
      dest: '<%%=config.uiDist %>/fonts/glyphicons',
      filter: 'isFile',
      flatten: 'true'
    }
  }
});

  grunt.registerTask('build', [
      'clean:dist',
      'jade:compile',<% if (selectStyle === 'Less') { %>
      'less:compile',<% } %><% if (selectStyle == 'Sass') { %>
      'sass:dist',<% } %>
      'coffee:dist'
  ]);

  //register default
  grunt.registerTask('default', [
      'shell:bowerInstall',
      'build',
      'copy:bower',
      'copy:fonts'
  ]);
};
