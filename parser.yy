%skeleton "lalr1.cc" 
%defines
%define parse.error verbose
%define api.value.type variant
%define api.token.constructor

%code requires{
  #include <string>
  #include "Node.h"
}
%code{
  #define YY_DECL yy::parser::symbol_type yylex()

  YY_DECL;
  
  Node* root;
  
}
// definition of set of tokens. All tokens are of type string
%token <std::string> PLUSOP MINUSOP MULTOP INT LP RP RSQUAREP LSQUAREP LBRACKET RBRACKET COMMA SEMICOLON EQUALS DIVISIONOP AND OR LESSER GREATER ASSIGNOP CLASS PUBLIC STATIC VOID MAIN STRING EXTENDS RETURN INTEGER BOOLEAN IF ELSE WHILE PRINT PERIOD LENGTH TRUE FALSE NEW NOT THIS IDENTIFIER
%token END 0 "end of file"

// definition of the production rules. All production rules are of type Node
%type <Node *> goal identifier expression expList statement stateList type varDec varList methodDec methodList classDec classList mainclass extends identifierList


%%

goal: mainclass{ $$ = $1; printf("R1 ");}
      | goal classList END{
        printf("R2 \n");
        $$ = new Node("GOAL","");
        $$->children.push_back($1);
        if($2) $$->children.push_back($2);
        root = $$;
      };
mainclass:CLASS identifier LBRACKET PUBLIC STATIC VOID MAIN LP STRING LSQUAREP RSQUAREP identifier RP LBRACKET statement RBRACKET RBRACKET{
          printf("R3 ");
          $$ = new Node ("Main Class","");
          $$->children.push_back(new Node("","CLASS"));
          $$->children.push_back($2);
          $$->children.push_back(new Node("","{"));
          $$->children.push_back(new Node("",$4));
          $$->children.push_back(new Node("","STATIC"));
          $$->children.push_back(new Node("","VOID"));
          $$->children.push_back(new Node("","MAIN"));
          $$->children.push_back(new Node("","("));
          $$->children.push_back(new Node("","STRING"));
          $$->children.push_back(new Node("","["));
          $$->children.push_back(new Node("","]"));
          $$->children.push_back($12);
          $$->children.push_back(new Node("",")"));
          $$->children.push_back(new Node("","{"));
          $$->children.push_back($15);
          $$->children.push_back(new Node("","}"));
          $$->children.push_back(new Node("","}"));
};
extends: {} 
| EXTENDS identifier{
            printf("R4 ");
            $$ = new Node("EXTENDS", "");
            $$->children.push_back(new Node("",""));
            $$->children.push_back($2);

};
classList: classDec{
            $$ = $1;
            printf("R5 ");
            }

|         classList classDec {
             printf("R6 "); 
             $$ = new Node("List of Class/es","");
             $$->children.push_back($1);
             $$->children.push_back($2);
};
classDec:CLASS identifier extends LBRACKET varList methodList RBRACKET{
            printf("R7 ");
            $$ = new Node("Class Declaration","");
            $$->children.push_back(new Node("","CLASS"));
            $$->children.push_back($2);
            if($3) $$->children.push_back($3);
            $$->children.push_back(new Node("","{"));
            if($5) $$->children.push_back($5);
            if($6) $$->children.push_back($6); 
            $$->children.push_back(new Node("","}"));
  }
  
| CLASS identifier extends LBRACKET methodList RBRACKET{
            printf("R7.1 ");
            $$ = new Node("Class Declaration","");
            $$->children.push_back(new Node("","CLASS"));
            $$->children.push_back($2);
            if($3) $$->children.push_back($3);
            $$->children.push_back(new Node("","{"));
            if($5) $$->children.push_back($5);
            //if($6) $$->children.push_back($6); 
            $$->children.push_back(new Node("","}"));
  }


| CLASS identifier extends LBRACKET varList RBRACKET{
            printf("R7.2 ");
            $$ = new Node("Class Declaration","");
            $$->children.push_back(new Node("","CLASS"));
            $$->children.push_back($2);
            if($3) $$->children.push_back($3);
            $$->children.push_back(new Node("","{"));
            if($5) $$->children.push_back($5);
            //if($6) $$->children.push_back($6); 
            $$->children.push_back(new Node("","}"));
  }


| CLASS identifier extends LBRACKET RBRACKET{
            printf("R7.3 ");
            $$ = new Node("Class Declaration","");
            $$->children.push_back(new Node("","CLASS"));
            $$->children.push_back($2);
            if($3) $$->children.push_back($3);
            $$->children.push_back(new Node("","{"));
            //if($5) $$->children.push_back($5);
            //if($6) $$->children.push_back($6); 
            $$->children.push_back(new Node("","}"));
  }
  ;
varList: varDec{
              $$ = $1;
              printf("R8 ");
}

|         varList varDec{
             printf("R9 "); 
             $$ = new Node("List of Variable/s","");
             $$->children.push_back($1);
             $$->children.push_back($2); 
};
varDec: type identifier SEMICOLON{
        printf("R10 ");
        $$ = new Node(" Variable Declaration", "");
        $$->children.push_back($1);
        $$->children.push_back($2);
        $$->children.push_back(new Node("",";"));
};
methodList: methodDec{
              $$ = $1;
              printf("R11 ");
}

|           methodList methodDec{
             printf("R12 "); 
             $$ = new Node("List of Method/s","");
             $$->children.push_back($1);
             $$->children.push_back($2); 
};
methodDec:   PUBLIC type identifier LP identifierList RP LBRACKET stateList RETURN expression SEMICOLON RBRACKET{
          printf("R13 ");
          $$ = new Node(" Method Declaration", "");
          $$->children.push_back(new Node("","Public"));
          $$->children.push_back($2);
          $$->children.push_back($3);
          $$->children.push_back(new Node("","("));
          if($5) $$->children.push_back($5);
          $$->children.push_back(new Node("",")"));
          $$->children.push_back(new Node("","{"));
          if($8) $$->children.push_back($8);
          $$->children.push_back(new Node("","Return"));
          $$->children.push_back($10);
          $$->children.push_back(new Node("",";"));
          $$->children.push_back(new Node("","}"));


}
| PUBLIC type identifier LP identifierList RP LBRACKET RETURN expression SEMICOLON RBRACKET{
          printf("R13.1 ");
          $$ = new Node(" Method Declaration", "");
          $$->children.push_back(new Node("","Public"));
          $$->children.push_back($2);
          $$->children.push_back($3);
          $$->children.push_back(new Node("","("));
          if($5) $$->children.push_back($5);
          $$->children.push_back(new Node("",")"));
          $$->children.push_back(new Node("","{"));
          //if($8) $$->children.push_back($8);
          $$->children.push_back(new Node("","Return"));
          $$->children.push_back($9);
          $$->children.push_back(new Node("",";"));
          $$->children.push_back(new Node("","}"));
}

methodDec:   PUBLIC type identifier LP identifierList RP LBRACKET varList stateList RETURN expression SEMICOLON RBRACKET{
          printf("R13.2 ");
          $$ = new Node(" Method Declaration", "");
          $$->children.push_back(new Node("","Public"));
          $$->children.push_back($2);
          $$->children.push_back($3);
          $$->children.push_back(new Node("","("));
          if($5) $$->children.push_back($5);
          $$->children.push_back(new Node("",")"));
          $$->children.push_back(new Node("","{"));
          if($8) $$->children.push_back($8);
          if($9) $$->children.push_back($9);
          $$->children.push_back(new Node("","Return"));
          $$->children.push_back($11);
          $$->children.push_back(new Node("",";"));
          $$->children.push_back(new Node("","}"));


}

methodDec:   PUBLIC type identifier LP identifierList RP LBRACKET RETURN expression SEMICOLON RBRACKET{
          printf("R13.3 ");
          $$ = new Node(" Method Declaration", "");
          $$->children.push_back(new Node("","Public"));
          $$->children.push_back($2);
          $$->children.push_back($3);
          $$->children.push_back(new Node("","("));
          if($5) $$->children.push_back($5);
          $$->children.push_back(new Node("",")"));
          $$->children.push_back(new Node("","{"));
          //if($8) $$->children.push_back($8);
          //if($9) $$->children.push_back($9);
          $$->children.push_back(new Node("","Return"));
          $$->children.push_back($9);
          $$->children.push_back(new Node("",";"));
          $$->children.push_back(new Node("","}"));


};

identifierList: {}
| type identifier{
                    printf("R14 ");
                    $$ = new Node("List of Identifier/s","");
                    $$->children.push_back($1);
                    $$->children.push_back($2); 
}

|              type identifier COMMA identifierList{
                    printf("R15 ");
                    $$ = new Node("List of Identifier/s","");
                    $$->children.push_back($1);
                    $$->children.push_back($2); 
                    $$->children.push_back(new Node("","Comma"));
                    $$->children.push_back($4); 

};
type: INTEGER LSQUAREP RSQUAREP{
          printf("R16 ");
          $$ = new Node("Array","");
          $$->children.push_back(new Node("","Integer"));
          $$->children.push_back(new Node("","["));
          $$->children.push_back(new Node("","]"));
}

|     BOOLEAN {
          printf("R17 ");
          $$ = new Node("Boolean","");          
}

|     INTEGER {
          printf("R18 ");
          $$ = new Node("Integer","");
}

|     identifier{
            $$ = $1;
            printf("R19 ");
};
stateList:  statement{
                  $$ = $1;
                  printf("R20 "); 
}

|          stateList statement{
                  printf("R21 ");
                  $$ = new Node("List of statement/s","");
                  $$->children.push_back($1);
                  $$->children.push_back($2); 
};
statement: varDec {$$ = $1; printf("R60");}
| LBRACKET stateList RBRACKET{
                  printf("R22 ");
                  $$ = new Node("Statement", "");
                  $$->children.push_back(new Node("","{"));
                  $$->children.push_back($2);
                  $$->children.push_back(new Node("","}"));

}
|           IF LP expression RP statement ELSE statement{
                  printf("R23 ");
                  $$ = new Node("If Else", "");
                  $$->children.push_back(new Node("","If"));
                  $$->children.push_back(new Node("","("));
                  $$->children.push_back($3);
                  $$->children.push_back(new Node("",")"));
                  $$->children.push_back($5);
                  $$->children.push_back(new Node("","Else"));
                  $$->children.push_back($7);

}
|           WHILE LP expression RP statement{
                  printf("R24 ");
                  $$ = new Node("While", "");
                  $$->children.push_back(new Node("",""));
                  $$->children.push_back(new Node("","("));
                  $$->children.push_back($3);
                  $$->children.push_back(new Node("",")"));
                  $$->children.push_back($5);
}
|           PRINT LP expression RP SEMICOLON {
                  printf("R25 ");
                  $$ = new Node("Print Statement", "");
                  $$->children.push_back(new Node("","Print"));
                  $$->children.push_back(new Node("","("));
                  $$->children.push_back($3);
                  $$->children.push_back(new Node("",")"));
                  $$->children.push_back(new Node("",";"));
}

|         identifier EQUALS expression SEMICOLON {
                  printf("R26 ");
                  $$ = new Node("Equation", "");
                  $$->children.push_back($1);
                  $$->children.push_back(new Node("","Equals to"));
                  $$->children.push_back($3);
                  $$->children.push_back(new Node("",";"));
}
|         identifier LSQUAREP expression RSQUAREP EQUALS expression SEMICOLON{
                  printf("R27 ");
                  $$ = new Node("Equating", "");
                  $$->children.push_back($1);
                  $$->children.push_back(new Node("","["));
                  $$->children.push_back($3);
                  $$->children.push_back(new Node("","]"));
                  $$->children.push_back(new Node("","Equals to"));
                  $$->children.push_back($6);
                  $$->children.push_back(new Node("",";"));

};
identifier: IDENTIFIER{
                printf("R52 %s ",$1.c_str());
                $$ = new Node ("Identifier",$1);
                

};
expList: expression{
                      $$ = $1;
                      printf("R28 ");
}

|                 expression COMMA expList{
                      printf("R29 ");
                      $$ = new Node("List of Expression/s", "");
                      $$->children.push_back($1);
                      $$->children.push_back(new Node("","Comma"));
                      $$->children.push_back($3);
};
expression:expression AND expression{
                printf("R30 ");
                $$ = new Node("AND", "");
                      $$->children.push_back($1);
                      $$->children.push_back(new Node("","and"));
                      $$->children.push_back($3);
}

| expression OR expression{
                printf("R31 ");
                $$ = new Node("OR", "");
                      $$->children.push_back($1);
                      $$->children.push_back(new Node("","or"));
                      $$->children.push_back($3);
}

| expression LESSER expression{
                printf("R32 ");
                $$ = new Node("Less than", "");
                      $$->children.push_back($1);
                      $$->children.push_back(new Node("","less than"));
                      $$->children.push_back($3);
}

| expression GREATER expression{
                printf("R33 ");
                $$ = new Node("Greater Than", "");
                      $$->children.push_back($1);
                      $$->children.push_back(new Node("","greater than"));
                      $$->children.push_back($3);
}

| expression ASSIGNOP expression{
                printf("R34 ");
                $$ = new Node("Assignment", "");
                      $$->children.push_back($1);
                      $$->children.push_back(new Node("","Assignment"));
                      $$->children.push_back($3);
}

| expression PLUSOP expression{
                printf("R35 ");
                $$ = new Node("Addition", "");
                      $$->children.push_back($1);
                      $$->children.push_back(new Node("","Addition"));
                      $$->children.push_back($3);
}

| expression MINUSOP expression{
                printf("R36 ");
                $$ = new Node("Subtraction", "");
                      $$->children.push_back($1);
                      $$->children.push_back(new Node("","Subtractiom"));
                      $$->children.push_back($3);
}

| expression MULTOP expression{
                printf("R37 ");
                $$ = new Node("Multiplication", "");
                      $$->children.push_back($1);
                      $$->children.push_back(new Node("","Multiplication"));
                      $$->children.push_back($3);
}

| expression DIVISIONOP expression{
                printf("R38 ");
                $$ = new Node("Dividion", "");
                      $$->children.push_back($1);
                      $$->children.push_back(new Node("","Division"));
                      $$->children.push_back($3);
}
| expression LSQUAREP expression RSQUAREP{
                printf("R39 ");
                $$ = new Node ("Vector","");
                $$->children.push_back($1);
                $$->children.push_back(new Node("","["));
                $$->children.push_back($3);
                $$->children.push_back(new Node("","]"));
}
| expression PERIOD LENGTH{
                printf("R40 ");
                $$ = new Node ("Length","");
                $$->children.push_back($1);
                $$->children.push_back(new Node("","Period"));
                $$->children.push_back(new Node("","length"));
}
| expression PERIOD identifier LP expList RP {
                printf("R41 ");
                $$ = new Node("withArguementsExpMethodCall","");
                $$->children.push_back($1);
                $$->children.push_back(new Node("","period"));
                $$->children.push_back($3);
                $$->children.push_back(new Node("","("));
                $$->children.push_back($5);
                $$->children.push_back(new Node("",")"));
}

| INT{
  printf("R42 ");
  $$ = new Node("Integer",$1);
}

| TRUE{
  printf("R43 ");
  $$ = new Node("True Statement","");
}

| FALSE{
  printf("R44 ");
  $$ = new Node("False Statement","");
}

| identifier{
  printf("R45 ");
  $$ = $1;
}

| THIS{
  printf("R46 ");
  $$ = new Node("This","");
}

| NEW INTEGER LSQUAREP expression RSQUAREP{
  printf("R47 ");
  $$ = new Node("Integer expression","");
  $$->children.push_back(new Node("",""));
  $$->children.push_back(new Node("","int"));
  $$->children.push_back(new Node("","["));
  $$->children.push_back($4);
  $$->children.push_back(new Node("","]"));
}

| NEW identifier LP RP{
  printf("R48 ");
  $$ = new Node("New identifier","");
  $$->children.push_back(new Node("","new"));
  $$->children.push_back($2);
  $$->children.push_back(new Node("","("));
  $$->children.push_back(new Node("",")"));
}

| expression PERIOD identifier LP RP {
  printf("R49 ");
  $$ = new Node("WithOutArguements","");
  $$->children.push_back($1);
  $$->children.push_back(new Node("","Period"));
  $$->children.push_back($3);
  $$->children.push_back(new Node("","("));
  $$->children.push_back(new Node("",")"));
}

| NOT expression{
  printf("R50 ");
  $$ = new Node("Not Exp","");
  $$->children.push_back(new Node("","!"));
  $$->children.push_back($2);
}

| LP expression RP{
  printf("R51 ");
  $$ = new Node("EXPRESSION","");
  $$->children.push_back(new Node("","("));
  $$->children.push_back($2);
  $$->children.push_back(new Node("",")"));
};

