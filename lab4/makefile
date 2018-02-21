

run: build dirs 
	@sudo ./launch_lcm.sh

build:
	@./buildjar.sh

dirs:
	@mkdir -p data && mkdir -p log

clean:
	@echo "Removed types, jar files, and pyc files"
	@rm -rf my_types my_types.jar *.pyc

cleandata:
	@echo "Removed data files"
	@rm -rf data

cleanlogs:
	@echo "Removed logs"
	@sudo rm -rf log

cleanall: cleanlogs cleandata clean 
