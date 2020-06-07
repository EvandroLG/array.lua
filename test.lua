package.path = "./src/?.lua;" .. package.path

local array = require './src/array'
local test = require 'simple_test'

test('meta infos', function(a)
  a.equal(array.__VERSION, '1.3.1')
  a.equal(array.__DESCRIPTION,
  "A small library with useful methods to handle Lua's table when it's working like an Array")
end)

test('is_array', function(a)
  a.not_ok(array.is_array('lua'))
  a.not_ok(array.is_array({ language='lua' }))
  a.ok(array.is_array({}))
  a.ok(array.is_array({ 'a', 'b', 'c', 'd' }))
end)

test('is_empty', function(a)
  a.not_ok(array.is_empty({ 'a' }))
  a.ok(array.is_empty({}))
end)

test('first', function(a)
  a.equal(array.first({ 'a', 'b', 'c', 'd' }), 'a')
end)

test('last', function(a)
  a.equal(array.last({ 'a', 'b', 'c', 'd' }), 'd')
end)

test('slice', function(a)
  a.equal(#array.slice({}, 1, 2), 0)

  a.deep_equal(
    array.slice({ 'lua', 'javascript', 'python', 'ruby', 'c' }, 2, 4),
    { 'javascript', 'python', 'ruby' }
  )

  a.deep_equal(
    array.slice({ 'lua', 'javascript', 'python', 'ruby', 'c' }, 2),
    { 'javascript', 'python', 'ruby', 'c' }
  )
end)

test('reverse', function(a)
  a.deep_equal(
    array.reverse({ 'lua', 'javascript', 'python' }),
    { 'python', 'javascript', 'lua' }
  )
end)

test('map should return a table with 2, 4, 6 values', function(a)
  a.deep_equal(
    array.map({ 1, 2, 3 }, function(value)
      return value * 2
    end),
    { 2, 4, 6 }
  )
end)

test('filter should return a table with 10, 15, 20 values', function(a)
  a.deep_equal(
    array.filter({ 15, 10, 5, 3, 20 }, function(value)
      return value >= 10
    end),
    { 15, 10, 20 }
  )
end)

test('max should return the biggest value from a table', function(a)
  a.equal(array.max({ 20, 22, 1, 3, 30, 42 }), 42)
end)

test('max should return nil when table is empty', function(a)
  a.equal(array.max({}), nil)
end)

test('min should return the smallest value from a table', function(a)
  a.equal(array.min({ 20, 22, 1, 3, 30, 42 }), 1)
end)

test('min should return nil when table is empty', function(a)
  a.equal(array.min({}), nil)
end)

test('reduce should return 90', function(a)
  a.equal(
    array.reduce({ 20, 30, 40 }, function(memo, value)
      return memo + value
    end),
    90
  )
end)

test('reduce should return 100', function(a)
  a.equal(
    array.reduce({ 20, 30, 40 }, function(memo, value)
      return memo + value
    end, 10), 
  100)
end)

test('reduce should return first item', function(a)
  local result = 

  a.equal(
    array.reduce({ 20 }, function(memo, value)
      return memo + value
    end),
  20)
end)

test('reduce should concatenate all items', function(a)
  a.equal(
    array.reduce({ 'a', 'b', 'c', 'd', 'e' }, function(memo, value)
      return memo .. value
    end),
    'abcde'
  )
end)

test('reduce_right', function(a)
  a.equal(
    array.reduce_right({ 20, 30, 40 }, function(memo, value)
      return memo + value
    end),
    90
  )

  a.equal(
    array.reduce_right({ 'a', 'b', 'c', 'd', 'e' }, function(memo, value)
      return memo .. value
    end),
    'edcba'
  )
end)

test('sum', function(a)
  a.equal(
    array.sum({10, 20, 30, 40, 50}),
    150
  )
end)

test('index_of', function(a)
  a.equal(
    array.index_of({ 20, 30, 40, 50 }, 40),
    3
  )

  a.equal(
    array.index_of({ 20, 30, 40 }, 50),
    -1
  )
end)

test('concat', function(a)
  a.deep_equal(
    array.concat({ 1, 2, 3 }, { 4, 5, 6 }),
    { 1, 2, 3, 4, 5, 6 }
  )
end)

test('uniq', function(a)
  a.deep_equal(
    array.uniq({ 'a', 'b', 'a', 'b', 'c', 'd' }),
    { 'a', 'b', 'c', 'd' }
  )
end)

test('without', function(a)
  a.deep_equal(
    array.without({ 10, 20, 30, 10, 4 }, { 10, 4 }),
    { 20, 30 }
  )
end)

test('some', function(a)
  a.ok(
    array.some({'a', 'b', 'c'}, function(element)
      if (element == 'b') then return true end
    end)
  )

  a.not_ok(
    array.some({'a', 'b', 'c'}, function(element)
      if (element == 'd') then return true end
    end)
  )
end)

test('zip', function(a)
  a.deep_equal(
    array.zip({ 'a', 'b' }, { 'A', 'B', 'C' }),
    {
      { 'a', 'A' },
      { 'b', 'B' }
    }
  )

  a.deep_equal(
    array.zip({ 'a', 'b' }, { 'A', 'B' }),
    {
      { 'a', 'A' },
      { 'b', 'B' }
    }
  )
end)

test('every', function(a)
  a.not_ok(
    array.every({ 10, 20, 30 }, function(value)
      return value > 10
    end)
  )

  a.ok(
    array.every({ 10, 20, 30 }, function(value)
      return value >= 10
    end)
  )
end)

test('shallow_copy', function(a)
  local obj = {
    { 'a' },
    { 'b' }
  }

  a.deep_equal(
    array.shallow_copy(obj),
    obj
  )
end)

test('deep_copy', function(a)
  local obj = {
    { 'a' },
    { 'b' }
  }

  local result = array.deep_copy(obj)

  a.equal(#result, #obj)
  a.equal(result[1][1], obj[1][1])
  a.equal(result[2][1], obj[2][1])

  obj[1][1] = 'c'
  a.equal(result[1][1], 'a')

  obj[1] = 'c'
  a.equal(type(result[1]), 'table')
end)

test('diff', function(a)
  local result = array.diff(
    { 'a', 'b', 'g', 'z', 'h' },
    { 'a', 'c', 'd', 'e', 'f', 'h', 'x' }
  )

  a.deep_equal(result, { 'b', 'g', 'z' })
end)

test('flat', function(a)
  a.deep_equal(
    array.flat({ 'a', 'b', 'c', { 'd', 'e', 'f', { 'g', 'h' } }, { 'i' }, 'j' }),
    { 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j' }
  )
end)

test('fill', function(a)
  local value = 'Lua'
  local result = array.fill(value, 3, 4)
  a.equal(result[3], value)
  a.equal(result[4], value)

  a.deep_equal(
    array.fill(value, 3),
    { value, value, value }
  )
end)

test('remove', function(a)
  local list = { 1, 2, 3, 4 }
  local result = array.remove(list, function(value)
    return math.fmod(value, 2) == 0
  end)

  a.deep_equal(
    list,
    { 1, 3 }
  )

  a.deep_equal(
    result,
    { 2, 4 }
  )
end)

test('counter', function(a)
  a.deep_equal(
    array.counter({ 'a', 'b', 'a', 'a', 'c', 'b' }),
    { a = 3, b = 2, c = 1 }
  )
end)

test('intersect', function(a)
  local first_list = { 'a', 'b', 'a', 'c', 'e', 'f', 'a' }
  local second_list = { 'b', 'a', 'd', 'a' }

  a.equal(
    #array.intersect(first_list, second_list),
    3
  )
end)

test('from_pairs', function(a)
  a.deep_equal(
    array.from_pairs({ {'a', 1}, {'b', 2} }),
    { a = 1, b = 2 }
  )
end)

test('includes', function(a)
  local list = { 'a', 'b', 'c' }

  a.ok(
    array.includes(list, 'c')
  )

  a.not_ok(
    array.includes(list, 'd')
  )
end)
