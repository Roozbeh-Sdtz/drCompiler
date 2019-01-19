%{
    #include <stdio.h>
    #include <stdlib.h>

    
    int symbols[52];
    int symbolVal(char symbol);
    void updateSybmbolVal(char symbol, int val);
    
%}

%union {int num; char id;}

%start line
%token print
%token exit_command
%token <num>DOUBLE                
%token <num>INTEGER               
%token FUNCTION              
%token END                   
%token IF                    
%token FOR                   
%token <id> IDENTIFIER           
%token COMMA                 
%token DOT                   
%token ENDLINE               
%token OPENPARENTHESIS       
%token CLOSEPARENTHESIS      
%token OPENBRACKET           
%token CLOSEBRACKET          
%token OPENBRACE             
%token CLOSEBRACE                
%token AND                   
%token OR                    
%token EQUAL                 
%token DIFFERENT             
%token ASSIGN                
%token LESS                  
%token LESSOREQUAL           
%token GREATER               
%token GREATEROREQUAL        
%token PLUS                  
%token MINUS                 
%token MULTIPLY              
%token DIVIDE                
%token EXPONENTIAL           
%token ELSE                  
%token ELSEIF                
%token SWITCH                
%token CASE                  
%token OTHERWISE             
%token WHILE                 
%token CONTINUE              
%token BREAK                 
%token RETURN                
%token DOTDOT                
%token DIVIDELINEAR          
%type <num> line exp term
%type <id> assignment

%%
    line        : assignment ENDLINE {;}
                | exit_command ENDLINE {exit(EXIT_SUCCESS);}
                | print exp ENDLINE {printf("print %d\n",$2);}
                | line assignment ENDLINE {;}
                | line exit_command ENDLINE {exit(EXIT_SUCCESS);}
                | line print exp ENDLINE {printf("print %d\n",$3);}
                ;

    assignment  : IDENTIFIER ASSIGN exp {updateSybmbolVal($1,$3);}
                ;

    exp         : term              {$$ = $1;}
                | exp PLUS term      {$$ = $1 + $3;}
                | exp MINUS term      {$$ = $1 - $3;}
                | exp DIVIDE term      {$$ = $1 / $3;}
                | exp MULTIPLY term      {$$ = $1 * $3;}
                ;
    term        : INTEGER            {$$ = $1;}
                | IDENTIFIER        {$$ = symbolVal($1);}
                ;
%%


int computerSymbolIndex(char token)
{
    int idx = -1;
    if(islower(token)) {
        idx = token - 'a' + 26;
    } else if (isupper(token)) {
        idx = token - 'A';
    }
    return idx;
}

int symbolVal(char symbol){
    int index = computerSymbolIndex(symbol);
    return symbols[index];
}

void updateSybmbolVal(char symbol, int val){
    int index = computerSymbolIndex(symbol);
    symbols[index] = val;
}

int main (){
    int i;
    for(i=0;i<52;i++){
        symbols[i] = 0;
    }

    return yyparse ();
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);}