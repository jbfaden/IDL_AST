import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;

public class IDLParserDemo {
    public static void main(String[] args) throws Exception {
        // Sample IDL code
        String idlCode = """
            PRINT(x);
            
        """;

        // Create input stream
        CharStream input = CharStreams.fromString(idlCode);

        // Create lexer
        IDLLexer lexer = new IDLLexer(input);
        CommonTokenStream tokens = new CommonTokenStream(lexer);

        // Create parser
        IDLParser parser = new IDLParser(tokens);
        ParseTree tree = parser.program();

        // Print AST
        System.out.println(tree.toStringTree(parser));
    }
}
