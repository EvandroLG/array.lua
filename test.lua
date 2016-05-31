local array = require 'array'
local format = string.format

function test(name, func)
  xpcall(function()
    func()
    print(format('[pass] %s', name))
  end, function(err)
    print(format('[fail] %s : %s', name, err))  
  end)
end

function _equal(a, b)
  return a == b
end

function assert_equal(a, b)
  assert(_equal(a, b))
end

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
