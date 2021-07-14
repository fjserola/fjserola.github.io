#pragma once
#include<iostream>
#include<string>
#include<fstream>
#include"Point.h"
#include<math.h>
#include <iomanip>
#include<string.h>
using namespace std;
class Rect :public Shape {
	Point lp;//左下角
	Point rp;//右下角
	float area;
	static int count;
public:
	//成员函数 
	virtual float Area();//需要实现
	virtual void WriteToFile(ofstream& o);//需要实现
	virtual float Distance(Rect& r);
	float Distance_R(Point& p){
		float dis1,dis2;
		dis1 = this->lp.Distance(p);
		dis2 = this->rp.Distance(p);
		if(dis1>dis2){
			return dis2;
		}
		else return dis1;
		}
	//构造函数，拷贝函数，赋值函数 
	Rect(int id = 0, float x1 = 0, float y1 = 0, float x2 = 0, float y2 = 0, float a = 0, string name = "") :Shape(id, name), lp(id, x1, y1, name), rp(id, x2, y2, name), area(a) {}
	Rect( const Rect& r) :Shape(r), lp(r.lp), rp(r.rp), area(r.area) {}
	Rect& operator=(const Rect& r) {
		Shape::operator=(r);
		lp = r.lp;
		rp = r.rp;
		area = r.area;
		return *this;
	}
	//运算符重载
	friend ostream& operator<<(ostream& o,const Rect& r) {
		o << "Rect:" << r.Shape::GetId()<<setw(4) << "(" << r.lp.GetX()<< "," << r.lp.GetY() << ") (" << r.rp.GetX()<< "," << r.rp.GetY()<< ") " << r.Shape::GetDes()<<setw(6) << endl;
		return o;
	}
	friend Rect operator+(const Rect& r1, const Rect& r2){
		if(r1.lp>r2.lp){
			if(r1.rp>r2.rp){
				return Rect(r1.GetId(),r2.lp.GetX(),r2.lp.GetY(),r1.rp.GetX(),r1.rp.GetY(),sqrt((r2.lp.GetX() - r1.rp.GetX()) * (r2.lp.GetX() - r1.rp.GetX()) * (r2.lp.GetY() - r1.rp.GetY()) * (r2.lp.GetY() - r1.rp.GetY())),r1.GetDes());
			}
			else{
				return Rect(r1.GetId(),r2.lp.GetX(),r2.lp.GetY(),r2.rp.GetX(),r2.rp.GetY(),sqrt((r2.lp.GetX() - r2.rp.GetX()) * (r2.lp.GetX() - r2.rp.GetX()) * (r2.lp.GetY() - r2.rp.GetY()) * (r2.lp.GetY() - r2.rp.GetY())),r1.GetDes());
			}
		}
		else if(r1.lp<r2.lp){
			if(r1.rp>r2.rp){
				return Rect(r1.GetId(),r1.lp.GetX(),r1.lp.GetY(),r1.rp.GetX(),r1.rp.GetY(),sqrt((r1.lp.GetX() - r1.rp.GetX()) * (r1.lp.GetX() - r1.rp.GetX()) * (r1.lp.GetY() - r1.rp.GetY()) * (r1.lp.GetY() - r1.rp.GetY())),r1.GetDes());
			}
			else{
				return Rect(r1.GetId(),r1.lp.GetX(),r1.lp.GetY(),r2.rp.GetX(),r2.rp.GetY(),sqrt((r1.lp.GetX() - r2.rp.GetX()) * (r1.lp.GetX() - r2.rp.GetX()) * (r1.lp.GetY() - r2.rp.GetY()) * (r1.lp.GetY() - r2.rp.GetY())),r1.GetDes());
			}
		}
	}
	friend bool operator<(Rect& r1, Rect& r2){
		if(strcmp(r1.GetDes().c_str(),r2.GetDes().c_str())){
			return false;
		}
		else return true;
	}
	//静态成员函数
	static int GetCount() { return count; }
	static void inccount() {
		count++;
	}
};
int Rect::count = 0;
float Rect::Area() {
	float Area;
	Area = sqrt((lp.GetX() - rp.GetX()) * (lp.GetX() - rp.GetX()) * (lp.GetY() - rp.GetY()) * (lp.GetY() - rp.GetY()));
	return Area;
}
void Rect::WriteToFile(ofstream& o) {
	o << "Rect: " << this->Shape::GetId()<<setw(4) << "  (" << lp.GetX()<< "," << lp.GetY()<< ") (" << rp.GetX() << "," << rp.GetY()<< ")  " << this->Shape::GetDes()<<setw(6) << endl;
}
float Rect::Distance(Rect& r){
	float dis1,dis2;
	dis1 = this->lp.Distance(this->rp);
	dis2 = r.lp.Distance(r.rp);
	if(dis1>dis2){
		return dis2;
	}
	else return dis1;
}
