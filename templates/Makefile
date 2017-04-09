compile:
	cd build && cmake -DBOOST_ROOT=./modules/boost_1_63_0 .. && make install

run: compile
	./artifacts/%PROJ_NAME%

ut: compile
	./artifacts/%PROJ_NAME%_ut
     
clean:
	cd build && make clean

deep-clean:
	rm -rf build/

clean-download:
	rm -rf .download/*

.PHONY: compile run ut clean deep-clean clean-download
