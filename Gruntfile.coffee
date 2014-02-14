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
      public:
        files: [
          expand: true,
          dot: true,
          cwd: 'app',
          src: 'public/**/*',
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
      parties:
        files: [
          expand: true,
          cwd: 'app',
          src: 'scripts/parties.js',
          dest: 'dist'
        ]
      
    express: 
      options:
        port: 5000
        hostname: 'localhost'
      livereload:
        options:
          bases: ['dist']
          livereload: true
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
        files: 'app/public/**/*'
        tasks: 'copy:public'
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
    'express:dist',
    'express-keepalive'
  ]

  grunt.registerTask 'default', 'server'

  grunt.registerTask 'heroku:', [
    'clean',
    'coffee:dist',
    'emberTemplates',
    'less:dist',
    'copy'
  ]
