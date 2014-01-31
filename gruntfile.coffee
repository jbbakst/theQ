'use strict'

module.exports = (grunt)->

  grunt.initConfig

    clean: 
      dist: 
        files: [
          dot: true,
          src: 'dist'
        ]

    emberTemplates: 
      compile:
        options: 
          templateName: (sourceFile)->
            sourceFile.replace 'app/templates/', ''
        files: 
          'dist/scripts/compiled-templates.js': 'app/templates/**/*.handlebars'

    coffee: 
      dist: 
        files: 'dist/scripts/app.js': 'app/scripts/**/*.coffee'

    less:
      dist:
        options:
          paths: 'app/styles'
        files:
          'dist/styles/app.css': 'app/styles/app.less'

    copy: 
      images: 
        files: [
          expand: true,
          dot: true,
          cwd: 'app',
          src: 'images/**/*',
          dest: 'dist'
        ]
      index:
        files: [
          expand: true,
          cwd: 'app',
          src: 'index.html',
          dest: 'dist'
        ]
      components:
        files: [
          expand: true,
          dot: true,
          cwd: 'app',
          src: 'bower_components/**/*',
          dest: 'dist'
        ]
      
    express: 
      options:
        port: 8080
        hostname: 'localhost'
      livereload:
        options:
          bases: ['dist']
          livereload: true

    open: 
      server: 
        path: 'http://localhost:8080'

    watch:
      emberTemplates:
        files: 'app/templates/**/*.handlebars'
        tasks: 'emberTemplates'
      coffee:
        files: 'app/scripts/**/*.coffee'
        tasks: 'coffee:dist'
      less:
        files: 'app/styles/*.less'
        tasks: 'less:dist'
      images:
        files: 'app/images/**/*'
        tasks: 'copy:images'
      index:
        files: 'app/index.html'
        tasks: 'copy:index'

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-ember-templates'
  grunt.loadNpmTasks 'grunt-express'
  grunt.loadNpmTasks 'grunt-open'

  grunt.registerTask 'server', [
    'clean',
    'coffee:dist',
    'emberTemplates',
    'less:dist',
    'copy',
    'express:livereload',
    'open',
    'watch'
  ]

  grunt.registerTask 'dist', [
    'clean',
    'coffee:dist',
    'emberTemplates',
    'less:dist',
    'copy',
    'express:livereload',
    'express-keepalive'
  ]

  grunt.registerTask 'default', 'server'