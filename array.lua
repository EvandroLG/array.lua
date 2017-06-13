-- array
-- author: Evandro Leopoldino Gonçalves <evandrolgoncalves@gmail.com>
-- https://github.com/evandrolg
-- License: MIT

local function is_table(obj)
  return type(obj) == 'table'
end

local function raises_error(obj, param, method)
  assert(obj.is_array(param), string.format('%s expects an array', method))
end

local array

array = {
  __VERSION = '1.2.1',
  __DESCRIPTION = "A small library with useful methods to handle Lua's table when it's working like an Array",
  __LICENCE = [[
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

  is_array = function(obj)
    if not is_table(obj) then return false end

    local i = 0
    for _ in pairs(obj) do
      i = i + 1
      if obj[i] == nil then return false end
    end

    return true
  end,

  is_empty = function(obj)
    return array.is_array(obj) and #obj == 0
  end,

  slice = function(obj, start, finish)
    raises_error(array, obj, 'slice')

    if array.is_empty(obj) then return {} end

    local output = {}
    for i=start, finish or #obj do
      table.insert(output, obj[i])
    end

    return output
  end,

  index_of = function(obj, value)
    raises_error(array, obj, 'index_of')

    for i=1, #obj do
      if obj[i] == value then
        return i
      end
    end

    return -1
  end,

  reverse = function(obj)
    raises_error(array, obj, 'reverse')

    local output = {}

    for i=#obj, 1, -1 do
      table.insert(output, obj[i])
    end

    return output
  end,

  first = function(obj)
    raises_error(array, obj, 'first')
    return obj[1]
  end,

  last = function(obj)
    raises_error(array, obj, 'last')
    return obj[#obj]
  end,

  max = function(obj)
    raises_error(array, obj, 'max')

    local max = obj[1]

    for i=2, #obj do
      if obj[i] > max then
        max = obj[i]
      end
    end

    return max
  end,

  min = function(obj)
    raises_error(array, obj, 'min')

    local min = obj[1]

    for i=2, #obj do
      if obj[i] < min then
        min = obj[i]
      end
    end

    return min
  end,

  map = function(obj, callback)
    raises_error(array, obj, 'map')

    local output = {}

    for i=1, #obj do
      table.insert(output, callback(obj[i], i))
    end

    return output
  end,

  filter = function(obj, callback)
    raises_error(array, obj, 'filter')

    local output = {}

    for i=1, #obj do
      if callback(obj[i], i) then
        table.insert(output, obj[i])
      end
    end

    return output
  end,

  reduce = function(obj, callback, memo)
    raises_error(array, obj, 'reduce')

    local _memo = memo or 0

    for i=1, #obj do
      _memo = callback(_memo, obj[i], i)
    end

    return _memo
  end,

  concat = function(obj, obj2)
    raises_error(array, obj, 'concat')
    raises_error(array, obj2, 'concat')

    for i=1, #obj2 do
      table.insert(obj, obj2[i])
    end

    return obj
  end,

  uniq = function(obj)
    raises_error(array, obj, 'uniq')

    local output = {}

    for i=1, #obj do
      if array.index_of(output, obj[i]) == -1 then
        table.insert(output, obj[i])
      end
    end

    return output
  end,

  without = function(obj, values)
    raises_error(array, obj, 'without')

    local output = {}

    for i=1, #obj do
      if array.index_of(values, obj[i]) == -1 then
        table.insert(output, obj[i])
      end
    end

    return output
  end
}

return array
