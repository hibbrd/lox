#!/bin/bash

# Ensure we're in the script's directory
cd "$(dirname "$0")"

# Create a build directory to keep class files separate from source
mkdir -p build

# Compile all Java files into the build directory
# Since they have package 'com.craftinginterpreters.lox',
# they will be placed in 'build/com/craftinginterpreters/lox/'
javac -d build *.java

# Check if compilation was successful
if [ $? -eq 0 ]; then
    echo "Compilation successful."
    
    # If any arguments are provided, run the Lox class with them
    # Otherwise, start the REPL
    java -cp build com.craftinginterpreters.lox.Lox "$@"
else
    echo "Compilation failed."
    exit 1
fi
