# IDL_AST
Java-based IDL syntax parser

# Assumptions
This assumes you are on a Linux machine with antlr4 installed.

# Instructions
* git clone git@github.com:jbfaden/IDL_AST.git
* antlr4 -Dlanguage=Java IDL.g4 
* javac -cp .:antlr4-4.0-complete.jar *.java
* java  -cp .:antlr4-4.0-complete.jar IDLParserDemo
