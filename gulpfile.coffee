gulp       = require 'gulp'
open       = require 'open'
es         = require 'event-stream'
jade       = require 'gulp-jade'
gutil      = require 'gulp-util'
ngmin      = require 'gulp-ngmin'
clean      = require 'gulp-clean'
coffee     = require 'gulp-coffee'
stylus     = require 'gulp-stylus'
concat     = require 'gulp-concat'
uglify     = require 'gulp-uglify'
inject     = require 'gulp-inject'
connect    = require 'gulp-connect'
imagemin   = require 'gulp-imagemin'
sourcemaps = require 'gulp-sourcemaps'
bowerFiles = require 'gulp-bower-files'

build = 'build'

paths =
  index:     'src/index.jade'
  fonts:     'src/fonts/**/*'
  images:    'src/images/**/*'
  styles:    'src/css/**/*.styl'
  scripts:   'src/js/**/*.coffee'
  partials:  'src/partials/**/*.jade'


############################## Development ##############################


# Compile coffee, generate source maps, trigger livereload
gulp.task 'scripts', ->
  gulp.src paths.scripts
    .pipe(sourcemaps.init())
    .pipe coffee bare: yes
    .pipe(sourcemaps.write())
    .pipe gulp.dest "#{build}/js"
    .pipe connect.reload()

#Compile stylus, trigger livereload
gulp.task 'styles', ->
  gulp.src paths.styles
    .pipe stylus()
    .pipe gulp.dest "#{build}/css"
    .pipe connect.reload()

#Copy images, trigger livereload
gulp.task 'images', ->
  gulp.src paths.images
    .pipe gulp.dest "#{build}/images"
    .pipe connect.reload()

# Copy fonts
gulp.task 'fonts', ->
  gulp.src paths.fonts
    .pipe gulp.dest "#{build}/fonts"

#Compile Jade, trigger livereload
gulp.task 'partials', ->
  gulp.src paths.partials
    .pipe jade pretty: yes
    .pipe gulp.dest "#{build}/partials"
    .pipe connect.reload()

#Compile index.jade, inject compiled stylesheets, inject compiled scripts, inject bower packages
gulp.task 'index', ['scripts', 'styles'], ->
  gulp.src paths.index
    .pipe jade pretty: yes
    .pipe inject(es.merge(
      bowerFiles read: no
    ,
      gulp.src "./#{build}/css/**/*.css", read: no
    ,
      gulp.src "./#{build}/js/**/*.js", read: no
    ), ignorePath: build)
    .pipe gulp.dest build
    .pipe connect.reload()

# Launch server and open app in default browser
gulp.task 'serve', ['compile', 'watch'], ->
  connect.server
    port       : 1337
    root       : 'build'
    livereload : yes
  open 'http://localhost:1337'

# Clean development build folder
gulp.task 'clean', ->
  gulp.src ["#{build}/**/*", "!#{build}/bower_components", "!#{build}/bower_components/**"], read: no
    .pipe clean()

############################## Production  ##############################


# Compile coffee, minify (with ngmin applied), concat all scripts
gulp.task 'scripts:prod', ->
  gulp.src paths.scripts
    .pipe coffee bare: yes
    .pipe ngmin()
    .pipe uglify()
    .pipe concat 'app.js'
    .pipe gulp.dest 'dist/js'

# Compile stylus, concat all stylesheets
gulp.task 'styles:prod', ->
  gulp.src paths.styles
    .pipe stylus()
    .pipe concat 'style.css'
    .pipe gulp.dest 'dist/css'

# Optimize images
gulp.task 'images:prod', ->
  gulp.src paths.images
    .pipe imagemin()
    .pipe gulp.dest 'dist/images'

# Compile Jade with minification enabled
gulp.task 'partials:prod', ->
  gulp.src paths.partials
    .pipe jade()
    .pipe gulp.dest 'dist/partials'

# Compile and minify index.jade, inject concatenated and minified scripts and stylesheets
gulp.task 'index:prod', ['scripts', 'styles'], ->
  gulp.src paths.index
    .pipe jade()
    .pipe inject(es.merge(
      bowerFiles read: no
    ,
      gulp.src './dist/css/**/*.css', read: no
    ,
      gulp.src './dist/js/**/*.js', read: no
    ), ignorePath: ['/dist', '/build'])
    .pipe gulp.dest 'dist/'

# Copy bower packages
gulp.task 'copy-bower:prod', ->
  gulp.src 'build/bower_components/**/*'
    .pipe gulp.dest 'dist/bower_components'

# Clean dist folder
gulp.task 'clean:prod', ->
  gulp.src 'dist'
    .pipe clean()

# Register tasks
gulp.task 'watch', ->
  gulp.watch paths.partials , ['partials']
  gulp.watch paths.scripts  , ['scripts']
  gulp.watch paths.styles   , ['styles']
  gulp.watch paths.images   , ['images']
  gulp.watch paths.index    , ['index']

gulp.task 'build'   , [
  'clean:prod', 'scripts:prod', 'styles:prod', 'images:prod'
  'partials:prod' , 'copy-bower:prod' , 'fonts' , 'index:prod'
]

gulp.task 'compile' , ['scripts', 'styles', 'images', 'partials', 'fonts', 'index']

gulp.task 'default' , ['serve']
