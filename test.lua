package.path = "./src/?.lua;" .. package.path

local array = require './src/array'
local test = require 'simple_test'

test('meta infos', function(a)
  a.equal(array.__VERSION, '1.3.1')
  a.equal(array.__DESCRIPTION,
  "A small library with useful methods to handle Lua's table when it's working like an Array")
end)

test('is_array should return false when object is not a table', function(a)
  a.equal(array.is_array('lua'), false)
end)

test('is_array should return false when the table is working like a dictionary', function(a)
  a.equal(array.is_array({ language='lua' }), false)
end)

test('is_array should return true when table is empty', function(a)
  a.equal(array.is_array({}), true)
end)

test('is_array should return true when table is working like an array', function(a)
  a.equal(array.is_array({ 'a', 'b', 'c', 'd' }), true)
end)

test('is_empty should return false when table has at least one item', function(a)
  a.equal(array.is_empty({ 'a' }), false)
end)

test('is_empty should return false when table does not have any item', function(a)
  a.equal(array.is_empty({}), true)
end)

test('first should return first item from table', function(a)
  a.equal(array.first({ 'a', 'b', 'c', 'd' }), 'a')
end)

test('last should return last item from table', function(a)
  a.equal(array.last({ 'a', 'b', 'c', 'd' }), 'd')
end)

test('slice should return an empty table when it does not have any element', function(a)
  a.equal(#array.slice({}, 1, 2), 0)
end)

test('slice should return a table with values between start index and end index', function(a)
  local result = array.slice({ 'lua', 'javascript', 'python', 'ruby', 'c' }, 2, 4)

  a.equal(type(result), 'table')
  a.equal(#result, 3)
  a.equal(result[1], 'javascript')
  a.equal(result[2], 'python')
  a.equal(result[3], 'ruby')
end)

test('slice should return a table with every values from start index until last index', function(a)
  local result = array.slice({ 'lua', 'javascript', 'python', 'ruby', 'c' }, 2)

  a.equal(type(result), 'table')
  a.equal(#result, 4)
  a.equal(result[1], 'javascript')
  a.equal(result[2], 'python')
  a.equal(result[3], 'ruby')
  a.equal(result[4], 'c')
end)

test('reverse should return an inverted table', function(a)
  local result = array.reverse({ 'lua', 'javascript', 'python' })

  a.equal(type(result), 'table')
  a.equal(#result, 3)
  a.equal(result[1], 'python')
  a.equal(result[2], 'javascript')
  a.equal(result[3], 'lua')
end)

test('map should return a table with 2, 4, 6 values', function(a)
  local result = array.map({ 1, 2, 3 }, function(value)
    return value * 2
  end)

  a.equal(type(result), 'table')
  a.equal(#result, 3)
  a.equal(result[1], 2)
  a.equal(result[2], 4)
  a.equal(result[3], 6)
end)

test('filter should return a table with 10, 15, 20 values', function(a)
  local result = array.filter({ 15, 10, 5, 3, 20 }, function(value)
    return value >= 10
  end)

  a.equal(type(result), 'table')
  a.equal(#result, 3)
  a.equal(result[1], 15)
  a.equal(result[2], 10)
  a.equal(result[3], 20)
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
  local result = array.reduce({ 20, 30, 40 }, function(memo, value)
    return memo + value
  end)

  a.equal(result, 90)
end)

test('reduce should return 100', function(a)
  local result = array.reduce({ 20, 30, 40 }, function(memo, value)
    return memo + value
  end, 10)

  a.equal(result, 100)
end)

test('reduce should return first item', function(a)
  local result = array.reduce({ 20 }, function(memo, value)
    return memo + value
  end)

  a.equal(result, 20)
end)

test('reduce should concatenate all items', function(a)
  local result = array.reduce({ 'a', 'b', 'c', 'd', 'e' }, function(memo, value)
    return memo .. value
  end)

  a.equal(result, 'abcde')
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

  local result = array.shallow_copy(obj)

  a.equal(#result, #obj)
  a.equal(result[1][1], obj[1][1])
  a.equal(result[2][1], obj[2][1])

  obj[1][1] = 'c'
  a.equal(result[1][1], obj[1][1])

  obj[1] = 'c'
  a.equal(type(result[1]), 'table')
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
  local obj = { 'a', 'b', 'c', { 'd', 'e', 'f', { 'g', 'h' } }, { 'i' }, 'j' }
  local result = array.flat(obj)

  a.equal(#result, 10)
end)

test('fill', function(a)
  local value = 'a'
  local start = 3
  local finish = 4
  local result = array.fill(value, start, finish)
  a.equal(result[1], nil)
  a.equal(result[2], nil)
  a.equal(result[3], value)
  a.equal(result[4], value)

  local size = 3
  local result2 = array.fill(value, size)
  a.equal(#result2, size)
  a.equal(result2[1], value)
  a.equal(result2[2], value)
  a.equal(result2[3], value)
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
  local result = array.intersect(first_list, second_list)

  a.equal(#result, 3)
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
