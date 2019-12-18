local utils = require('array.utils')

local function convert_to_hash(obj)
  local output = {}

  for i=1, #obj do
    local value = obj[i]
    output[value] = true
  end

  return output
end

local array

array = {
  __VERSION = '1.2.6',
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
  -- @obj {table}
  -- @returns {boolean}
  is_array = function(obj)
    if not utils.is_table(obj) then return false end

    local i = 0
    for _ in pairs(obj) do
      i = i + 1
      if obj[i] == nil then return false end
    end

    return true
  end,

  -- Check if parameter is an empty table
  -- @obj {table}
  -- @returns {boolean}
  is_empty = function(obj)
    return array.is_array(obj) and #obj == 0
  end,

  -- Return a shallow copy of a portion of a table into a new table
  -- @obj {table}
  -- @start {number} start value
  -- @finish {number} end value
  -- @returns {boolean}
  slice = function(obj, start, finish)
    utils.raises_error(array, obj, 'slice')

    if array.is_empty(obj) then return {} end

    local _start = start or 1

    local output = {}
    for i=_start, finish or #obj do
      table.insert(output, obj[i])
    end

    return output
  end,

  -- Return the index at which value can be found or -1 in case value is not present
  -- @obj {table}
  -- @value {*}
  -- @returns {boolean}
  index_of = function(obj, value)
    utils.raises_error(array, obj, 'index_of')

    for i=1, #obj do
      if obj[i] == value then
        return i
      end
    end

    return -1
  end,

  -- Create a new table with reverse values
  -- @obj {table}
  -- @returns {table}
  reverse = function(obj)
    utils.raises_error(array, obj, 'reverse')

    local output = {}

    for i=#obj, 1, -1 do
      table.insert(output, obj[i])
    end

    return output
  end,

  -- Return first element from the table
  -- @obj {table}
  -- @returns {*}
  first = function(obj)
    utils.raises_error(array, obj, 'first')
    return obj[1]
  end,

  -- Return last element from the table
  -- @obj {table}
  -- @returns {*}
  last = function(obj)
    utils.raises_error(array, obj, 'last')
    return obj[#obj]
  end,

  -- Return maximum value from the table
  -- @obj {table}
  -- @returns {*}
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
  -- @obj {table}
  -- @returns {*}
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
  -- @obj {table}
  -- @callback {function}
  -- @returns {*}
  map = function(obj, callback)
    utils.raises_error(array, obj, 'map')

    local output = {}

    for i=1, #obj do
      table.insert(output, callback(obj[i], i))
    end

    return output
  end,

  -- Create a new table containing all elements that pass truth test
  -- @obj {table}
  -- @callback {function}
  -- @returns {*}
  filter = function(obj, callback)
    utils.raises_error(array, obj, 'filter')

    local output = {}

    for i=1, #obj do
      if callback(obj[i], i) then
        table.insert(output, obj[i])
      end
    end

    return output
  end,

  -- Applies a function against an accumulator and each value of the table to reduce it to a single value
  -- @obj {table}
  -- @callback {function}
  -- @memo {*}
  -- @returns {*}
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
  -- @obj {table}
  -- @callback {function}
  -- @memo {*}
  -- @returns {*}
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
  -- @obj {table}
  -- @callback {function}
  -- @returns {number}
  sum = function(obj)
    utils.raises_error(array, obj, 'sum')

    return array.reduce(obj, function(memo, value)
      return memo + value
    end)
  end,

  -- Return a new table joining all values from the two tables passed by parameter
  -- @obj {table}
  -- @obj2 {table}
  -- @returns {table}
  concat = function(obj, obj2)
    utils.raises_error(array, obj, 'concat')
    utils.raises_error(array, obj2, 'concat')

    local output = {}

    for i=1, #obj do
      table.insert(output, obj[i])
    end

    for i=1, #obj2 do
      table.insert(output, obj2[i])
    end

    return output
  end,

  -- Create a new table, removing duplicates values
  -- @obj {table}
  -- @returns {table}
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
  -- @obj {table}
  -- @values {table}
  -- @returns {table}
  without = function(obj, values)
    utils.raises_error(array, obj, 'without')

    local output = {}

    for i=1, #obj do
      if array.index_of(values, obj[i]) == -1 then
        table.insert(output, obj[i])
      end
    end

    return output
  end,

  -- Tests if at least one element in the table passes the test implemented by the callback
  -- @obj {table}
  -- @callback {function}
  -- @returns {boolean}
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
  -- @obj {table}
  -- @obj2 {table}
  -- @returns {table}
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

  -- Return a table of the two supplied by pairing up equally-positioned elements from both tables
  -- @obj {table}
  -- @obj2 {table}
  -- @returns {table}
  every = function(obj, callback)
    utils.raises_error(array, obj, 'every')

    for i=1, #obj do
      if not callback(obj[i], i) then
        return false
      end
    end

    return true
  end,

  -- Returns a shallow copy of the table passed as parameter
  -- @obj {table}
  -- @returns {table}
  shallow_copy = function(obj)
    utils.raises_error(array, obj, 'shallow_copy')

    local output = {}

    for i=1, #obj do
      table.insert(output, obj[i])
    end

    return output
  end,

  -- Return a deep copy of the table passed as parameter
  -- @value {*}
  -- @returns {table}
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
  -- @obj {table}
  -- @obj2 {table}
  -- @returns {table}
  diff = function(obj1, obj2)
    utils.raises_error(array, obj1, 'diff')
    utils.raises_error(array, obj2, 'diff')

    local output = {}
    local hash = convert_to_hash(obj2)

    for i=1, #obj1 do
      local value = obj1[i]

      if not hash[value] then
        table.insert(output, value)
      end
    end

    return output
  end,

  -- Create a new table with the sub-table elements concatenated into it
  -- @obj {table}
  -- @_memo {table}
  -- @returns {table}
  flat = function(obj, _memo)
    local output = _memo or {}

    for i=1, #obj do
      local value = obj[i]

      if utils.is_table(value) then
        array.flat(value, output)
      else
        table.insert(output, value)
      end
    end

    return output
  end,

  -- Creates a table filling all the elements from a start index (default one) to an end index with a default value
  -- @value {*}
  -- @start_or_finish {number}
  -- @finish {number}
  -- @returns {table}
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

  -- Remove all elements from table that @callback returns thruthy for
  -- and returns a new table with the removed items
  -- @obj {table}
  -- @callback {function}
  -- @returns {@table}
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

  -- Returns a new table in hash structure, where keys represent each array value
  -- and value represent the number of times the same item was found in the list
  -- @obj {table}
  -- @returns {@table}
  counter = function(obj)
    local output = {}

    for i=1, #obj do
      local value = obj[i]
      output[value] = (output[value] and output[value] or 0) + 1
    end

    return output
  end,

  -- Returns a new table with the values that exist in both tables
  -- @obj1 {table}
  -- obj2 {table}
  -- @returns {@table}
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

  from_pairs = function(obj)
    utils.raises_error(array, obj, 'from_pairs')

    local output = {}

    for i=1, #obj do
      local item = obj[i]
      output[item[1]] = item[2]
    end

    return output
  end
}

return array
