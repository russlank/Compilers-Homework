#include <iostream>

extern int yyparse();

int main(int argc, char **argv)
{
    yyparse();
    //std::cout << "Finished!" << std::endl;
    return 0;
}