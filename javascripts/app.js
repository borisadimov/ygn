(function() {
  'use strict';

  var globals = typeof window === 'undefined' ? global : window;
  if (typeof globals.require === 'function') return;

  var modules = {};
  var cache = {};
  var aliases = {};
  var has = ({}).hasOwnProperty;

  var endsWith = function(str, suffix) {
    return str.indexOf(suffix, str.length - suffix.length) !== -1;
  };

  var _cmp = 'components/';
  var unalias = function(alias, loaderPath) {
    var start = 0;
    if (loaderPath) {
      if (loaderPath.indexOf(_cmp) === 0) {
        start = _cmp.length;
      }
      if (loaderPath.indexOf('/', start) > 0) {
        loaderPath = loaderPath.substring(start, loaderPath.indexOf('/', start));
      }
    }
    var result = aliases[alias + '/index.js'] || aliases[loaderPath + '/deps/' + alias + '/index.js'];
    if (result) {
      return _cmp + result.substring(0, result.length - '.js'.length);
    }
    return alias;
  };

  var _reg = /^\.\.?(\/|$)/;
  var expand = function(root, name) {
    var results = [], part;
    var parts = (_reg.test(name) ? root + '/' + name : name).split('/');
    for (var i = 0, length = parts.length; i < length; i++) {
      part = parts[i];
      if (part === '..') {
        results.pop();
      } else if (part !== '.' && part !== '') {
        results.push(part);
      }
    }
    return results.join('/');
  };

  var dirname = function(path) {
    return path.split('/').slice(0, -1).join('/');
  };

  var localRequire = function(path) {
    return function expanded(name) {
      var absolute = expand(dirname(path), name);
      return globals.require(absolute, path);
    };
  };

  var initModule = function(name, definition) {
    var module = {id: name, exports: {}};
    cache[name] = module;
    definition(module.exports, localRequire(name), module);
    return module.exports;
  };

  var require = function(name, loaderPath) {
    var path = expand(name, '.');
    if (loaderPath == null) loaderPath = '/';
    path = unalias(name, loaderPath);

    if (has.call(cache, path)) return cache[path].exports;
    if (has.call(modules, path)) return initModule(path, modules[path]);

    var dirIndex = expand(path, './index');
    if (has.call(cache, dirIndex)) return cache[dirIndex].exports;
    if (has.call(modules, dirIndex)) return initModule(dirIndex, modules[dirIndex]);

    throw new Error('Cannot find module "' + name + '" from '+ '"' + loaderPath + '"');
  };

  require.alias = function(from, to) {
    aliases[to] = from;
  };

  require.register = require.define = function(bundle, fn) {
    if (typeof bundle === 'object') {
      for (var key in bundle) {
        if (has.call(bundle, key)) {
          modules[key] = bundle[key];
        }
      }
    } else {
      modules[bundle] = fn;
    }
  };

  require.list = function() {
    var result = [];
    for (var item in modules) {
      if (has.call(modules, item)) {
        result.push(item);
      }
    }
    return result;
  };

  require.brunch = true;
  require._cache = cache;
  globals.require = require;
})();
require.register("index.static", function(exports, require, module) {
var __templateData = function template(locals) {
var buf = [];
var jade_mixins = {};
var jade_interp;

buf.push("<!DOCTYPE html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"><title>YGN</title><meta name=\"viewport\" content=\"width=device-width\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no\"><link rel=\"stylesheet\" href=\"/stylesheets/app.css\"><script src=\"/javascripts/vendor.js\"></script><script src=\"/javascripts/app.js\"></script><script>require('init');\n</script></head><body><div class=\"screen shown visible s-1\">never</div><div class=\"screen s-2\">gonna</div><div class=\"screen s-3\">give</div><div class=\"screen\">you</div><div class=\"screen\">up</div></body>");;return buf.join("");
};
if (typeof define === 'function' && define.amd) {
  define([], function() {
    return __templateData;
  });
} else if (typeof module === 'object' && module && module.exports) {
  module.exports = __templateData;
} else {
  __templateData;
}
});

;require.register("init", function(exports, require, module) {
var TRANSITION_END, createScrollListener, lethargy, nextScreen, prevScreen, scrollDisabled;

TRANSITION_END = 'webkitTransitionEnd transitionend msTransitionEnd oTransitionEnd';

lethargy = new Lethargy();

scrollDisabled = false;

window.ready = function(fn) {
  if (document.readyState !== 'loading') {
    return fn();
  } else {
    return document.addEventListener('DOMContentLoaded', fn);
  }
};

createScrollListener = function(elem, handler) {
  if (elem.addEventListener) {
    if ('onwheel' in document) {
      return elem.addEventListener("wheel", handler);
    } else if ('onmousewheel' in document) {
      return elem.addEventListener("mousewheel", handler);
    } else {
      return elem.addEventListener("MozMousePixelScroll", handler);
    }
  } else {
    return elem.attachEvent("onmousewheel", handler);
  }
};

nextScreen = function() {
  var active, next;
  active = $('.screen.visible');
  next = active.next();
  if (!next.hasClass('screen')) {
    return;
  }
  next.addClass('shown');
  return setTimeout(function() {
    active.addClass('scrolled').on(TRANSITION_END, function() {
      $(this).off(TRANSITION_END);
      $(this).removeClass('visible');
      return $(this).removeClass('shown');
    });
    return next.addClass('visible');
  }, 2);
};

prevScreen = function() {
  var active, next;
  active = $('.screen.visible');
  next = active.prev();
  if (!next.hasClass('screen')) {
    return;
  }
  next.addClass('shown');
  return setTimeout(function() {
    active.removeClass('visible').on(TRANSITION_END, function() {
      $(this).off(TRANSITION_END);
      return $(this).removeClass('shown');
    });
    next.addClass('visible');
    return setTimeout(function() {
      return next.removeClass('scrolled');
    });
  }, 2);
};

ready(function() {
  var elem, info, onWheel;
  elem = document.querySelector('body');
  info = 0;
  onWheel = function(e) {
    var scrollInfo;
    e = e || window.event;
    scrollInfo = lethargy.check(e);
    if (scrollInfo !== false) {
      if (!scrollDisabled) {
        scrollDisabled = true;
        if (scrollInfo === 1) {
          prevScreen();
        } else {
          nextScreen();
        }
        setTimeout(function() {
          return scrollDisabled = false;
        }, 1000);
      }
    }
    if (e.preventDefault) {
      e.preventDefault();
    } else {
      e.returnValue = false;
    }
    return false;
  };
  return createScrollListener(elem, onWheel);
});
});

;
//# sourceMappingURL=app.js.map