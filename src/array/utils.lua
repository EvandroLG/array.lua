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
  end,

  -- Convert array to hash table
  -- @obj {table}
  -- @returns {table}
  convert_to_hash = function(obj)
    local output = {}

    for i=1, #obj do
      local value = obj[i]
      output[value] = true
    end

    return output
  end,

  -- Loop through table and print all values
  -- @obj {table}
  -- @returns {nil}
  print_items = function(obj)
    for i=1, #obj do
      print(obj[i])
    end
  end,

  -- Checks wether value is nil
  -- @obj {any}
  -- @returns {boolean}
  is_nil = function(value)
    return value == nil
  end
}
