%{
#include <string>
#include <iostream>

#include "parser.hpp"
#define SHOW_TOKEN std::cout << std::endl << std::string(yytext, yyleng) << " : "
#define SAVE_TOKEN yylval.string = new std::string(yytext, yyleng)
#define TOKEN(t) (yylval.token = t)
extern "C" int yywrap() { return 1; }

#define YY_NO_UNISTD_H
%}

SPACE		[ \t\n]
DIGIT		[0-9]
LETTER		[a-zA-Z]

%%

{SPACE}+                                                          ;
"model"                                                           return TOKEN(TMODEL);
"license"                                                         return TOKEN(TLICENSE);
"distance"                                                        return TOKEN(TDISTANCE);
"features"                                                        return TOKEN(TFEATURES);
"reparations"                                                     return TOKEN(TREPARATIONS);
"date"                                                            return TOKEN(TDATE);
"description"                                                     return TOKEN(TDESCRIPTION);
"car"                                                             return TOKEN(TCAR);
[1-9]({DIGIT})*                                                   SAVE_TOKEN; return TINTEGER;
({LETTER}|{DIGIT}|"-"|"_")+                                       SAVE_TOKEN; return TFEATUREID;
\"[0-9]+\-[a-zA-Z0-9_]+\"                                         SAVE_TOKEN; return TLICENSESTRING;
\"[0-3][0-9]\-[0-1][0-9]\-([0-9]){4,4}\"                          SAVE_TOKEN; return TDATESTRING;
\"({LETTER}|{DIGIT}|{SPACE}|"-"|","|";"|"."|"="|"+"|"_"|"*")*\"   SAVE_TOKEN; return TSTRING;
"="                                                               return TOKEN(TEQUAL);
"("                                                               return TOKEN(TLPAREN);
")"                                                               return TOKEN(TRPAREN);
"{"                                                               return TOKEN(TLBRACE);
"}"                                                               return TOKEN(TRBRACE);
","                                                               return TOKEN(TCOMMA);
.                                                                 SHOW_TOKEN;printf("Unknown token!\n"); yyterminate();

%%