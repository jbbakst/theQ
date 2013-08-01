'use strict'

mountFolder = (connect, dir)->
  connect.static require('path').resolve dir 

lrSnippet = require('grunt-contrib-livereload/lib/utils').livereloadSnippet

module.exports = (grunt)->

  grunt.initConfig

    clean: 
      dist: 
        files: [
          dot: true,
          src: [
            'dist',
            'dist/*'
          ]
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
        files: 
          'dist/scripts/app.js': 'app/scripts/**/*.coffee'
      test: 
        options:
          join: true
        files: 
          'dist/spec/test.js': 'test/spec/**/*.coffee'

    less:
      dist:
        options:
          paths: ['app/styles']
        files:
          'dist/styles/main.css': 'app/styles/main.less'

    # uglify: 
    #   dist:
    #     files: []?
    #       'file.min.js': 'file.js'
      
    connect: 
      options:
        port: 5000
        hostname: 'localhost'
      livereload:
        options:
          middleware: (connect)->
            [
              lrSnippet,
              mountFolder(connect, 'dist'),
              mountFolder(connect, 'app')
            ]
      test: 
        options: 
          middleware: (connect)->
            [
              mountFolder(connect, 'dist'),
              mountFolder(connect, 'test')
            ]
      dist: 
        options: 
          middleware: (connect)->
            [mountFolder connect, 'dist']

    open: 
      server: 
        path: 'http://localhost:5000'

    watch: 
      emberTemplates:
        files: 'app/templates/**/*.handlebars'
        tasks: ['emberTemplates']
      coffee:
        files: ['app/scripts/**/*.coffee']
        tasks: ['coffee:dist']
      coffeeTest:
        files: ['test/spec/**/*.coffee']
        tasks: ['coffee:test']
      livereload:
        files: ['app/*.html', 'dist/**/*']
        tasks: ['livereload']

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

    copy: 
      images: 
        files: [
          expand: true,
          dot: true,
          cwd: 'app',
          src: 'images/**/*',
          dest: 'dist'
        ]
      components: 
        files: [
          expand: true,
          dot: true,
          cwd: 'app',
          src: 'bower_components/**/*',
          dest: 'dist',
        ]

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-jasmine'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-livereload'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-ember-templates'
  grunt.loadNpmTasks 'grunt-open'
  grunt.loadNpmTasks 'grunt-regarde'  

  grunt.renameTask 'regarde', 'watch' 

  grunt.registerTask 'build', [
    'clean',
    'emberTemplates',
    'coffee:dist',
    'less:dist',
    'uglify',
    'copy'
  ]

  grunt.registerTask 'test', [
    'clean',
    'emberTemplates',
    'coffee:test',
    'copy:components',
    'connect:test',
    'jasmine'
  ]

  grunt.registerTask 'server', [
    'clean',
    'emberTemplates',
    'coffee:dist',
    'less:dist',
    'copy',
    'livereload-start',
    'connect:livereload',
    'open',
    'watch'
  ]

  grunt.registerTask 'server:dist', [
    'build',
    'open',
    'connect:dist:keepalive'
  ]

  grunt.registerTask 'default', ['build']