!function(){"use strict";var e="undefined"==typeof window?global:window;if("function"!=typeof e.require){var t={},n={},r={},s={}.hasOwnProperty,i="components/",o=function(e,t){var n=0;t&&(0===t.indexOf(i)&&(n=i.length),t.indexOf("/",n)>0&&(t=t.substring(n,t.indexOf("/",n))));var s=r[e+"/index.js"]||r[t+"/deps/"+e+"/index.js"];return s?i+s.substring(0,s.length-".js".length):e},u=/^\.\.?(\/|$)/,l=function(e,t){for(var n,r=[],s=(u.test(t)?e+"/"+t:t).split("/"),i=0,o=s.length;o>i;i++)n=s[i],".."===n?r.pop():"."!==n&&""!==n&&r.push(n);return r.join("/")},c=function(e){return e.split("/").slice(0,-1).join("/")},a=function(t){return function(n){var r=l(c(t),n);return e.require(r,t)}},d=function(e,t){var r={id:e,exports:{}};return n[e]=r,t(r.exports,a(e),r),r.exports},f=function(e,r){var i=l(e,".");if(null==r&&(r="/"),i=o(e,r),s.call(n,i))return n[i].exports;if(s.call(t,i))return d(i,t[i]);var u=l(i,"./index");if(s.call(n,u))return n[u].exports;if(s.call(t,u))return d(u,t[u]);throw new Error('Cannot find module "'+e+'" from "'+r+'"')};f.alias=function(e,t){r[t]=e},f.register=f.define=function(e,n){if("object"==typeof e)for(var r in e)s.call(e,r)&&(t[r]=e[r]);else t[e]=n},f.list=function(){var e=[];for(var n in t)s.call(t,n)&&e.push(n);return e},f.brunch=!0,f._cache=n,e.require=f}}(),require.register("index.static",function(e,t,n){var r=function(e){var t=[];return t.push('<!DOCTYPE html><head><meta http-equiv="Content-Type" content="text/html; charset=utf-8"><title>YGN</title><meta name="viewport" content="width=device-width"><meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"><link rel="stylesheet" href="stylesheets/app.css"><script src="javascripts/vendor.js"></script><script src="javascripts/app.js"></script><script>require(\'init\');\n</script></head><body><div class="screen">never</div><div class="screen">gonna</div><div class="screen">give</div><div class="screen">you</div><div class="screen">up</div></body>'),t.join("")};"function"==typeof define&&define.amd?define([],function(){return r}):"object"==typeof n&&n&&n.exports&&(n.exports=r)}),require.register("init",function(e,t,n){var r;t("scripts/utils"),r=new(t("scripts/screens")),ready(function(){return r.init()})}),require.register("scripts/screens",function(e,t,n){var r,s=function(e,t){return function(){return e.apply(t,arguments)}};n.exports=r=function(){function e(){this.scrolldown=s(this.scrolldown,this),this.scrollup=s(this.scrollup,this),this.setActive=s(this.setActive,this),this.movePrev=s(this.movePrev,this),this.moveNext=s(this.moveNext,this),this.onScroll=s(this.onScroll,this),this.createScrollListener=s(this.createScrollListener,this),this.init=s(this.init,this)}var t,n,r,i,o;return i=null,t=null,r=null,o={0:null,1:null,2:["state-1","state-2","state-3"],3:null,4:null},n=null,e.prototype.scrollDisabled=!1,e.prototype.init=function(){var e;return e=document.querySelector("body"),this.createScrollListener(e,this.onScroll),i=$(".screen"),t=i.first(),r=0,t.addClass("shown visible"),i.each(function(e){return function(e,t){return o[e]?$(t).addClass(o[e][0]):void 0}}(this))},e.prototype.createScrollListener=function(e,t){return e.addEventListener?"onScroll"in document?e.addEventListener("wheel",t):"onmousewheel"in document?e.addEventListener("mousewheel",t):e.addEventListener("MozMousePixelScroll",t):e.attachEvent("onmousewheel",t)},e.prototype.onScroll=function(e){var t;return e=e||window.event,t=lethargy.check(e),t!==!1&&(this.scrollDisabled||(this.scrollDisabled=!0,1===t?this.movePrev():this.moveNext())),e.preventDefault?e.preventDefault():e.returnValue=!1,!1},e.prototype.moveNext=function(){var e;return e=t.next(),null!==n&&o[r][n+1]?(t.removeClass(o[r][n]),t.addClass(o[r][n+1]),n+=1,void runNext(1e3,function(e){return function(){return e.scrollDisabled=!1}}(this))):(n=null,e.hasClass("screen")?(e.addClass("shown"),runNext(10,function(s){return function(){return t.addClass("scrolled"),e.addClass("visible"),o[r+1]&&(n=0),runNext(800,function(){return t.removeClass("visible"),t.removeClass("shown"),r+=1,t=e,runNext(180,function(){return s.scrollDisabled=!1})})}}(this))):void 0)},e.prototype.movePrev=function(){var e;return e=t.prev(),null!==n&&o[r][n-1]?(t.removeClass(o[r][n]),t.addClass(o[r][n-1]),n-=1,void runNext(1e3,function(e){return function(){return e.scrollDisabled=!1}}(this))):(n=null,e.hasClass("screen")?(e.addClass("shown"),o[r-1]&&(n=o[r-1].length-1),runNext(10,function(n){return function(){return t.removeClass("visible"),e.removeClass("scrolled"),e.addClass("visible"),runNext(800,function(){return t.removeClass("shown"),r-=1,t=e,runNext(180,function(){return n.scrollDisabled=!1})})}}(this))):void 0)},e.prototype.setActive=function(e){return e.addClass("shown"),runNext(10,function(n){return function(){return e.removeClass("scrolled"),e.addClass("visible"),runNext(800,function(){return t=e})}}(this))},e.prototype.scrollup=function(e){return runNext(10,function(){return e.addClass("scrolled"),runNext(800,function(){return e.removeClass("visible"),e.removeClass("shown")})})},e.prototype.scrolldown=function(e){return runNext(10,function(){return t.removeClass("visible"),runNext(800,function(){return e.removeClass("shown")})})},e}()}),require.register("scripts/utils",function(e,t,n){window.lethargy=new Lethargy,window.runNext=function(e){return function(e,t){return"function"==typeof e?setTimeout(e,0):"number"==typeof e&&"function"==typeof t?setTimeout(t,e):console.error("wrong params for runNext")}}(this),window.ready=function(e){return"loading"!==document.readyState?e():document.addEventListener("DOMContentLoaded",e)}});