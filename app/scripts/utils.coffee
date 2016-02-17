window.lethargy = new Lethargy()

window.runNext = (arg1, arg2) =>
  if typeof(arg1) is 'function'
    return setTimeout arg1, 0
  else
    if typeof(arg1) is 'number' and typeof(arg2) is 'function'
      return setTimeout arg2, arg1

  console.error('wrong params for runNext')



window.ready = (fn) ->
  if document.readyState != 'loading'
    do fn
  else
    document.addEventListener 'DOMContentLoaded', fn





