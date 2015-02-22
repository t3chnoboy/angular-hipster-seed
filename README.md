# (Angular) hipster seed
Web application boilerplate for hipsters?

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
git clone https://github.com/ebake/hipster-seed.git
cd hipster-seed
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
hipster-seed
└── src
    ├── 00-example           # example static content directory
        ├── app.coffee
        ├── index.jade
        └── style.styl
    ├── app.coffee           # coffeescript application
    ├── images               # image files
    ├── index.jade           # app layout file (the main jade template file of the app)
    └── style.styl           # stylus stylesheets
```

### Development build

```sh
hipster-seed
└── build                    # development build
    └── 00-example          # example compiled directory
        ├── app.js
        ├── app.js.map       # source map
        ├── index.html
        └── style.css
    ├── app.js
    ├── app.js.map          # source map
    ├── bower_components
    ├── images
    ├── index.html          # compiled app layout
    ├── partials            # compiled partials
    └── style.css           # compiled stylesheets
```

###Production build

```sh
hipster-seed
└── dist                     # production build
    └── 00-example           # example directory minified
        ├── app.js
        ├── index.html
        └── style.css
    ├── bower_components
    ├── images               # optimized images
    │   └── amazon.png
    ├── index.html           # minified app layout
    ├── app.js               # minified and concatenated javascripts
    └── style.css            # minified and concatenated styles
```
