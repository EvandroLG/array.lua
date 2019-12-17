return {
  -- Helper function to check if value passed by parameter is a table
  -- @obj {table}
  -- @returns {boolean}
  is_table = function(obj)
    return type(obj) == 'table'
  end,

  -- Raises error if @param is not an array
  -- @obj {table}
  -- @param {table}
  -- @method {string}
  -- @returns {void}
  raises_error = function(obj, param, method)
    assert(obj.is_array(param), string.format('%s expects an array', method))
  end,

  -- Returns lowest value between two values
  -- @a {number}
  -- @b {number}
  -- @returns number
  lowest_value = function(a, b)
    return a < b and a or b
  end,

  -- Makes multiple inserts in a table (array-like)
  -- @obj {table}
  -- @values {table}
  -- @returns {void}
  multiple_inserts = function(obj, values)
    for i=1, #values do
      local value = values[i]
      table.insert(obj, value)
    end
  end
}
