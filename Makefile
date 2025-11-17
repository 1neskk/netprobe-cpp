.PHONY: build debug test clean format help

build:
	mkdir -p build
	echo "Building project in Release mode..."
	cd build && \
	cmake -DCMAKE_BUILD_TYPE=Release .. && \
	make

debug:
	mkdir -p build
	echo "Building project in Debug mode..."
	cd build && \
	cmake .. -DCMAKE_BUILD_TYPE=Debug && \
	make

test:
	mkdir -p build
	echo "Building project in Test mode..."
	cd build && \
	cmake .. -DCMAKE_BUILD_TYPE=Test && \
	make

clean:
	rm -rf build

format:
	clang-format src/*.cpp src/*/*.cpp include/*.h include/*/*.h -i --style=file

help:
	@echo "Makefile commands:"
	@echo "  build   - Build the project in Release mode"
	@echo "  debug   - Build the project in Debug mode"
	@echo "  clean   - Clean the build directory"
	@echo "  format  - Format the source code according to Google style with an IndentWidth of 4"
	@echo "  help    - Show this help message"