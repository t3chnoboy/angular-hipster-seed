gulp       = require 'gulp'
open       = require 'open'
es         = require 'event-stream'
jade       = require 'gulp-jade'
gutil      = require 'gulp-util'
# karma      = require 'gulp-karma'
ngmin      = require 'gulp-ngmin'
coffee     = require 'gulp-coffee'
stylus     = require 'gulp-stylus'
concat     = require 'gulp-concat'
uglify     = require 'gulp-uglify'
# usemin     = require 'gulp-usemin'
# notify     = require 'gulp-notify'
inject     = require 'gulp-inject'
connect    = require 'gulp-connect'
imagemin   = require 'gulp-imagemin'
# protactor  = require 'gulp-protractor'
bowerFiles = require 'gulp-bower-files'


paths =
  partials:  'src/**/*.jade'
  styles:    'src/styles/**/*.styl'
  images:    'src/images/**/*'
  scripts:   'src/scripts/**/*.coffee'
  index:     'src/index.jade'

gulp.task 'scripts', ->
  gulp.src paths.scripts
    .pipe coffee bare: yes
    .pipe ngmin()
    .pipe uglify()
    .pipe concat 'app.js'
    .pipe gulp.dest 'dist/scripts'


gulp.task 'scripts-dev', ->
  gulp.src paths.scripts
    .pipe coffee
      bare: yes
      sourceMap: yes
    .pipe gulp.dest 'app/scripts'
    .pipe connect.reload()


gulp.task 'styles', ->
  gulp.src paths.styles
    .pipe stylus()
    .pipe concat 'style.css'
    .pipe gulp.dest 'dist/styles'

gulp.task 'styles-dev', ->
  gulp.src paths.styles
    .pipe stylus()
    .pipe gulp.dest 'app/styles'
    .pipe connect.reload()

gulp.task 'images', ->
  gulp.src paths.images
    .pipe imagemin()
    .pipe gulp.dest 'dist/images'

gulp.task 'images-dev', ->
  gulp.src paths.images
    .pipe gulp.dest 'app/images'
    .pipe connect.reload()

gulp.task 'partials', ->
  gulp.src paths.partials
    .pipe jade()
    .pipe gulp.dest 'dist/'

gulp.task 'partials-dev', ->
  gulp.src paths.partials
    .pipe jade pretty: yes
    .pipe gulp.dest 'app/'
    .pipe connect.reload()

gulp.task 'index', ['scripts', 'styles'], ->
  gulp.src paths.index
    .pipe jade()
    .pipe inject(es.merge(
      bowerFiles read: no
    ,
      gulp.src './dist/styles/**/*.css', read: no
    ,
      gulp.src './dist/scripts/**/*.js', read: no
    ), ignorePath: ['/dist', '/app'])
    .pipe gulp.dest 'dist/'

gulp.task 'index-dev', ['scripts-dev', 'styles-dev'], ->
  gulp.src paths.index
    .pipe jade pretty: yes
    .pipe inject(es.merge(
      bowerFiles read: no
    ,
      gulp.src './app/styles/**/*.css', read: no
    ,
      gulp.src './app/scripts/**/*.js', read: no
    ), ignorePath: '/app')
    .pipe gulp.dest 'app/'

gulp.task 'copy-bower', ->
  gulp.src 'app/bower_components/**/*'
    .pipe gulp.dest 'dist/bower_components'

gulp.task 'serve', ->
  connect.server
    port       : 1337
    root       : 'app'
    livereload : yes

  open 'http://localhost:1337', 'safari'

gulp.task 'watch', ->
  gulp.watch paths.partials , ['partials-dev']
  gulp.watch paths.styles   , ['styles-dev']
  gulp.watch paths.scripts  , ['scripts-dev']
  gulp.watch paths.images   , ['images-dev']

gulp.task 'build'   , ['scripts'     , 'styles'     , 'images'     , 'partials', 'copy-bower', 'index']
gulp.task 'compile' , ['scripts-dev' , 'styles-dev' , 'images-dev' , 'partials-dev', 'index-dev']
gulp.task 'default' , ['compile'     , 'watch'      , 'serve']
