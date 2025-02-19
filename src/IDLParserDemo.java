import java.nio.file.Files;
import java.nio.file.Path;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;

public class IDLParserDemo {
    public static void main(String[] args) throws Exception {
        
        String idlCode;
        
        if ( args.length==0 ) {
            // Sample IDL code
            idlCode = """
                PRINT, x+2*4
                             """;
        } else {
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

        // Print AST
        System.out.println(tree.toStringTree(parser));
    }
}
