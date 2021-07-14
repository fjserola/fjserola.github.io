#pragma once
#include<iostream>
#include<string>
#include<fstream>
using namespace std;
class Shape {
	int obj_id;//�����ʶ��

	string des;//�������������

public:
	//���캯����������������ֵ���� 
	Shape(int id = 0, string name = "") :obj_id(id), des(name) {}
	Shape(const Shape& s) :obj_id(s.obj_id), des(s.des) {}
	Shape& operator=(const Shape& p) {
		obj_id = p.obj_id;
		des = p.des;
		return *this;
	}
	//��Ա���� 
	int GetId() const { return obj_id; }
	string GetDes() const { return des; }
	void IntDes(string name) {
		des = name;
	}

	virtual float Area() = 0;
	virtual void WriteToFile(ofstream& o) = 0;
};
