# array.lua
A small library with useful methods to handle Lua's table when it's working like an Array

## Installation
To install array, run:
```sh
$ luarocks install array
```
Or simply copy the array.lua file and paste in your project.

## Methods
* array.<code>is_array(object:table):boolean</code>__
Checks if table is an Array

* array.<code>is_empty(object:table):boolean</code>__
Checks if table is empty

* array.<code>slice(object:table, start:number, end:number):table</code>__
Returns a shallow copy of a portion of a table into a new table

* array.<code>index_of(object:table, value:*):number</code>__
Returns the index at which value can be found or -1 if value is not present

* array.<code>reverse(object:table):table</code>__
Creates a new table with reverse values

* array.<code>first(object:table):*</code>__
Returns the first value in a table

* array.<code>last(object:table):*</code>__
Returns the last value in a table

* array.<code>max(object:table):*</code>__
Returns the maximum value in a table

* array.<code>min(object:table):*</code>__
Returns the minimum value in a table

* array.<code>map(object:table, callback:function):table</code>__
Creates a new table of values by mapping each value in list through a transformation function

* array.<code>filter(object:table, callback:function):table</code>__
Produces a new table containing all elements that pass truth test

* array.<code>reduce(object:table, callback:function [, memo]):*</code>__
Applies a function against an accumulator and each value of the table to reduce it to a single value
