module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    clean:
      build: [
        'build/css'
        'build/js'
        'build/index.html'
      ]
      dist: [ 'build' ]
    sass: dist:
      options: style: 'compressed'
      files: 'assets/css/all.min.css': 'assets/css/all.scss'
    connect: server: options:
      port: 3333
      livereload: true
      base: 'build'
    coffee: compile: files: 'assets/js/all.js': 'assets/js/*.coffee'
    concat: build:
      src: [
        'bower_components/jquery/dist/jquery.min.js'
        'assets/js/all.js'
      ]
      dest: 'build/js/all.min.js'
    uglify: build: files: 'build/js/all.min.js': [ 'assets/js/all.min.js' ]
    htmlmin:
      main:
        options:
          removeComments: true
          collapseWhitespace: true
        files:
          'build/': 'assets/*.html'
    watch:
      options: livereload: true
      main:
        files: [
          'assets/js/*.coffee'
          'assets/js/*.js'
          'assets/js/libs/*'
          'assets/css/*.scss'
          'assets/css/all.min.css'
          'assets/*.html'
        ]
        tasks: [ 'build' ]
    copy:
      fonts: files: [ {
        expand: true
        flatten: true
        src: [ 'assets/css/fonts/*' ]
        dest: 'build/css/fonts/'
        filter: 'isFile'
      } ]
      main: files: [ {
        expand: true
        flatten: true
        src: [ 'assets/*.html' ]
        dest: 'build/'
        filter: 'isFile'
      } ]
      images: files: [ {
        expand: true
        flatten: true
        src: [ 'assets/images/*' ]
        dest: 'build/images/'
        filter: 'isFile'
      } ]
      cssmap: files: [ {
        expand: true
        flatten: true
        src: [ 'assets/css/*.map' ]
        dest: 'build/css/'
        filter: 'isFile'
      } ]
    autoprefixer: single_file:
      src: 'assets/css/all.min.css'
      dest: 'build/css/all.min.css'
    imageoptim: myTask:
      options:
        jpegMini: true
        imageAlpha: true
        quitAfter: true
      src: [ 'build/images/' ]

  require('load-grunt-tasks') grunt, [ 'grunt-*' ]

  grunt.registerTask 'default', [
    'clean:build'
    'sass'
    'autoprefixer'
    'coffee'
    'concat'
    # 'uglify'
    'copy'
    'connect'
    'watch'
  ]

  grunt.registerTask 'build', [
    'clean:build'
    'sass'
    'autoprefixer'
    'coffee'
    'concat'
    # 'uglify'
    'copy:main'
  ]

  grunt.registerTask 'dist', [
    'clean:dist'
    'sass'
    'autoprefixer'
    'coffee'
    'concat'
    'uglify'
    'htmlmin'
    'copy'
  ]

  grunt.registerTask 'copyimages', [ 'copy:images' ]
  grunt.registerTask 'optimize', [ 'imageoptim' ]
