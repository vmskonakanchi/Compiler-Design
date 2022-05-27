#ifndef __adresscode_h__
#define __adresscode_h__

#include <iostream>
#include <list>
using namespace std;
class TAC
{
private:
    string op, lhs, rhs, result;

public:
    void dump()
    {
        printf("%s = %s %s %s", result, lhs, op, rhs);
    }

    void setOp(string op)
    {
        this->op = op;
    }

    void setLhs(string lhs)
    {
        this->lhs = lhs;
    }

    void setRhs(string rhs)
    {
        this->rhs = rhs;
    }

    void setResult(string result)
    {
        this->result = result;
    }

    string getOp()
    {
        return this->op;
    }

    string getLhs()
    {
        return this->lhs;
    }

    string getRhs()
    {
        return this->rhs;
    }

    string getResult()
    {
        return this->result;
    }
};

class Expression : public TAC
{
public:
    Expression(string _op, string _y, string _z, string _result) : op(_op), lhs(_y), rhs(_z), result(_result) {}
};

class MethodCall : public TAC
{
public:
    MethodCall(string _f, string _n, string _result) : op("call"), lhs(_f), rhs(_n), result(_result) {}
};

class Jump : public TAC
{
public:
    Jump(string _label) : op("goto"), result(_label) {}
};

class CondJump : public TAC
{
public:
    CondJump(string _op, string _x, string _label) : op(_op), lhs(_x), result(_label) {}
};

class BBlock
{
public:
    string name;
    list<TAC *> tacInstructions;
    TAC condition;
    BBlock *trueExit, *falseExit;
    BBlock() : trueExit(NULL), falseExit(NULL) {}
};
