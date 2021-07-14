#pragma once
#include<iostream>
#include<string>
#include<fstream>
#include"Rect.h"
#include<math.h>
#include <iomanip>
using namespace std;
class Line :public Shape {//派生类Line.txt不包含des,因此设置为"Line"or empty 
	Point p1;
	Point p2;
	double len;
	static int count;
public:
	virtual float Area();//需要实现求解长度 
	virtual void WriteToFile(ofstream& o);//需要实现
	virtual float Distance(Line& l);
	float Distance_L(Point& p){
		float dis1,dis2;
		dis1 = this->p1.Distance(p);
		dis2 = this->p2.Distance(p);
		if(dis1>dis2){
			return dis2;
		}
		else return dis1;
		}
	//构造函数，拷贝函数，赋值函数
	Line(int id = 0, float x1 = 0, float y1 = 0, float x2 = 0, float y2 = 0, double l = 0, string name = "Line") :Shape(id, name), p1(id, x1, y1, name), p2(id, x2, y2, name), len(l) {}
	Line(const Line& l) {
		Shape::operator=(l);
		p1 = l.p1;
		p2 = l.p2;
		len = l.len;
	}
	Line& operator=(const Line& l) {
		Shape::operator=(l);
		p1 = l.p1;
		p2 = l.p2;
		len = l.len;
		return *this;
	}
	//运算符重载
	friend ostream& operator<<(ostream& o,const Line& l) {
		o << "Line: " << l.Shape::GetId()<<setw(4) << "  (" << l.p1.GetX() << "," << l.p1.GetY()<< ") (" << l.p2.GetX() << "," << l.p2.GetY() << ")  " << l.len<<setw(6) << endl;
		return o;
	}
	friend bool operator<(Line& l1,Line& l2){
		if(l1.len<l2.len){
			return true;
		}
		else return false;
	}
	//静态成员函数
	static int GetCount() { return count; }
	static void inccount() {
		count++;
	}
};
int Line::count = 0;
float Line::Area() {
	float len;
	len = sqrt((p1.GetX() - p2.GetX()) * (p1.GetX() - p2.GetX()) + (p1.GetY() - p2.GetY()) * (p1.GetY() - p2.GetY()));
	return len;
}
void Line::WriteToFile(ofstream& o) {
	o << "Line: " << this->Shape::GetId()<<setw(6) << "  (" << p1.GetX() << "," << p1.GetY()<< ") (" << p2.GetX() << "," << p2.GetY() << ")  " << len<<setw(6) << endl;
}
float Line::Distance(Line& l){
	float dis1,dis2;
	dis1 = this->p1.Distance(this->p2);
	dis2 = l.p1.Distance(l.p2);
	if(dis1>dis2){
		return dis2;
	}
	else return dis1;
}
