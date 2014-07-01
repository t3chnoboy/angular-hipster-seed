#Angular hipster seed
AngularJS application boilerplate for hipsters

##Features
* Jade instead of html
* Coffee-Script instead of JS
* Stylus instead of css
* Automatic compilation
* Livereload without any plugins
* Development build with source maps
* Production build with optimizations
* Automatic bower components injection
* Automatic scripts and stylesheets injection

##Installation

Clone repo using git
```sh
git clone https://github.com/t3chnoboy/angular-hipster-seed.git
cd angular-hipster-seed
```
Install dependemcies
```sh
npm install
bower install
```

##Usage

###Running the App during Development
This command automatically compiles coffee, jade and stylus, injects bower components, generates source maps, starts livereload server and opens your app in the browser.
```sh
gulp serve
```

###Compiling app for development
This command compiles project and generates source maps. Output goes to ```sh app/``` folder
```
gulp compile
```

###Building the App for Production
This command compiles project and optimizes it for production. Output goes to ```sh dist/``` folder
```
gulp build
```

##Directory layout

### Source

```sh
angular-hipster-seed
└── src
    ├── images               # image files
    ├── index.jade           # app layout file (the main jade template file of the app)
    ├── partials             # angular view partials (partial jade templates)
    ├── scripts              # coffeescripts
    │   ├── app.coffee       # application
    │   ├── controllers      # application controllers
    │   ├── directives       # application directives
    │   ├── filters          # custom angular filters
    │   └── services         # custom angular services
    └── styles               # stylus stylesheets
        └── style.styl
```

### Development build

```sh
angular-hipster-seed
 app                      # development build
  ├── bower_components
  ├── images
  ├── index.html          # compiled app layout
  ├── partials            # compiled partials
  ├── scripts             # compiled scripts with source maps
  │   ├── app.js
  │   ├── app.js.map      # source map
  │   ├── controllers
  │   ├── directives
  │   └── services
  └── styles               # compiled stylesheets
      └── style.css
```

###Production build

```sh
 dist                     # production build
  ├── bower_components
  ├── images               # optimized images
  │   └── amazon.png
  ├── index.html           # minified app layout
  ├── partials             # minified partials
  ├── scripts
  │   └── app.js           # minified and concatenated javascripts
  └── styles
      └── style.css        # minified and concatenated styles
```
