grammar IDL;

options { caseInsensitive = true; }

// Root rule
program: ( procedure | function | statement | NL ) * EOF;

procedure : 'PRO' VARIABLE ( ',' argumentDeclaration )? NL statementBlock 'end' NL+;
 
function: 'FUNCTION' VARIABLE ( ',' argumentDeclaration )? NL statementBlock 'end' NL+;

statementBlock : ( statement NL | NL )+;
   
// Statements
statement
    : assignment
    | procedureCall
    | loopStatement
    | conditionalStatement
    | returnStatement
    | statement '$' NL statement
    | COMMENT
    | ';'
    ;

returnStatement: 'RETURN' ( ',' argumentList )? ;

assignment: VARIABLE '=' expression | VARIABLE array '=' expression;

functionCallOrArrayAccess: VARIABLE '(' functionOrProcedureCallArgumentList? ')';

functionOrProcedureCallArgumentList:
    functionOrProcedureCallArgument (',' functionOrProcedureCallArgument )*;

functionOrProcedureCallArgument:
    expression | keywordArgument;
    
procedureCall: VARIABLE ',' argumentList?  ;
    
argumentDeclaration: ( VARIABLE | keywordDeclaration ) ( ',' ( VARIABLE  | keywordDeclaration ) )* ;

keywordDeclaration:
    VARIABLE '=' VARIABLE;

loopStatement : forStatement | whileStatement;
    
endfor:
    'END' | 'ENDFOR';

forStatement :
    'FOR' VARIABLE '=' expression ',' expression 'DO' 'BEGIN' NL statementBlock endfor;

endwhile:
    'END' | 'ENDWHILE';

whileStatement :
    'WHILE' expression 'DO' 'BEGIN' NL statementBlock endwhile;


conditionalStatement
    : 'IF' expression 'THEN' statement ( 'ELSE' statement ) 
    | 'IF' expression 'THEN' 'BEGIN' NL 
            statementBlock 
      'ENDIF' ('ELSE' 'BEGIN' NL statementBlock 'ENDELSE')?
    ;

array : '[' arrayIndexList ']' | '(' arrayIndexList ')';

arrayIndexList : arrayIndex ( ',' arrayIndex )*;
    
arrayIndex : slice | NUMBER | VARIABLE | '*';
    
slice : sliceIndex ':' sliceIndex ( ':' sliceIndex )?;

sliceIndex : functionCallOrArrayAccess | arrayAccessExpr | VARIABLE | NUMBER | '*';
    
expression
    : expression ('+' | '-' | '*' | '/' | 'MOD' | '^' | '#' ) expression    # BinaryExpression
    | '-' expression                                                 # UnaryExpression
    | '(' expression ')'                                             # ParenthesizedExpression
    | functionCallOrArrayAccess                                      # FunctionCallExpression
    | arrayAccessExpr                                                # ArrayAccessExpression
    | VARIABLE                                                       # VariableExpression
    | NUMBER                                                         # NumberExpression
    | STRING                                                         # StringExpression
    | array                                                          # ArrayDeclaration
    ;

expressionList : expression ( ',' expression )* ;
    
keywordArgument:
    VARIABLE '=' expression | '/' VARIABLE;

arrayAccessExpr: VARIABLE '[' arrayIndexList ']' | VARIABLE '(' arrayIndexList ')';

// Function arguments
argumentList: expression (',' expression)*;

// Tokens
VARIABLE: [a-z_][a-z0-9_]*;
NUMBER: [0-9]+ ('.' [0-9]+)?;
STRING: '"' .*? '"' |  '\'' .*? '\'' ;

COMMENT: (';' ~[\r\n]*) -> skip;  // Skip comments
NL: [\r\n];                   // new line
WS: [ \t]+ -> skip;           // Ignore whitespace

