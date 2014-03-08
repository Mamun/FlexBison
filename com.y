%{
#include <ctype.h>
#include <stdio.h>
FILE *save_p;
int new_line=1,stack_top=0,trigger=1;
void value_store(int);
int check_srore(char name_var[],int);
void error(int);

struct store
{
int var_value;
char var_name[10];
}info[10];        

%}

%token PRINT SAVE S_COLON L_BRACE R_BRACE DIGIT VAR COMMA NW_LINE
%left A_SIGN S_SIGN
%left D_SIGN M_SIGN
%right E_SIGN



%%
commands : 
	 | commands command
	 ;
command : expers
	| print
	| save
	| NW_LINE{new_line++;}
	;

save	: SAVE expr etest {fprintf(save_p,"%d\n",$2);}
        ;

expers  : store_val equal expr etest{value_store($3);}
	;

print	: PRINT expr etest {printf("%d\n",$2);} 
        ;

etest	: S_COLON
	| DIGIT {error(0);}|PRINT{error(0);}|SAVE{error(0);}
	| VAR{error(0);}|COMMA{error(0);}
	;

store_val : VAR {check_store($1,0);}
	  ;

expr    : expr A_SIGN expr      { $$ = $1 + $3; } 
	| expr S_SIGN expr      { $$ = $1 - $3; }
   	| expr M_SIGN expr      { $$ = $1 * $3; }
        | expr D_SIGN expr      { $$ = $1 / $3; }
	| L_BRACE expr R_BRACE  { $$ = $2; }
	| DIGIT
	| retriv_var
	;

equal   : E_SIGN
        ;

retriv_var : VAR { $$=check_store($1,1); }
	   ;			

%%

#include "lex.yy.c"

void error(int temp)
{
 char *err[]={
              "Statement Missing\n",
	       "Compund Statement Missing\n",
               "Variable need a value\n",
               "Invalid Argument\n"  
		};
printf("In line no.%d:\t%s",new_line,err[temp]);   
exit(1);
} 

void value_store(int store_val)
{
stack_top--;
info[stack_top++].var_value = store_val;
}

int check_store(char name_var[],int status)
{
 int temp = 0;
 do{
    	if(strcmp(info[temp].var_name,name_var)==0)
    	{
	   trigger=0;
           if(status)
	   {  
              trigger=1;
	      return (info[temp].var_value);
	   }          
        }
     temp++;		
   } while(temp<stack_top);
 
   if(trigger)
   {    
	if(status)
	{
	  trigger=1;
          error(2);
	}
        else
	strcpy(info[stack_top++].var_name,name_var);
   }
   else trigger=1;

}

int yyerror(const char *str)
{
fprintf(stderr,"error: %s\n",str);
}


main(int argc, char *argv[])
{       
          
	if(argc != 3)
	{
         error(3);
	}
yyin = fopen(argv[1],"r");
save_p = fopen(argv[2],"w");
yyparse();
fclose(yyin);
fclose(yyout);
}

