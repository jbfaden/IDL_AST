# IDL_AST
Java-based IDL syntax parser

# Assumptions
This assumes you are on a Linux machine with antlr4 installed.

# Instructions
* git clone git@github.com:jbfaden/IDL_AST.git
* locate antlr-4.13.2-complete.jar and place it in the lib directory
* If antlr is installed: `antlr4 -Dlanguage=Java IDL.g4`, or better:
* java -jar ../lib/antlr-4.13.2-complete.jar -Dlanguage=Java IDL.g4 
* javac -cp .:../lib/antlr-4.13.2-complete.jar *.java
* java  -cp .:../lib/antlr-4.13.2-complete.jar IDLParserDemo

# more fun:

## visualize the tree
cat SpxMMSwlabels.pro | java -cp .:../lib/antlr-4.13.2-complete.jar org.antlr.v4.gui.TestRig IDL program -gui

