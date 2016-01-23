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

car : car_prefix TLBRACE car_info TRBRACE { std::cout << "</car>" << std::endl; }
	;
	
car_prefix : TCAR TEQUAL { std::cout << "<car>" << std::endl; }
	;

car_info : model TCOMMA license TCOMMA distance TCOMMA features reparations { }
	;

model : model_prefix TSTRING { std::cout << $2->substr(1, $2->length() - 2).c_str() << "</model>" << std::endl; delete $2}
	;
	
model_prefix : TMODEL TEQUAL { std::cout << "\t<model>"; }
	;

license : license_prefix TLICENSESTRING { std::cout << $2->substr(1, $2->length() - 2).c_str() << "</license>" << std::endl; delete $2; }
	;
	
license_prefix : TLICENSE TEQUAL { std::cout << "\t<license>"; }
	;

distance : distance_prefix TINTEGER { std::cout << $2->c_str() << "</distance>" << std::endl; delete $2; }
	;
	
distance_prefix : TDISTANCE TEQUAL { std::cout << "\t<distance>"; }
	;

features : features_prefix TLBRACE features_list TRBRACE { std::cout << "\t</features>" << std::endl; }
	| features_prefix TLBRACE TRBRACE { std::cout << "\t</features>" << std::endl; }
	;
	
features_prefix : TFEATURES TEQUAL { std::cout << "\t<features>" << std::endl; }
	;

features_list : feature { }
	| features_list TCOMMA feature { }
	;

feature : TFEATUREID TEQUAL TSTRING { std::cout << "\t\t<" << $1->c_str() << ">" << $3->substr(1, $3->length() - 2).c_str() << "</" << $1->c_str() << ">"<< std::endl; delete $1; delete $3; }
	;

reparations : reparations_prefix TLBRACE reparation_list TRBRACE { std::cout << "\t</reparations>" << std::endl; }
	| reparations_prefix TLBRACE TRBRACE { std::cout << "\t</reparations>" << std::endl; }
	;
	
reparations_prefix : TREPARATIONS TEQUAL { std::cout << "\t<reparations>" << std::endl; }
	;

reparation_list : reparation_list TCOMMA reparation { }
	| reparation { }
	;

reparation : TLPAREN TDATE TEQUAL TDATESTRING TCOMMA TDESCRIPTION TEQUAL TSTRING TRPAREN { std::cout << "\t\t<reparation>" << std::endl << "\t\t\t<date>" << $4->substr(1, $4->length() - 2).c_str() << "</date>" << std::endl << "\t\t\t<description>" << $8->substr(1, $8->length() - 2).c_str() << "</description>" << std::endl << "\t\t</reparation>" << std::endl; delete $4; delete $8; }
	;

%%





