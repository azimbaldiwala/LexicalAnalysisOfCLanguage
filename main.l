%{

#include <stdio.h>
int lines = 0; 
int keywords = 0;
int idn = 0;
int functions = 0;
int singleLineComments = 0;
int specical_chars = 0; 
int multiLineComments = 0;
int total = 0; // Total number of tokens 
int operator = 0;
int strs = 0;
int char_cons = 0;
int inst=0;

%}

%%

\n {lines++;}

("int")|("if")|("else")|("while")|("do")|("break") {total++; keywords++; printf("<KEYWORD, %s>\n", yytext);}

("continue")|("double")|("float")|("return")|("EOF") {total++; keywords++; printf("<KEYWORD, %s>\n", yytext);}

("char")|("case")|("sizeof")|("long")|("short") {total++; keywords++; printf("<KEYWORD, %s>\n", yytext);}

("typedef")|("switch")|("unsigned")|("void") {total++; keywords++; printf("<KEYWORD, %s>\n", yytext);}

("static")|("struct")|("goto") | ("return")  {total++; keywords++; printf("<KEYWORD, %s>\n", yytext);}

[0-9]+                  { printf("<INTEGER_CONSTANT, %s>\n", yytext); intg++;}

[a-zA-Z_][a-zA-Z0-9_]*  { printf("<IDENTIFIER, %s>\n", yytext); idn++; }

\"([^\\\n]|(\\.))*\"    { printf("<STRING_LITERAL, %s>\n", yytext); strs++;}

\'([^\\\n]|(\\.))*\'    { printf("<CHARACTER_CONSTANT, %s>\n", yytext); char_cons++;}

[ \t]                 ;  /* skip whitespace  */

"//"(.)*[\n]            ;  {printf("<SINGLE_LINE_COMMENT, %s>", yytext); singleLineComments++;}

"/*"([^*]|\n|(\*+([^*/]|\n)))*\*+"/" {printf("<MULTI_LINE_COMMENT, %s\n>", yytext); multiLineComments++;}

"#"|"@"|"$"|"^"|"%"|"^"|"&" { printf("<SPECIAL_SYMBOL, %s>\n", yytext); specical_chars++;}

[{|}|(|)|\[|\]|:|,] { printf("<SPECIAL_SYMBOL, %s>\n", yytext); specical_chars++;}

"="  {total++; printf("<ASSIGNMENT_OPERATOR: %s>\n",yytext);operator++;}

"+"|"-"|"*"|"/"  {total++; printf("<ARITHMATIC OPERATORS: %s>\n",yytext);operator++; total++;}

"&&" | "||" "!"  {total++; printf("<LOGICAL OPERATOR: %s>\n",yytext);operator++;}

"<="|">="|"++"|"!="|"=="|"<"|">"  {total++; printf("<RELATIONAL OPERATOR: %s>\n",yytext);operator++;}

[a-zA-Z_][a-zA-Z0-9_]*\( {total++; printf("<FUNCTION_CALL: %s>\n",yytext); total++; functions++;}


.   { printf("<INVALID_CHARACTER, %s at Line %d>\n", yytext, lines); }



%%

int yywrap() {
    return 1;
}

int main() {
    /*
        Author: Azim M Baldiwala - 22bce502@nirmauni.ac.in
    */
    yyin = fopen("input.txt", "r");
    yylex();
    fclose(yyin);

    printf("========================================================================\n");
    printf("========================================================================\n");
    printf("| Lexical Analysis of the input program:                                |\n");
    printf("| Total Number of Tokens: %d                                             |\n", total);
    printf("| Total Number of lines of code: %d                                      |\n", lines);
    printf("| keywords: %d                                                           |\n", keywords);
    printf("| Identifiers: %d                                                        |\n", idn);
    printf("| Special symbols: %d                                                    |\n", specical_chars);
    printf("| Operators: %d                                                          |\n", operator);
    printf("| Singleline Comments: %d                                                |\n", singleLineComments);
    printf("| Multiline Comments: %d                                                 |\n", multiLineComments);
    printf("| Function calls: %d                                                     |\n", functions);
    printf("| Integer Constants: %d                                                  |\n", intg);
    printf("| Character Constants: %d                                                |\n", char_cons);
    printf("| String Literals: %d                                                    |\n", strs);
    printf("========================================================================\n");
    printf("========================================================================\n");
    return 0;
}
