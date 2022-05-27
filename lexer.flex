%top{
#include "parser.tab.hh"
#define YY_DECL yy::parser::symbol_type yylex()
#include "Node.h"
}

%option noyywrap nounput batch noinput stack

%%

"+"                     {return yy::parser::make_PLUSOP(yytext);}
"-"                     {return yy::parser::make_MINUSOP(yytext);}
"*"                     {return yy::parser::make_MULTOP(yytext);}
"("                     {return yy::parser::make_LP(yytext);}
")"                     {return yy::parser::make_RP(yytext);}
"]"                     {return yy::parser::make_RSQUAREP(yytext);}
"["                     {return yy::parser::make_LSQUAREP(yytext);}
"{"                     {return yy::parser::make_LBRACKET(yytext);}
"}"                     {return yy::parser::make_RBRACKET(yytext);}
","                     {return yy::parser::make_COMMA(yytext);}
";"                     {return yy::parser::make_SEMICOLON(yytext);}
"="                     {return yy::parser::make_EQUALS(yytext);}
"/"                     {return yy::parser::make_DIVISIONOP(yytext);}
"&&"                    {return yy::parser::make_AND(yytext);}
"||"                    {return yy::parser::make_OR(yytext);}
"<"                     {return yy::parser::make_LESSER(yytext);}
">"                     {return yy::parser::make_GREATER(yytext);}
"=="                    {return yy::parser::make_ASSIGNOP(yytext);}
"class"                 {return yy::parser::make_CLASS(yytext);}
"public"                {return yy::parser::make_PUBLIC(yytext);}
"static"                {return yy::parser::make_STATIC(yytext);}
"void"                  {return yy::parser::make_VOID(yytext);}
"main"                  {return yy::parser::make_MAIN(yytext);}
"String"                {return yy::parser::make_STRING(yytext);}
"extends"               {return yy::parser::make_EXTENDS(yytext);}
"return"                {return yy::parser::make_RETURN(yytext);}
"int"                   {return yy::parser::make_INTEGER(yytext);}
"boolean"               {return yy::parser::make_BOOLEAN(yytext);}
"if"                    {return yy::parser::make_IF(yytext);}
"else"                  {return yy::parser::make_ELSE(yytext);}
"while"                 {return yy::parser::make_WHILE(yytext);}
"System.out.println"    {return yy::parser::make_PRINT(yytext);}
"."                     {return yy::parser::make_PERIOD(yytext);}
"length"                {return yy::parser::make_LENGTH(yytext);}
"true"                  {return yy::parser::make_TRUE(yytext);}
"false"                 {return yy::parser::make_FALSE(yytext);}
"new"                   {return yy::parser::make_NEW(yytext);}
"!"                     {return yy::parser::make_NOT(yytext);}
"this"                  {return yy::parser::make_THIS(yytext);}

0|[1-9][0-9]*            {return yy::parser::make_INT(yytext);}
[A-Za-z]([A-Za-z]|[1-9]|_)*    {return yy::parser::make_IDENTIFIER(yytext);}

[ \t\n]+                {}
"//".*                  {}
<<EOF>>                 return yy::parser::make_END();
%%