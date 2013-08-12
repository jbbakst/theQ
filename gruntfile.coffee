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

    coffeelint:
      dist: 'app/scripts/**/*.coffee'
      test: 'test/spec/**/*.coffee'

    coffee: 
      dist: 
        files: 'dist/scripts/app.js': 'app/scripts/**/*.coffee'
      test: 
        options:
          join: true
        files: 
          'dist/spec/test.js': 'test/spec/**/*.coffee'

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

    uglify: 
      dist:
        files: [
          'dist/scripts/app.min.js': 'dist/scripts/app.js',
          'dist/scripts/compiled-templates.min.js': 'dist/scripts/compiled-templates.js'
        ]

    cssmin:
      dist:
        files: 'dist/styles/app.min.css': 'dist/styles/app.css'
      
    express: 
      options:
        port: 5000
        hostname: 'localhost'
      livereload:
        options:
          bases: ['app', 'dist']
          livereload: true
      test:
        options:
          bases: ['test', 'dist']
          livereload: false
      dist:
        options:
          bases: ['dist']
          livereload: false

    open: 
      server: 
        path: 'http://localhost:5000'

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

    jasmine: 
      unit: 
        src: 'dist/scripts/*.js'
        options: 
          specs: 'dist/spec/test.js'
          vendor: [
            'dist/bower_components/jquery/jquery.js',
            'dist/bower_components/handlebars/handlebars.runtime.js',
            'dist/bower_components/ember/ember.js'
          ]

  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-cssmin'
  grunt.loadNpmTasks 'grunt-contrib-jasmine'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-ember-templates'
  grunt.loadNpmTasks 'grunt-express'
  grunt.loadNpmTasks 'grunt-open'

  grunt.registerTask 'build', [
    'clean',
    'emberTemplates',
    'coffee:dist',
    'less:dist',
    'uglify',
    'cssmin',
    'copy'
  ]

  grunt.registerTask 'test', [
    'clean',
    'coffeelint:test',
    'coffee',
    'emberTemplates',
    'copy:components'
    'express:test',
    'jasmine'
  ]

  grunt.registerTask 'server', [
    'clean',
    'coffeelint:dist',
    'coffee:dist',
    'emberTemplates',
    'less:dist',
    'copy:images',
    'express:livereload',
    'open',
    'watch'
  ]

  # Remember to use minified bower components for distribution!
  grunt.registerTask 'dist', [
    'build',
    'open',
    'express:dist',
    'express-keepalive'
  ]

  grunt.registerTask 'default', 'build'