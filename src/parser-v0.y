%{
    #define YY_NO_UNISTD_H

    #include <iostream>

    extern int yylex();
    void yyerror(const char *s) { printf("ERROR: %s\n", s); }
%}

%union {
    std::string *string;
    int token;
}

%token <string> TSTRING TLICENSESTRING TINTEGER TFEATUREID TDATESTRING
%token <token> TEQUAL TLBRACE TRBRACE TCOMMA TLPAREN TRPAREN
%token <token> TCAR TMODEL TLICENSE TDISTANCE TFEATURES TREPARATIONS TDATE TDESCRIPTION 

%start car

%debug

%%

car : TCAR TEQUAL TLBRACE car_info TRBRACE { std::cout << "car : TEQUAL TLBRACE car_info TRBRACE\n"; }
	;

car_info : model TCOMMA license TCOMMA distance TCOMMA features reparations { std::cout << "car_info : model TCOMMA license TCOMMA distance TCOMMA features reparations\n"; }
	;

model : TMODEL TEQUAL TSTRING { std::cout << "model : TMODEL TEQUAL TSTRING\n"; }
	;

license : TLICENSE TEQUAL TLICENSESTRING { std::cout << "license : TLICENSE TEQUAL TLICENSESTRING\n"; }
	;

distance : TDISTANCE TEQUAL TINTEGER { std::cout << "distance : TDISTANCE TEQUAL TINTEGER\n"; }
	;

features : TFEATURES TEQUAL TLBRACE features_list TRBRACE { std::cout << "features : TFEATURES TEQUAL TLBRACE features_list TRBRACE\n"; }
	| TFEATURES TEQUAL TLBRACE TRBRACE { std::cout << "features : TFEATURES TEQUAL TLBRACE TRBRACE\n"; }
	;

features_list : feature { std::cout << "features_list : feature\n"; }
	| features_list TCOMMA feature { std::cout << "features_list : features_list TCOMMA feature\n"; }
	;

feature : TFEATUREID TEQUAL TSTRING { std::cout << "feature : TFEATUREID TEQUAL TSTRING\n"; }
	;

reparations : TREPARATIONS TEQUAL TLBRACE reparation_list TRBRACE { std::cout << "reparations : TREPARATIONS TEQUAL TLBRACE reparation_list TRBRACE\n"; }
	| TREPARATIONS TEQUAL TLBRACE TRBRACE { std::cout << "reparations : TREPARATIONS TEQUAL TLBRACE TRBRACE\n"; }
	;

reparation_list : reparation_list TCOMMA reparation { std::cout << "reparation_list : reparation_list TCOMMA reparation\n"; }
	| reparation { std::cout << "reparation_list : reparation\n"; }
	;

reparation : TLPAREN TDATE TEQUAL TDATESTRING TCOMMA TDESCRIPTION TEQUAL TSTRING TRPAREN { std::cout << "reparation : TLPAREN TDATE TEQUAL TDATESTRING TCOMMA TDESCRIPTION TEQUAL TSTRING TRPAREN\n"; }
	;

%%





