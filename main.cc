#include <iostream>
#include "parser.tab.hh"

extern Node *root;
extern FILE *yyin;

SymbolTable *table = new SymbolTable(); // creating a symboltable object

void yy::parser::error(std::string const &err)
{
  std::cout << "Cannot generate a syntax tree for this input: " << err << std::endl;
}

void lookAt(Node *root, int depth = 0)
{
  string type = root->type;
  string value = root->value;
  table->insert(type, value, type, value);
  for (auto i = root->children.begin(); i != root->children.end(); i++)
  {
    lookAt((*i), depth + 1);
  }
}

int main(int argc, char **argv)
{
  // Reads from file if a file name is passed as an argument. Otherwise, reads from stdin.
  if (argc > 1)
  {
    if (!(yyin = fopen(argv[1], "r")))
    {
      perror(argv[1]);
      return 1;
    }
  }

  yy::parser parser;
  if (!parser.parse())
  {
    Node *temp = root;
    lookAt(temp); // this does a post order traversel and populates the symbol table
    table->print_table(); // uncomment this to print the SymbolTable
    root->print_tree(); // uncomment this to print the AST(abstract syntax tree)
    root->generate_tree();
    char java[100] = "java ";
    const char *result = strcat(const_cast<char *>(java), argv[1]);
    cout << "\n\n Output is " << endl;
    system(result);
  }
  return 0;
}