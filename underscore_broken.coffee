
  # Call iterator(value, key, obj) for each element of obj
  # You can use "in" to test for array presence
  each = (obj, iterator) ->
    if obj instanceof Array
      iterator item, index, obj for item, index in obj
    else
      iterator value, key, obj for own key, value of obj


  # Determine if the array or object contains a given value (using `===`).
  contains = (obj, target) ->
    # use reduce in contains?
    bool = false
    each obj, (value) -> if value is target then bool = yes else bool
    bool

  # Return the results of applying an iterator to each element.
  map = (array, iterator) -> each array, (value) -> iterator value

  # Takes an array of objects and returns and array of the values of
  # a certain property in it. E.g. take an array of people and return
  # an array of just their ages
  pluck = (obj, key) -> map obj, (property) -> property[key] if property[key]


  # Return an array of the last n elements of an array. If n is undefined,
  # return just the last element.
  last = (array, n) ->
    return unless array?
    [array...] = array
    if n?
      if n is 0 then [] else array.slice(-n)
    else
      array.pop()

  # Like last, but for the first elements
  first = (array, n) ->
    return unless array?
    [array...] = array
    n = 1 unless n?
    array[0...n]

  # Reduces an array or object to a single value by repetitively calling
  # iterator(previousValue, item) for each item. previousValue should be
  # the return value of the previous iterator call.
  #
  # You can pass in an initialValue that is passed to the first iterator
  # call. Defaults to 0.
  #
  # Example:
  #   var numbers = [1,2,3];
  #   var sum = _.reduce(numbers, function(previous_value, item){
  #     return previous_value + item;
  #   }, 0); # should be 6
  #
  reduce = (obj, iterator, collector = 0) ->
    each obj, (value) -> collector = iterator collector, value
    collector

  # Return all elements of an array that pass a truth test.
  select = (array, iterator) -> value for value in array when iterator value

  # Return all elements of an array that don't pass a truth test.
  reject = (array, iterator) -> value for value in array when not iterator value

  # Determine whether all of the elements match a truth test.
  every = (obj, iterator) ->
    return obj if obj.length is 0
    for value in obj
      if iterator value then bool = true else return false
    bool

  # Determine whether any of the elements pass a truth test.
  any = (obj, iterator) ->
    return no if obj.length is 0
    for value in obj
      if iterator?
        if iterator value then return true else bool = false
      else
        if value then return true else bool = false
    bool

  # Produce a duplicate-free version of the array.
  uniq = (array) ->
    tempArray = []
    tempArray.push value for value in array when not contains tempArray, value

  # Return a function that can be called at most one time. Subsequent calls
  # should return the previously returned value.
  once = (func) ->
    called = false
    ->
      return result if called
      called = true
      result = func()

  # Memoize an expensive function by storing its results. You may assume
  # that the function takes only one argument and that it is a primitive.
  #
  # Memoize should return a function that when called, will check if it has
  # already computed the result for the given argument and return that value
  # instead if possible.
  memoize = (func) ->
    result = {}
    (param) ->
      if result.hasOwnProperty(param) then result[param] else result[param] = func(param)

  # Delays a function for the given number of milliseconds, and then calls
  # it with the arguments supplied.
  #
  # The arguments for the original function are passed after the wait
  # parameter. For example _.delay(someFunction, 500, 'a', 'b') will
  # call someFunction('a', 'b') after 500ms
  delay = (fun, wait) ->
    [arg...] = arguments
    arg = arg.slice(2)
    setTimeout( (-> fun(arg)), wait)


  # Extend a given object with all the properties of the passed in
  # object(s).
  #
  # Example:
  #   var obj1 = {key1: "something"};
  #   _.extend(obj1, {
  #     key2: "something new",
  #     key3: "something else new"
  #   }, {
  #     bla: "even more stuff"
  #   }); # obj1 now contains key1, key2, key3 and bla
  #
  extend = (obj) ->
    [args...] = arguments
    for arg in args
      for key, value of arg
        obj[key] = arg[key]
    obj


    # for key, value of arg[1]
    #   obj[key] = value
    # obj

  # Like extend, but doesn't ever overwrite a key that already
  # exists in obj
  defaults = (obj) ->
    [args...] = arguments
    for arg in args
      for key, value of arg
       obj[key] = arg[key] unless obj[key]?
    obj

  # Flattens a multidimensional array to a one-dimensional array that
  # contains all the elements of all the nested arrays.
  #
  # Hints: Use Array.isArray to check if something is an array
  #
  flatten = (nestedArray, result = []) ->
    for value in nestedArray
      if value instanceof Array then flatten value, result else result.push value
    result

  # Sort the object's values by a criterion produced by an iterator.
  # If iterator is a string, sort objects by that property with the name
  # of that string. For example, _.sortBy(people, 'name') should sort
  # an array of people by their name.
  sortBy = (obj, fn) -> if typeof fn is 'string' then obj.sort((a, b) -> a[fn] - b[fn]) else obj.sort (a, b) -> fn(a) - fn b

  # Zip together two or more arrays with elements of the same index
  # going together.
  #
  # Example:
  # _.zip(['a','b','c','d'], [1,2,3]) returns [['a',1], ['b',2], ['c',3]]
  zip = ->
    [args...] = arguments
    result = []
    for value, i in args[0]
      result[i] = pluck(args, "" + i)
    result

  # Produce an array that contains every item shared between all the
  # passed-in arrays.
  intersection = (array) ->
    [arrays...] = array
    select arrays[0], (value) -> value is value2 for value2 in arrays[1]

  @_ = {
    each: each
    contains: contains
    map: map
    pluck: pluck
    last: last
    first: first
    reduce: reduce
    select: select
    reject: reject
    every: every
    any: any
    uniq: uniq
    once: once
    memoize: memoize
    delay: delay
    extend: extend
    defaults: defaults
    flatten: flatten
    sortBy: sortBy
    zip: zip
    intersection: intersection
  }
    # difference: difference,
    # shuffle: shuffle,
    # chain: chain,
    # throttle: throttle
###







  # Take the difference between one array and a number of other arrays.
  # Only the elements present in just the first array will remain.
  var difference = function(array) {
  };

  # Shuffle an array.
  var shuffle = function(obj) {
  };

  # EXTRA CREDIT:
  # Return an object that responds to chainable function calls for
  # map, pluck, select, etc
  #
  # See README for details
  var chain = function(obj) {
  };

  # EXTRA CREDIT:
  # Returns a function, that, when invoked, will only be triggered at most once
  # during a given window of time.
  #
  # See README for details
  var throttle = function(func, wait) {
  };
###
