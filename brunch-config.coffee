exports.config =
  # See http://brunch.io/#documentation for docs.
  files:
    javascripts:
      joinTo:
        'javascripts/app.js': /^app/
        'javascripts/vendor.js': /^(?!app)/

    stylesheets:
      joinTo: 'stylesheets/app.css'

    templates:
      joinTo: 'javascripts/app.js' # : /.+\.jade$/

  plugins:

    jade:
      pretty: yes # Adds pretty-indentation whitespaces to output (false by default)

      # locals:
      #   github: false

    static_jade:                        # all optionals
      extension:  ".static.jade"        # static-compile each file with this extension in `assets`
      asset:      "app/assets"     # specify the compilation output

    postcss:
      processors: [
        require('postcss-will-change'),
        require('autoprefixer')(['> 1%','last 8 versions','ie 9']),
        require('postcss-flexbugs-fixes'),
        require('postcss-pxtorem')({
          replace: false,
          selectorBlackList: ['body', 'html'],
          propWhiteList: [
            'font',
            'font-size',
            'line-height',
            'letter-spacing',
            'padding',
            'padding-left',
            'padding-right',
            'padding-top',
            'padding-bottom',
            'margin',
            'margin-left',
            'margin-right',
            'margin-top',
            'margin-bottom',
            'border-bottom'
          ]
        })
      ]
