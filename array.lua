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
        if type(obj) ~= 'table' then return false end

        local i = 0
        for _ in pairs(obj) do
            i = i + 1
            if obj[i] == nil then return false end
        end

        return true
    end,

    is_empty = function(obj)
    end,

    slice = function(obj, start, finish)
    end,

    reverse = function(obj)
    end,

    first = function(obj)
    end,

    last = function(obj)
    end,

    each = function(obj, callback)
    end,

    map = function(obj, callback)
    end,
}

return array
