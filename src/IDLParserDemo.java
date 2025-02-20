import java.nio.file.Files;
import java.nio.file.Path;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;

public class IDLParserDemo {
    
    public static void printTree(ParseTree tree, int level) {
        String indent = "    ".repeat(level);  // Use indentation for readability
        if (tree instanceof TerminalNode) {
            System.out.println(indent + tree.getText().strip() + "   (terminal node)");
        } else if (tree instanceof RuleNode) {
            if ( tree.getText().contains("\n") ) {
                System.out.println(indent + tree.getClass().getSimpleName() + " (xxx)");
            } else {
                System.out.println(indent + tree.getClass().getSimpleName() + " (" + tree.getText().trim() + ")");
            }
            for (int i = 0; i < tree.getChildCount(); i++) {
                printTree(tree.getChild(i), level + 1);
            }
        }
    }
    
    public static void main(String[] args) throws Exception {
        
        String idlCode;
        
        if ( args.length==0 ) {
            // Sample IDL code
            idlCode = """
                PRINT, x+2*4
                             """;
        } else {
            Path p = Path.of(args[0]);
            System.err.println("Reading "+p);
            idlCode= Files.readString(Path.of(args[0]));
        }

        // Create input stream
        CharStream input = CharStreams.fromString(idlCode);

        // Create lexer
        IDLLexer lexer = new IDLLexer(input);
        CommonTokenStream tokens = new CommonTokenStream(lexer);

        // Create parser
        IDLParser parser = new IDLParser(tokens);
        ParseTree tree = parser.program();
        
        printTree(tree,0);

    }
}
