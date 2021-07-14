#pragma once
#include<iostream>
#include<string>
#include<fstream>
#include<math.h>
#include"Shape.h"
#include<iomanip>
using namespace std;
class Point :public Shape {//������ 
	float x, y;
	static int count;
public:
	//���캯������������ ����ֵ���� 
	Point(int id = 0, float xx = 0, float yy = 0, string name = "") :Shape(id, name), x(xx), y(yy) {}
	Point(const Point& p) :Shape(p), x(p.x), y(p.y) {}
	virtual Point& operator=(const Point& p) {
		this->Shape::operator=(p);
		x = p.x;
		y = p.y;
		return *this;
	}
	//��������� 
	friend ostream& operator<<(ostream& o, const Point& p) {
		o << "Point:" <<p.GetId()<<setw(4) << "(" << p.x<< "," << p.y<< ") " << p.GetDes() <<setw(6)<< endl;
		return o;
	}
	friend bool operator<(const Point& p1,const Point& p2){
		if(p1.GetX()<p2.GetX()||(p1.GetX()==p2.GetX()&&p1.GetY()<p2.GetY())){
			return true;
		}
		else return false;
	}
	friend bool operator>(const Point& p1,const Point& p2){
		if(p1.GetX()<p2.GetX()||(p1.GetX()==p2.GetX()&&p1.GetY()<p2.GetY())){
			return false;
		}
		else return true;
	}
	friend Point operator+(const Point& p1,const Point& p2){
		return Point(p1.GetId(),p1.GetX()+p2.GetX(),p1.GetY()+p2.GetY(),p1.GetDes());
	}

	//Area 
	virtual float Area() {
		return 0;
	}
	//д���ļ����� 
	virtual void WriteToFile(ofstream& o);//��Ҫʵ�� 
	//��̬��Ա���� 
	static int GetCount() { return count; }
	static void inccount() {
		count++;
	}
	//����x��y���� 
	float GetX() const { return x; }
	float GetY() const { return y; }
	//��Ա����
	virtual float Distance (Point& p){
		return sqrt((this->x-p.x)*(this->x-p.x)+(this->y-p.y)*(this->y-p.y));
	} 
};
int Point::count = 0;
void Point::WriteToFile(ofstream& o) {
	o << "Point:" << this->GetId()<<setw(4)<< "(" << this->x<< "," << this->y<< ") " << this->GetDes()<<setw(6)<< endl;
}
