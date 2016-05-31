local function is_table(obj)
    return type(obj) == 'table'
end

local array = {
    __VERSION = '1.0.0',
    __DESCRIPTION = '',
    __LICENCE = [[
        The MIT License (MIT)
        Copyright (c) 2016 Evandro Leopoldino Gonçalves
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
    ]]
}

array = {
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
        if array.is_empty(obj) then return {} end

        local output = {}
        for i=start, finish or #obj do
            table.insert(output, obj[i])
        end

        return output
    end,

    reverse = function(obj)
        local output = {}

        for i=#obj, 1, -1 do
            table.insert(output, obj[i])
        end

        return output
    end,

    first = function(obj)
        if not array.is_array(obj) then return nil end
        return obj[1]
    end,

    last = function(obj)
        if not array.is_array(obj) then return nil end
        return obj[#obj]
    end,

    each = function(obj, callback)
    end,

    map = function(obj, callback)
    end,
}

return array