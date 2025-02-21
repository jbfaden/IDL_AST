grammar IDL;

options { caseInsensitive = true; }

// Root rule
program: ( procedure | function | statement ) * EOF;

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
    | COMMENT
    | ';'
    ;

returnStatement: 'RETURN' argumentList? ;

assignment: VARIABLE '=' expression ;

functionCallOrArrayAccess: VARIABLE '(' argumentList? ')' ;

procedureCall: VARIABLE ',' argumentList?  ;

loopStatement
    : 'FOR' '(' assignment expression ';' expression ')' '{' statementBlock '}'
    | 'WHILE' '(' expression ')' '{' statementBlock '}'
    | 'REPEAT' '{' statementBlock '}' 'UNTIL' '(' expression ')' 
    ;

conditionalStatement
    : 'IF' '(' expression ')' 'THEN' statement ( 'ELSE' statement ) 
    | 'IF' '(' expression ')' 'THEN' 'BEGIN' NL 
            statementBlock 
      'ENDIF' ('ELSE' 'BEGIN' NL statementBlock 'ENDELSE')?
    ;

array : '[' expressionList ']' | '(' expressionList ')';
    
expression
    : expression ('+' | '-' | '*' | '/' | 'MOD' | '^') expression    # BinaryExpression
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
    
argumentDeclaration: VARIABLE ( ',' VARIABLE )* ;

arrayAccessExpr: VARIABLE '[' argumentList ']' | VARIABLE '(' argumentList ')';

// Function arguments
argumentList: expression (',' expression)*;

// Tokens
VARIABLE: [a-z_][a-z0-9_]*;
NUMBER: [0-9]+ ('.' [0-9]+)?;
STRING: '"' .*? '"' |  '\'' .*? '\'' ;

COMMENT: (';' ~[\r\n]*) -> skip;  // Skip comments
NL: [\r\n];                   // new line
WS: [ \t]+ -> skip;           // Ignore whitespace

