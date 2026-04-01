# Define variables
CC = g++
exe = main
exe_static = main_static
exe_shared = main_shared

# Source code other than main
lib = libvectorsort.a
lib_shared = libvectorsort.so
lib_name = vectorsort
lib_src = Merge.cpp Mergesort.cpp PrintArray.cpp
obj = Merge.o Mergesort.o PrintArray.o

# Execute all tasks by default
all: $(exe) static shared

# 1. Directly compile the executable file
$(exe): main.o $(obj)
	$(CC) main.o $(obj) -o $(exe)

# 2. Create a static function library (.a)
static: $(obj)
	ar rcs $(lib) $(obj)
	$(CC) main.cpp -L. -l$(lib_name) -o $(exe_static)

# 3. Create a shared library (.so)
shared:
	$(CC) -fPIC -shared $(lib_src) -o $(lib_shared)
	$(CC) main.cpp -L. -l$(lib_name) -Wl,-rpath,. -o $(exe_shared)

# General rule: Compile .o files
%.o: %.c
	$(CC) $@ -o -c $^

# Clearing command
.PHONY: clean
clean:
	rm -f $(exe) $(exe_static) $(exe_shared) *.o