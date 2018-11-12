local array = require 'array'
local test = require 'simple_test'

test('meta infos', function(a)
  a.equal(array.__VERSION, '1.2.1')
  a.equal(array.__DESCRIPTION,
  "A small library with useful methods to handle Lua's table when it's working like an Array")
end)

test('is_array should returns false when object is not a table', function(a)
  a.equal(array.is_array('lua'), false)
end)

test('is_array should returns false when the table is working like a dictionary', function(a)
  a.equal(array.is_array({ language='lua' }), false)
end)

test('is_array should returns true when table is empty', function(a)
  a.equal(array.is_array({}), true)
end)

test('is_array should returns true when table is working like an array', function(a)
  a.equal(array.is_array({ 'a', 'b', 'c', 'd' }), true)
end)

test('is_empty should returns false when table has at least one item', function(a)
  a.equal(array.is_empty({ 'a' }), false)
end)

test('is_empty should returns false when table does not have any item', function(a)
  a.equal(array.is_empty({}), true)
end)

test('first should returns first item from table', function(a)
  a.equal(array.first({ 'a', 'b', 'c', 'd' }), 'a')
end)

test('last should returns last item from table', function(a)
  a.equal(array.last({ 'a', 'b', 'c', 'd' }), 'd')
end)

test('slice should returns a empty table when it does not have any element', function(a)
  a.equal(#array.slice({}, 1, 2), 0)
end)

test('slice should returns a table with values between start index and end index', function(a)
  local result = array.slice({ 'lua', 'javascript', 'python', 'ruby', 'c' }, 2, 4)

  a.equal(type(result), 'table')
  a.equal(#result, 3)
  a.equal(result[1], 'javascript')
  a.equal(result[2], 'python')
  a.equal(result[3], 'ruby')
end)

test('slice should returns a table with every values from start index until last index', function(a)
  local result = array.slice({ 'lua', 'javascript', 'python', 'ruby', 'c' }, 2)

  a.equal(type(result), 'table')
  a.equal(#result, 4)
  a.equal(result[1], 'javascript')
  a.equal(result[2], 'python')
  a.equal(result[3], 'ruby')
  a.equal(result[4], 'c')
end)

test('reverse should returns an inverted table', function(a)
  local result = array.reverse({ 'lua', 'javascript', 'python' })

  a.equal(type(result), 'table')
  a.equal(#result, 3)
  a.equal(result[1], 'python')
  a.equal(result[2], 'javascript')
  a.equal(result[3], 'lua')
end)

test('map should returns a table with 2, 4, 6 values', function(a)
  local result = array.map({ 1, 2, 3 }, function(value)
    return value * 2
  end)

  a.equal(type(result), 'table')
  a.equal(#result, 3)
  a.equal(result[1], 2)
  a.equal(result[2], 4)
  a.equal(result[3], 6)
end)

test('filter should returns a table with 10, 15, 20 values', function(a)
  local result = array.filter({ 15, 10, 5, 3, 20 }, function(value)
    return value >= 10
  end)

  a.equal(type(result), 'table')
  a.equal(#result, 3)
  a.equal(result[1], 15)
  a.equal(result[2], 10)
  a.equal(result[3], 20)
end)

test('max should returns the biggest value from a table', function(a)
  a.equal(array.max({ 20, 22, 1, 3, 30, 42 }), 42)
end)

test('max should returns nil when table is empty', function(a)
  a.equal(array.max({}), nil)
end)

test('min should returns the smallest value from a table', function(a)
  a.equal(array.min({ 20, 22, 1, 3, 30, 42 }), 1)
end)

test('min should returns nil when table is empty', function(a)
  a.equal(array.min({}), nil)
end)

test('reduce should returns 90', function(a)
  local result = array.reduce({ 20, 30, 40 }, function(memo, value)
    return memo + value
  end)

  a.equal(result, 90)
end)

test('reduce should returns 100', function(a)
  local result = array.reduce({ 20, 30, 40 }, function(memo, value)
    return memo + value
  end, 10)

  a.equal(result, 100)
end)

test('index_of should returns correct position of value in the table', function(a)
  a.equal(array.index_of({ 20, 30, 40, 50 }, 40), 3)
end)

test('index_of should returns -1 when the value is not in the table', function(a)
  a.equal(array.index_of({ 20, 30, 40 }, 50), -1)
end)

test('concat should joins the two array', function(a)
  local result = array.concat({ 1, 2, 3 }, { 4, 5, 6 })

  a.equal(#result, 6)
  a.equal(result[4], 4)
end)

test('uniq should returns every value once', function(a)
  local result = array.uniq({ 'a', 'b', 'a', 'b', 'c', 'd' })

  a.equal(#result, 4)
  a.equal(result[1], 'a')
  a.equal(result[2], 'b')
  a.equal(result[3], 'c')
  a.equal(result[4], 'd')
end)

test('without should returns all values less the items from second array', function(a)
  local result = array.without({ 10, 20, 30, 10, 4 }, { 10, 4 })

  a.equal(#result, 2)
  a.equal(result[1], 20)
  a.equal(result[2], 30)
end)

test('some should return true when exist at least one match', function(a)
  local result = array.some({'a', 'b', 'c'}, function(element)
    if (element == 'b') then return true end
  end)

  a.ok(result)
end)

test('some should return true when exist at least one match', function(a)
  local result = array.some({'a', 'b', 'c'}, function(element)
    if (element == 'd') then return true end
  end)

  a.not_ok(result)
end)

test('zip should return a new table with the correct pairs', function(a)
  local result = array.zip({ 'a', 'b' }, { 'A', 'B' })

  a.equal(result[1][1], 'a')
  a.equal(result[1][2], 'A')
  a.equal(result[2][1], 'b')
  a.equal(result[2][2], 'B')
end)

test('zip should not consider values without pairs', function(a)
  local result = array.zip({ 'a', 'b' }, { 'A', 'B', 'C' })

  a.equal(#result, 2)
  a.equal(#result[1], 2)
  a.equal(#result[2], 2)
  a.equal(result[1][1], 'a')
  a.equal(result[1][2], 'A')
  a.equal(result[2][1], 'b')
  a.equal(result[2][2], 'B')
end)

test('every should return true when all elements in the table pass the callback test', function(a)
  local result = array.every({ 10, 20, 30 }, function(value)
    return value >= 10
  end)

  a.ok(result)
end)

test('every should return false when at least a match fails', function(a)
  local result = array.every({ 10, 20, 30 }, function(value)
    return value > 10
  end)

  a.not_ok(result)
end)

test('shallowCopy should return a shallow copy of the array passed as parameter', function(a)
  local obj = {
    { 'a' },
    { 'b' }
  }

  local result = array.shallowCopy(obj)

  a.equal(#result, #obj)
  a.equal(result[1][1], obj[1][1])
  a.equal(result[2][1], obj[2][1])

  obj[1][1] = 'c'
  a.equal(result[1][1], obj[1][1])

  obj[1] = 'c'
  a.equal(type(result[1]), 'table')
end)

test('deepCopy should return a deep copy of the array passed as parameter', function(a)
  local obj = {
    { 'a' },
    { 'b' }
  }

  local result = array.deepCopy(obj)

  a.equal(#result, #obj)
  a.equal(result[1][1], obj[1][1])
  a.equal(result[2][1], obj[2][1])

  obj[1][1] = 'c'
  a.equal(result[1][1], 'a')

  obj[1] = 'c'
  a.equal(type(result[1]), 'table')
end)

test('diff should return a new table with the items which exist only in first table', function(a)
  local result = array.diff(
    { 'a', 'b' },
    { 'a', 'c', 'd' }
  )

  a.equal(#result, 1)
  a.equal(result[1], 'b')
end)
