grammar IDL;

options { caseInsensitive = true; }

// Root rule
program: ( procedure | function | statement ) * EOF;

procedure : 'pro' VARIABLE ( ',' argumentDeclaration )? statementBlock 'end';
 
function: 'function' VARIABLE ( ',' argumentDeclaration )? statementBlock 'end';

statementBlock : ( statement )+;
   
// Statements
statement
    : assignment
    | functionCall
    | procedureCall
    | loopStatement
    | conditionalStatement
    | returnStatement
    | COMMENT
    | ';'
    ;

returnStatement: 'return' argumentList? ;

assignment: VARIABLE '=' expression ;

functionCall: VARIABLE '(' argumentList? ')' ;

procedureCall: VARIABLE ',' argumentList?  ;

loopStatement
    : 'for' '(' assignment expression ';' expression ')' '{' statementBlock '}'
    | 'WHILE' '(' expression ')' '{' statementBlock '}'
    | 'REPEAT' '{' statementBlock '}' 'UNTIL' '(' expression ')' 
    ;

conditionalStatement
    : 'IF' '(' expression ')' '{' statementBlock '}'
      ('ELSE' '{' statementBlock '}')?
    ;

expression
    : expression ('+' | '-' | '*' | '/' | 'MOD' | '^') expression    # BinaryExpression
    | '-' expression                                                 # UnaryExpression
    | '(' expression ')'                                             # ParenthesizedExpression
    | functionCall                                                   # FunctionCallExpression
    | VARIABLE                                                       # VariableExpression
    | NUMBER                                                         # NumberExpression
    | STRING                                                         # StringExpression
    ;

argumentDeclaration: VARIABLE ( ',' VARIABLE )* ;

// Function arguments
argumentList: expression (',' expression)*;

// Tokens
VARIABLE: [a-z_][a-z0-9_]*;
NUMBER: [0-9]+ ('.' [0-9]+)?;
STRING: '"' .*? '"';

COMMENT: (';' ~[\r\n]*) -> skip;  // Skip comments
WS: [ \t\r\n]+ -> skip;           // Ignore whitespace

