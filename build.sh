#!/bin/bash

# Ensure we're in the script's directory
cd "$(dirname "$0")"

# Create a build directory to keep class files separate from source
mkdir -p build

# 1. Compile the tools
echo "Compiling tools..."
javac -d build tool/*.java
if [ $? -ne 0 ]; then
    echo "Tool compilation failed."
    exit 1
fi

# 2. Run the tool to generate code
echo "Generating AST..."
java -cp build com.craftinginterpreters.tool.GenerateAst lox/
if [ $? -ne 0 ]; then
    echo "AST generation failed."
    exit 1
fi

# 3. Compile all Java files (including generated ones) into the build directory
echo "Compiling Lox..."
javac -d build lox/*.java

# Check if compilation was successful
if [ $? -eq 0 ]; then
    echo "Lox compilation successful."
    
    # If any arguments are provided, run the Lox class with them
    # Otherwise, start the REPL
    java -cp build com.craftinginterpreters.lox.Lox "$@"
else
    echo "Lox compilation failed."
    exit 1
fi
