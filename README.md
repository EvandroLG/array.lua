# array.lua
A small library with useful methods to handle Lua's table when it's working like an Array

[![Build
Status](https://travis-ci.org/EvandroLG/array.lua.svg?branch=master)](https://travis-ci.org/EvandroLG/array.lua)

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

* array.<code>reduce_right(object:table, callback:function [, memo]):*</code><br />
Works like `reduce` except that it iterates over table's elements from right to left

* array.<code>sum(object:table):number</code><br />
Returns the sum of the values of the table passed by parameter

* array.<code>concat(object:table, object:table):table</code><br />
Returns a new table by joining all values from the two tables

* array.<code>uniq(object:table):table</code><br />
Returns a new table by removing duplicates values

* array.<code>without(object:table, object:table):table</code><br />
Returns a copy of the table with all instances of the values removed

* array.<code>some(object:table, callback:function):boolean</code><br />
Tests whether at least one element in the table passes the test implemented by the callback

* array.<code>every(object:table, callback:function):boolean</code><br />
Tests whether all elements in the table passes the test implemented by the callback

* array.<code>zip(object:table, object:table):table</code><br />
Returns a table of the two supplied by pairing up equally-positioned elements from both tables

* array.<code>shallow_copy(object:table):table</code><br />
Returns a shallow copy of the table passed as parameter

* array.<code>deep_copy(object:table):table</code><br />
Returns a deep copy of the table passed as parameter

* array.<code>diff(object:table, object:table):table</code><br />
Returns a new table with the items which exist only in the first table

* array.<code>flat(object:table):table</code><br />
Creates a new table with the sub-table elements concatenated into it

* array.<code>fill(value:*, [start:number], end:number):table</code><br />
Creates a table filling all the elements from a start index (default
one) to an end index with a default value passed by parameter.

* array.<code>remove(object:table, callback:function):table</code><br />
Removes all elements from table that `callback` returns truthy for and returns a new table with the removed elements
