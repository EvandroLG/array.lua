local utils = require('array.utils')

local array

array = {
  __VERSION = '1.3.6',
  __DESCRIPTION = "A small library with useful methods to handle Lua's table when it's working like an Array",
  __LICENSE = [[
    The MIT License (MIT)
    Copyright (c) 2017 Evandro Leopoldino Gonçalves
    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:
    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
  ]],

  -- Verify if table object works as an array
  -- @param obj {table}
  -- @return {boolean}
  is_array = function(obj)
    if not utils.is_table(obj) then return false end

    local i = 0
    for _ in pairs(obj) do
      i = i + 1
      if obj[i] == nil then return false end
    end

    return true
  end,

  -- Checks if parameter is an empty table
  -- @param obj {table}
  -- @return {boolean}
  is_empty = function(obj)
    return array.is_array(obj) and #obj == 0
  end,

  -- Returns a shallow copy of a portion of a table into a new table
  -- @param obj {table}
  -- @param start {number} start value
  -- @param finish {number} end value
  -- @return {boolean}
  slice = function(obj, start, finish)
    utils.raises_error(array, obj, 'slice')

    if array.is_empty(obj) or start == finish then return {} end

    local output = {}
    local _finish = #obj
    local _start = 1

    if start >= 0 then
      _start = start
    elseif utils.is_nil(finish) and start < 0 then
      _start = #obj + start + 1
    end

    if (finish and finish >= 0) then
      _finish = finish - 1
    elseif finish and finish < 0 then
      _finish = #obj + finish
    end

    for i = _start, _finish do
      table.insert(output, obj[i])
    end

    return output
  end,

  -- Returns the index at which value can be found or -1 in case value is not present
  -- @param obj {table}
  -- @param value {*}
  -- @return {number}
  index_of = function(obj, value)
    utils.raises_error(array, obj, 'index_of')

    for i=1, #obj do
      if obj[i] == value then
        return i
      end
    end

    return -1
  end,

  -- Return true whether table includes the values, otherwise it returns false
  -- @param obj {table}
  -- @param value {*}
  -- @return {boolean}
  includes = function(obj, value)
    utils.raises_error(array, obj, 'includes')

    local index = array.index_of(obj, value)

    if index == -1 then return false end
    return true
  end,

  -- Create a new table with reverse values
  -- @param obj {table}
  -- @return {table}
  reverse = function(obj)
    utils.raises_error(array, obj, 'reverse')

    local output = {}

    for i=#obj, 1, -1 do
      table.insert(output, obj[i])
    end

    return output
  end,

  -- Return first element from the table
  -- @param obj {table}
  -- @return {*}
  first = function(obj)
    utils.raises_error(array, obj, 'first')
    return obj[1]
  end,

  -- Return last element from the table
  -- @param obj {table}
  -- @return {*}
  last = function(obj)
    utils.raises_error(array, obj, 'last')
    return obj[#obj]
  end,

  -- Return maximum value from the table
  -- @param obj {table}
  -- @return {*}
  max = function(obj)
    utils.raises_error(array, obj, 'max')

    local max = obj[1]

    for i=2, #obj do
      if obj[i] > max then
        max = obj[i]
      end
    end

    return max
  end,

  -- Return minimum value from the table
  -- @param obj {table}
  -- @return {*}
  min = function(obj)
    utils.raises_error(array, obj, 'min')

    local min = obj[1]

    for i=2, #obj do
      if obj[i] < min then
        min = obj[i]
      end
    end

    return min
  end,

  -- Create a new table of values by mapping each value in table through a transformation function
  -- @param obj {table}
  -- @param callback {function}
  -- @return {*}
  map = function(obj, callback)
    utils.raises_error(array, obj, 'map')

    local initial_value = {}
    local reducer = function(accumulator, current, i)
      table.insert(accumulator, callback(current, i))
      return accumulator
    end

    return array.reduce(obj, reducer, initial_value)
  end,

  -- Create a new table containing all elements that pass truth test
  -- @param obj {table}
  -- @param callback {function}
  -- @return {*}
  filter = function(obj, callback)
    utils.raises_error(array, obj, 'filter')

    local initial_value = {}
    local reducer = function(accumulator, current)
      if callback(current) then
        table.insert(accumulator, current)
      end

      return accumulator
    end

    return array.reduce(obj, reducer, initial_value)
  end,

  -- Applies a function against an accumulator and each value of the table to reduce it to a single value
  -- @param obj {table}
  -- @param callback {function}
  -- @param memo {table}
  -- @return {*}
  reduce = function(obj, callback, memo)
    utils.raises_error(array, obj, 'reduce')

    local initialIndex = 1
    local _memo = memo

    if _memo == nil then
      initialIndex = 2
      _memo = obj[1]
    end

    for i=initialIndex, #obj do
      _memo = callback(_memo, obj[i], i)
    end

    return _memo
  end,

  -- This function is like reduce except that it interates over table's elements from right to left
  -- @param obj {table}
  -- @param callback {function}
  -- @param memo {table}
  -- @return {*}
  reduce_right = function(obj, callback, memo)
    utils.raises_error(array, obj, 'reduce_right')

    local initialIndex = #obj
    local _memo = memo

    if _memo == nil then
      initialIndex = initialIndex - 1
      _memo = obj[#obj]
    end

    for i=initialIndex, 1, -1 do
      _memo = callback(_memo, obj[i], i)
    end

    return _memo
  end,

  -- Return the sum of the values in table
  -- @param obj {table}
  -- @param callback {function}
  -- @return {number}
  sum = function(obj)
    utils.raises_error(array, obj, 'sum')

    return array.reduce(obj, function(memo, value)
      return memo + value
    end)
  end,

  -- Return a new table joining all values from N tables passed by parameter
  -- @param arg {...}
  -- @return {table}
  concat = function(...)
    local arg = {...}
    local output = {}

    for i, list in ipairs(arg) do
      for j=1, #list do
        table.insert(output, list[j])
      end
    end

    return output
  end,

  -- Create a new table, removing duplicates values
  -- @param obj {table}
  -- @return {table}
  uniq = function(obj)
    utils.raises_error(array, obj, 'uniq')

    local output = {}
    local seen = {}

    for i=1, #obj do
      local value = obj[i]
      if not seen[value] then
        seen[value] = true
        table.insert(output, value)
      end
    end

    return output
  end,

  -- Return a copy of the table with all instances of the values removed
  -- @param obj {table}
  -- @param values {table}
  -- @return {table}
  without = function(obj, values)
    utils.raises_error(array, obj, 'without')

    local initial_value = {}
    local reducer = function(accumulator, current)
      if (array.includes(values, current) == false) then
        table.insert(accumulator, current)
      end

      return accumulator
    end

    return array.reduce(obj, reducer, initial_value)
  end,

  -- Tests if at least one element in the table passes the test implemented by the callback
  -- @param obj {table}
  -- @param callback {function}
  -- @return {boolean}
  some = function(obj, callback)
    utils.raises_error(array, obj, 'some')

    for i=1, #obj do
      if callback(obj[i], i) then
        return true
      end
    end

    return false
  end,

  -- Return a table of the two supplied by pairing up equally-positioned elements from both tables
  -- @param obj {table}
  -- @param obj2 {table}
  -- @return {table}
  zip = function(obj1, obj2)
    utils.raises_error(array, obj1, 'zip')
    utils.raises_error(array, obj2, 'zip')

    local output = {}
    local size = #obj1 > #obj2 and #obj2 or #obj1

    for i=1, size do
      table.insert(output, { obj1[i], obj2[i] })
    end

    return output
  end,

  -- Run a predicate on each value. If the predicate evaluates to any false value, this function will immediately return false; otherwise, it returns true.
  -- @param obj {table}
  -- @param callback {function}
  -- @return {boolean}
  every = function(obj, callback)
    utils.raises_error(array, obj, 'every')

    for i=1, #obj do
      if not callback(obj[i], i) then
        return false
      end
    end

    return true
  end,

  -- return a shallow copy of the table passed as parameter
  -- @param obj {table}
  -- @return {table}
  shallow_copy = function(obj)
    utils.raises_error(array, obj, 'shallow_copy')

    local output = {}

    for i=1, #obj do
      table.insert(output, obj[i])
    end

    return output
  end,

  -- Return a deep copy of the table passed as parameter
  -- @param value {*}
  -- @return {table}
  deep_copy = function(value)
    local output = value

    if utils.is_table(value) then
      output = {}

      for i=1, #value do
        table.insert(output, array.deep_copy(value[i]))
      end
    end

    return output
  end,

  -- Return a new table with the items which exist only in the first table
  -- @param obj {table}
  -- @param obj2 {table}
  -- @return {table}
  diff = function(obj1, obj2)
    utils.raises_error(array, obj1, 'diff')
    utils.raises_error(array, obj2, 'diff')

    local output = {}
    local hash = utils.convert_to_hash(obj2)

    for i=1, #obj1 do
      local value = obj1[i]

      if not hash[value] then
        table.insert(output, value)
      end
    end

    return output
  end,

  -- Create a new table with the sub-table elements concatenated into it up to the specific depth
  -- @param obj {table, depth}
  -- @return {table}
  flat = function(obj, depth)
    if depth == nil then
      depth = 1 / 0 -- Infinity
    end
    
    return array.reduce(obj, function(acc, item)
      if array.is_array(item) and depth > 0 then
        return array.concat(
          acc,
          array.flat(item, depth - 1)
        )
      else
        table.insert(acc, item)
        return acc
      end
    end, {});
  end,

  -- Creates a table filling all the elements from a start index (default one) to an end index with a default value
  -- @param value {*}
  -- @param start_or_finish {number}
  -- @param finish {number}
  -- @return {table}
  fill = function(value, start_or_finish, finish)
    local output = {}
    local item = value
    local start = start_or_finish
    local size = finish

    if finish == nil then
      start = 1
      size = start_or_finish
    end

    for i=start, size do
      output[i] = item
    end

    return output
  end,

  -- Remove all elements from table that @callback return thruthy for
  -- and return a new table with the removed items
  -- @param obj {table}
  -- @param callback {function}
  -- @return {table}
  remove = function(obj, callback)
    local output = {}
    local copy = array.deep_copy(obj)

    for i=1, #copy do
      local value = copy[i]

      if callback(value, i) then
        table.insert(output, value)
        local index = array.index_of(obj, value)
        table.remove(obj, index)
      end
    end

    return output
  end,

  -- Return a new table in hash structure, where keys represent each array value
  -- and value represent the number of times the same item was found in the list
  -- @param obj {table}
  -- @return {table}
  counter = function(obj)
    local output = {}

    for i=1, #obj do
      local value = obj[i]
      output[value] = (output[value] and output[value] or 0) + 1
    end

    return output
  end,

  -- Return a new table with the values that exist in both tables
  -- @param obj1 {table}
  -- @param obj2 {table}
  -- @return {table}
  intersect = function(obj1, obj2)
    local output = {}
    local count1 = array.counter(obj1)
    local count2 = array.counter(obj2)

    for k, v in pairs(count1) do
      if count2[k] then
        local new_array = array.fill(
          k,
          utils.lowest_value(v, count2[k])
        )

        utils.multiple_inserts(output, new_array)
      end
    end

    return output
  end,

  -- Return a table composed from key-value pairs
  -- @param obj1 {table}
  -- @param obj2 {table}
  -- @return {table}
  from_pairs = function(obj)
    utils.raises_error(array, obj, 'from_pairs')

    local output = {}

    for i=1, #obj do
      local item = obj[i]
      output[item[1]] = item[2]
    end

    return output
  end,

  -- Executes callback once for each table element
  -- @param obj {table}
  -- @param callback {function}
  -- @return {void}
  each = function(obj, callback)
    for i=1, #obj do
      callback(obj[i], i)
    end
  end,

  -- Executes callback once for each table element in reverse order
  -- @param obj {table}
  -- @param callback {function}
  -- @return {void}
  reverse_each = function(obj, callback)
    for i = #obj, 1, -1 do
      callback(obj[i], i)
    end
  end,

  -- Returns a new table composed by keys created from the results of running each element through `callback`
  -- @param obj {table}
  -- @param callback {function}
  -- @return {table}
  group_by = function(obj, callback)
    utils.raises_error(array, obj, 'group_by')

    function reducer(accumulator, current)
      local result = callback(current)
      if not accumulator[result] then
        accumulator[result] = {}
      end

      table.insert(accumulator[result], current)

      return accumulator
    end

    return array.reduce(obj, reducer, {})
  end,

  -- Returns a value from a random key of the given array
  -- @param obj {table}
  -- @return {*}
  random = function(obj)
    utils.raises_error(array, obj, 'random')
    return obj[math.random(#obj)]
  end,

  -- Creates a new table returning all permutations of length of the elements of the given table
  -- @param obj {table}
  -- @return {table}
  permutation = function(obj)
    local output = {}

    if #obj == 1 then
      return { obj }
    end

    local partial_permutations = array.permutation(array.slice(obj, 2))
    local first = obj[1]

    for i=1, #partial_permutations do
      local partial = partial_permutations[i]

      for j=1, #partial+1 do
        local permutation_front = array.slice(partial, 1, j)
        local permutation_after = array.slice(partial, j)

        table.insert(output, array.concat(permutation_front, { first }, permutation_after))
      end
    end

    return output
  end,

  -- Returns a new array-like table with elements splitted into groups of length of `size`
  -- @param obj {table}
  -- @param size {number}
  -- @return {table}
  chunk = function(obj, size)
    local output = {}

    for _, v in pairs(obj) do
      local last = output[#output]

      if utils.is_nil(last) or #last == size then
        table.insert(output, { v })
      else
        table.insert(last, v)
      end
    end

    return output
  end,

  -- Returns a new array-like table by applying a given callback to each element of the table, and then flattening the result by one level
  -- @param obj {table}
  -- @param callback {function}
  -- @return {table}
  flat_map = function(obj, callback)
    utils.raises_error(array, obj, 'flat_map')
    local mapped = array.map(obj, callback)

    return array.flat(mapped)
  end,

  -- Creates a new table composed of keys generated from the results of running each element of the given table through the given callback
  -- @param obj {table}
  -- @param callback {function}
  -- @return {table}
  key_by = function(obj, callback)
    utils.raises_error(array, obj, 'key_by')

    return array.reduce(obj, function(accumulator, current)
      local key = callback(current)
      accumulator[key] = current
      return accumulator
    end, {})
  end
}

return array
