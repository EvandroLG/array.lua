task_folder := ./tasks/

.SILENT:

install_dependencies:
	luarocks install simple_test

test:
	LUA_PATH="./src/?.lua;./src/?/init.lua;./src/array/?.lua;;" lua test.lua

rockspec:
	bash $(task_folder)create_rockspec.sh $(version)

upload_rockspec:
	bash $(task_folder)upload_rockspec.sh $(version)

clean_rockspec:
	rm -rf *.rockspec
	rm -rf *.rock
