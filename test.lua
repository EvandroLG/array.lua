local array = require './src/array'
local test = require 'simple_test'

test('meta infos', function(a)
  a.equal(array.__VERSION, '1.2.6')
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

test('reduce_right should concatenate all items starting from right to left', function(a)
  local result = array.reduce_right({ 'a', 'b', 'c', 'd', 'e' }, function(memo, value)
    return memo .. value
  end)

  a.equal(result, 'edcba')
end)

test('reduce_right should return 100', function(a)
  local result = array.reduce_right({ 20, 30, 40 }, function(memo, value)
    return memo + value
  end, 10)

  a.equal(result, 100)
end)

test('reduce_right', function(a)
  local result = array.reduce_right({ 'a', 'b', 'c', 'd', 'e' }, function(memo, value)
    return memo .. value
  end)

  a.equal(result, 'edcba')
end)

test('sum should return sum of the values in table', function(a)
  local result = array.sum({10, 20, 30, 40, 50})
  a.equal(result, 150)
end)

test('index_of should return correct position of value in the table', function(a)
  a.equal(array.index_of({ 20, 30, 40, 50 }, 40), 3)
end)

test('index_of should return -1 when the value is not in the table', function(a)
  a.equal(array.index_of({ 20, 30, 40 }, 50), -1)
end)

test('concat should join the two array', function(a)
  local result = array.concat({ 1, 2, 3 }, { 4, 5, 6 })

  a.equal(#result, 6)
  a.equal(result[4], 4)
end)

test('uniq should return every value once', function(a)
  local result = array.uniq({ 'a', 'b', 'a', 'b', 'c', 'd' })

  a.equal(#result, 4)
  a.equal(result[1], 'a')
  a.equal(result[2], 'b')
  a.equal(result[3], 'c')
  a.equal(result[4], 'd')
end)

test('without should return all values less the items from second array', function(a)
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

test('shallow_copy should return a shallow copy of the array passed as parameter', function(a)
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

test('deep_copy should return a deep copy of the array passed as parameter', function(a)
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

test('diff should return a new table with the items which exist only in first table', function(a)
  local result = array.diff(
    { 'a', 'b', 'g', 'z', 'h' },
    { 'a', 'c', 'd', 'e', 'f', 'h', 'x' }
  )

  a.equal(#result, 3)
  a.equal(result[1], 'b')
  a.equal(result[2], 'g')
  a.equal(result[3], 'z')
end)

test('flat should return a new table that is an one-dimensional flatting of the table passed by parameter', function(a)
  local obj = { 'a', 'b', 'c', { 'd', 'e', 'f', { 'g', 'h' } }, { 'i' }, 'j' }
  local result = array.flat(obj)

  a.equal(#result, 10)
end)

test('fill should create a table with the size passed by parameter and fill every item using the value passed as argument', function(a)
  local value = 1
  local size = 3
  local result = array.fill(value, size)

  a.equal(#result, size)
  a.equal(result[1], value)
  a.equal(result[2], value)
  a.equal(result[3], value)
end)

test('fill should create a table using the value passed by argument from start to end', function(a)
  local value = 'a'
  local start = 3
  local finish = 4
  local result = array.fill(value, start, finish)

  a.equal(result[1], nil)
  a.equal(result[2], nil)
  a.equal(result[3], value)
  a.equal(result[4], value)
end)

test('remove should delete items that callback returns thruthy and should return a new table with the removed items', function(a)
  local list = { 1, 2, 3, 4 }
  local result = array.remove(list, function(value)
    return math.fmod(value, 2) == 0
  end)

  a.equal(#list, 2)
  a.equal(list[1], 1)
  a.equal(list[2], 3)

  a.equal(#result, 2)
  a.equal(result[1], 2)
  a.equal(result[2], 4)
end)

test('counter should return a new in hash format', function(a)
  local list = { 'a', 'b', 'a', 'a', 'c', 'b' }
  local result = array.counter(list)

  a.equal(result.a, 3)
  a.equal(result.b, 2)
  a.equal(result.c, 1)
end)

test('intersect should return a new table with the values that exist in both tables', function(a)
  local first_list = { 'a', 'b', 'a', 'c', 'e', 'f', 'a' }
  local second_list = { 'b', 'a', 'd', 'a' }
  local result = array.intersect(first_list, second_list)

  a.equal(#result, 3)
  --a.equal(result[1], 'b')
  --a.equal(result[2], 'a')
  --a.equal(result[3], 'a')
end)

test('from_pairs should return a table composed from key-value pairs', function(a)
  local result = array.from_pairs({ {'a', 1}, {'b', 2} })

  a.equal(result.a, 1)
  a.equal(result.b, 2)
end)
