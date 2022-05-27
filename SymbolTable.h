#include <map>
#include <list>
#include <iostream>

using namespace std;

class TableNode
{
public:
    string type;
    string value;
    string scope;
    TableNode() {}
    TableNode(string type, string value, string scope)
    {
        this->scope = scope;
        this->type = type;
        this->value = value;
    }
};

class SymbolTable
{
private:
    // using hashmap of strings as key and TableNode as an object
    map<string, TableNode *> table;

public:
    // insert a new table with given key value pairs
    void insert(string variableName, string scope, string type, string value)
    {
        TableNode *n = new TableNode(type, value, scope);
        table.insert({variableName, n});
    }

    // look up the given variable name in the given scope
    bool lookup(string variableName)
    {
        if (table.find(variableName) != table.end())
        {
            return true;
        }
        return false;
    }

    void modify(string scope, string variableName, string value, string type)
    {
        // modify the existing variable
        if (table.find(variableName) != table.end())
        {
            table.find(variableName)->second->scope = scope;
            table.find(variableName)->second->type = type;
            table.find(variableName)->second->value = value;
        }
        else
        {
            cout << "Error " << variableName << "Not Found " << endl;
        }
    }

    void print_table(void)
    {
        cout << "\n\n-------Symbol Table---------\n\n"
             << endl;

        cout << "Size is :" << table.size() << endl;
        for (auto j = table.begin(); j != table.end(); j++)
        {
            cout << "VariableName is :" << j->first << endl;
            cout << "Scope is :" << j->second->scope << endl;
            cout << "Type is  :" << j->second->type << endl;
            cout << "Value is :" << j->second->value << "\n\n"
                 << endl;
        }
        cout << "\n\n-------End of Symbol Table---------\n\n"
             << endl;
    }
};
