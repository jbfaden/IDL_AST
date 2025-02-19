grammar IDL;

// Root rule
program: statement* EOF;

// Statements
statement
    : assignment
    | functionCall
    | loopStatement
    | conditionalStatement
    | RETURN expression? ';'
    | COMMENT
    | ';'
    ;

assignment: VARIABLE '=' expression ';';

functionCall: VARIABLE '(' argumentList? ')' ';';

loopStatement
    : 'FOR' '(' assignment expression ';' expression ')' '{' statement* '}'
    | 'WHILE' '(' expression ')' '{' statement* '}'
    | 'REPEAT' '{' statement* '}' 'UNTIL' '(' expression ')' ';'
    ;

conditionalStatement
    : 'IF' '(' expression ')' '{' statement* '}'
      ('ELSE' '{' statement* '}')?
    ;

expression
    : expression ('+' | '-' | '*' | '/' | 'MOD' | '^') expression   # BinaryExpression
    | '-' expression                                                 # UnaryExpression
    | '(' expression ')'                                             # ParenthesizedExpression
    | functionCall                                                   # FunctionCallExpression
    | VARIABLE                                                       # VariableExpression
    | NUMBER                                                         # NumberExpression
    | STRING                                                         # StringExpression
    | BOOLEAN                                                        # BooleanExpression
    ;

// Function arguments
argumentList: expression (',' expression)*;

// Tokens
VARIABLE: [a-zA-Z_][a-zA-Z0-9_]*;
NUMBER: [0-9]+ ('.' [0-9]+)?;
STRING: '"' .*? '"';
BOOLEAN: 'TRUE' | 'FALSE';

COMMENT: (';' ~[\r\n]*) -> skip;  // Skip comments
WS: [ \t\r\n]+ -> skip;           // Ignore whitespace

