
%{
#include <stdio.h>
#include <stdlib.h>
%}

var		[A-Za-z][A-Za-z0-9]*
digit		[0-9]+
comment		\*\*[A-Za-z0-9\*\/\+\-\(\)\"\' \t;:=]*\n
		
%%				
print		{return(PRINT);}
save		{return(SAVE);}
{digit}		{yylval=atoi(yytext);return(DIGIT);}
{var}		{yylval=strdup(yytext);return(VAR);}
\*		{return(M_SIGN);}
\/		{return(D_SIGN);}
\+		{return(A_SIGN);}
\-		{return(S_SIGN);}
\(		{return(L_BRACE);}
\)		{return(R_BRACE);}
=		{return(E_SIGN);}
;		{return(S_COLON);}
:		{return(COMMA);}
\n		{return (NW_LINE);}
[ \t]		/*skip*/;
{comment}	/*skip*/;
%%
