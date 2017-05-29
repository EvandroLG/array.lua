# array.lua
A small library with useful methods to handle Lua's table when it's working like an Array

## Installation
To install array, run:
```sh
$ luarocks install array
```
Or simply copy the array.lua file and paste in your project.

## Methods
* array.<code>is_array(object:table):boolean</code><br />
Checks if table is an Array

* array.<code>is_empty(object:table):boolean</code><br />
Checks if table is empty

* array.<code>slice(object:table, start:number, end:number):table</code><br />
Returns a shallow copy of a portion of a table into a new table

* array.<code>index_of(object:table, value:*):number</code><br />
Returns the index at which value can be found or -1 if value is not present

* array.<code>reverse(object:table):table</code><br />
Creates a new table with reverse values

* array.<code>first(object:table):*</code><br />
Returns the first value in a table

* array.<code>last(object:table):*</code><br />
Returns the last value in a table

* array.<code>max(object:table):*</code><br />
Returns the maximum value in a table

* array.<code>min(object:table):*</code><br />
Returns the minimum value in a table

* array.<code>map(object:table, callback:function):table</code><br />
Creates a new table of values by mapping each value in list through a transformation function

* array.<code>filter(object:table, callback:function):table</code><br />
Produces a new table containing all elements that pass truth test

* array.<code>reduce(object:table, callback:function [, memo]):*</code><br />
Applies a function against an accumulator and each value of the table to reduce it to a single value

* array.<code>concat(object:table, object:table):table</code><br />
Returns a new table by joining all values from the two tables

* array.<code>uniq(object:table):table</code><br />
Returns a new table by removing duplicates values

* array.<code>without(object:table, object:table):table</code><br />
Returns a copy of the table with all instances of the values removed
