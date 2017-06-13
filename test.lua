local array = require 'array'

do
  local format = string.format
  function test(name, callback)
    xpcall(function()
      callback()
      print(format('[pass] %s', name))
    end, function(err)
      print(format('[fail] %s : %s', name, err))
    end)
  end
end

function assert_equal(a, b)
  assert(a == b)
end

test('meta infos', function()
  assert_equal(array.__VERSION, '1.2.0')
  assert_equal(array.__DESCRIPTION,
  "A small library with useful methods to handle Lua's table when it's working like an Array")
end)

test('is_array should returns false when object is not a table', function()
  assert_equal(array.is_array('lua'), false)
end)

test('is_array should returns false when the table is working like a dictionary', function()
  assert_equal(array.is_array({ language='lua' }), false)
end)

test('is_array should returns true when table is empty', function()
  assert_equal(array.is_array({}), true)
end)

test('is_array should returns true when table is working like an array', function()
  assert_equal(array.is_array({ 'a', 'b', 'c', 'd' }), true)
end)

test('is_empty should returns false when table has at least one item', function()
  assert_equal(array.is_empty({ 'a' }), false)
end)

test('is_empty should returns false when table does not have any item', function()
  assert_equal(array.is_empty({}), true)
end)

test('first should returns first item from table', function()
  assert_equal(array.first({ 'a', 'b', 'c', 'd' }), 'a')
end)

test('last should returns last item from table', function()
  assert_equal(array.last({ 'a', 'b', 'c', 'd' }), 'd')
end)

test('slice should returns a empty table when it does not have any element', function()
  assert_equal(#array.slice({}, 1, 2), 0)
end)

test('slice should returns a table with values between start index and end index', function()
local result = array.slice({ 'lua', 'javascript', 'python', 'ruby', 'c' }, 2, 4)

assert_equal(type(result), 'table')
assert_equal(#result, 3)
assert_equal(result[1], 'javascript')
assert_equal(result[2], 'python')
assert_equal(result[3], 'ruby')
end)

test('slice should returns a table with every values from start index until last index', function()
local result = array.slice({ 'lua', 'javascript', 'python', 'ruby', 'c' }, 2)

assert_equal(type(result), 'table')
assert_equal(#result, 4)
assert_equal(result[1], 'javascript')
assert_equal(result[2], 'python')
assert_equal(result[3], 'ruby')
assert_equal(result[4], 'c')
end)

test('reverse should returns an inverted table', function()
  local result = array.reverse({ 'lua', 'javascript', 'python' })

  assert_equal(type(result), 'table')
  assert_equal(#result, 3)
  assert_equal(result[1], 'python')
  assert_equal(result[2], 'javascript')
  assert_equal(result[3], 'lua')
end)

test('map should returns a table with 2, 4, 6 values', function()
  local result = array.map({ 1, 2, 3 }, function(value)
    return value * 2
  end)

  assert_equal(type(result), 'table')
  assert_equal(#result, 3)
  assert_equal(result[1], 2)
  assert_equal(result[2], 4)
  assert_equal(result[3], 6)
end)

test('filter should returns a table with 10, 15, 20 values', function()
  local result = array.filter({ 15, 10, 5, 3, 20 }, function(value)
    return value >= 10
  end)

  assert_equal(type(result), 'table')
  assert_equal(#result, 3)
  assert_equal(result[1], 15)
  assert_equal(result[2], 10)
  assert_equal(result[3], 20)
end)

test('max should returns the biggest value from a table', function()
  assert_equal(array.max({ 20, 22, 1, 3, 30, 42 }), 42)
end)

test('max should returns nil when table is empty', function()
  assert_equal(array.max({}), nil)
end)

test('min should returns the smallest value from a table', function()
  assert_equal(array.min({ 20, 22, 1, 3, 30, 42 }), 1)
end)

test('min should returns nil when table is empty', function()
  assert_equal(array.min({}), nil)
end)

test('reduce should returns 90', function()
  local result = array.reduce({ 20, 30, 40 }, function(memo, value)
    return memo + value
  end)

  assert_equal(result, 90)
end)

test('reduce should returns 100', function()
  local result = array.reduce({ 20, 30, 40 }, function(memo, value)
    return memo + value
  end, 10)

  assert_equal(result, 100)
end)

test('index_of should returns correct position of value in the table', function()
  assert_equal(array.index_of({ 20, 30, 40, 50 }, 40), 3)
end)

test('index_of should returns -1 when the value is not in the table', function()
  assert_equal(array.index_of({ 20, 30, 40 }, 50), -1)
end)

test('concat should joins the two array', function()
  local result = array.concat({ 1, 2, 3 }, { 4, 5, 6 })

  assert_equal(#result, 6)
  assert_equal(result[4], 4)
end)

test('uniq should returns every value once', function()
  local result = array.uniq({ 'a', 'b', 'a', 'b', 'c', 'd' })

  assert_equal(#result, 4)
  assert_equal(result[1], 'a')
  assert_equal(result[2], 'b')
  assert_equal(result[3], 'c')
  assert_equal(result[4], 'd')
end)

test('without should returns all values less the items from second array', function()
  local result = array.without({ 10, 20, 30, 10, 4 }, { 10, 4 })

  assert_equal(#result, 2)
  assert_equal(result[1], 20)
  assert_equal(result[2], 30)
end)
