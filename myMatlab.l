%{
    #include "matlabToken.h"
%}

digit [0-9]
integer {digit}+
real ({digit}+[.]{digit}*)|({digit}*[.]{digit}+)

%%
[ \t\n]                           ;
{real}                          return DOUBLE;
{integer}                       return INTEGER;
"function"                      return FUNCTION;
"end"                           return END;
"if"                            return IF;
"for"                           return FOR;
"else"                          return ELSE;
"elseif"                        return ELSEIF;
"switch"                        return SWITCH;
"case"                          return CASE;
"otherwise"                     return OTHERWISE;
"while"                         return WHILE;
"continue"                      return CONTINUE;
"return"                        return RETURN;   
"break"                         return BREAK;
[a-zA-Z_][a-zA-Z0-9_]*          return IDENTIFIER;
","                             return COMMA;
"."                             return DOT;
":"                             return DOTDOT;                        
";"                             return ENDLINE;
"("                             return OPENPARENTHESIS;
")"                             return CLOSEPARENTHESIS;
"["                             return OPENBRACKET;
"]"                             return CLOSEBRACKET;
"{"                             return OPENBRACE;
"}"                             return CLOSEBRACE;
"&&"                            return AND;
"||"                            return OR;
"=="                            return EQUAL;
"~="                            return DIFFERENT;
"="                             return ASSIGN;
"<"                             return LESS;
"<="                            return LESSOREQUAL;
">"                             return GREATER;
">="                            return GREATEROREQUAL;                  
"+"                             return PLUS;
"-"                             return MINUS;
"*"                             return MULTIPLY;
"/"                             return DIVIDE;
"^"                             return EXPONENTIAL; 
"\\"                            return DIVIDELINEAR;  
.                               printf("unexpected charecter \n");
%%

