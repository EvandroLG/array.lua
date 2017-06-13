package = 'array'
version = '1.2.1-0'

source = {
  url = 'git://github.com/evandrolg/array.lua.git',
  tag = 'v1.2.1'
}

description = {
  summary = "A small library with useful methods to handle Lua's table when it's working like an Array",
  homepage = 'https://github.com/EvandroLG/array.lua',
  maintainer = 'Evandro Leopoldino Gonçalves (@evandrolg) <evandrolgoncalves@gmail.com>',
  license = 'MIT <http://opensource.org/licenses/MIT>'
}

dependencies = {
  "lua >= 5.1"
}

build = {
  type = "builtin",
  modules = {
    ['array'] = "array.lua"
  }
}
