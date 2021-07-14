#pragma once
#include<iostream>
#include<string>
#include<fstream>
using namespace std;
class Shape {
	int obj_id;//对象标识符

	string des;//描述对象的特征

public:
	//构造函数，拷贝函数，赋值函数 
	Shape(int id = 0, string name = "") :obj_id(id), des(name) {}
	Shape(const Shape& s) :obj_id(s.obj_id), des(s.des) {}
	Shape& operator=(const Shape& p) {
		obj_id = p.obj_id;
		des = p.des;
		return *this;
	}
	//成员函数 
	int GetId() const { return obj_id; }
	string GetDes() const { return des; }
	void IntDes(string name) {
		des = name;
	}

	virtual float Area() = 0;
	virtual void WriteToFile(ofstream& o) = 0;
};
