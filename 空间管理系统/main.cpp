#pragma once
#include<iostream>
#include"Line.h"
#include<vector>
#include<algorithm>
string Toupp(string s){
	string new_s;
	for(int i = 0;i<s.length();i++){
		if(s[i]>='a'&&s[i]<='z'){
			new_s += s[i]+'A'-'a'; 
		}
		else new_s += s[i];
	}
	return new_s;
}

string Tolow(string s){
	string new_s;
	for(int i = 0;i<s.length();i++){
		if(s[i]>='A'&&s[i]<='Z'){
			new_s += s[i]+'a'-'A'; 
		}
		else new_s += s[i];
	}
	return new_s;
}

using namespace std;
int main() {
	vector<Point> Point_Array;
	vector<Rect>  Rect_Array;
	vector<Line>  Line_Array;
	ifstream pFile, rFile, lFile;
	pFile.open("Point.txt");
	rFile.open("Rect.txt");
	lFile.open("Line.txt");

	int id;
	float x1, x2, y1, y2, area, len;
	string name;

	Point p;
	for (;!pFile.eof();) {
		pFile >> id >> x1 >> y1 >> name;
		p = Point(id, x1, y1, name);
		Point_Array.push_back(p);
		Point::inccount();
	}


	id = 0;x1 = x2 = y1 = y2 = area = len = 0;name = "";

	Rect r;
	for (;!rFile.eof();) {
		rFile >> id >> x1 >> y1 >> x2 >> y2 >> area >> name;
		r = Rect(id, x1, y1, x2, y2, area, name);
		Rect_Array.push_back(r);
		Rect::inccount();
	}


	id = 0;x1 = x2 = y1 = y2 = area = len = 0;name = "Line";

	Line l;
	for (;!lFile.eof();) {
		lFile >> id >> x1 >> y1 >> x2 >> y2 >> len;
		l = Line(id, x1, y1, x2, y2, len, name);
		Line_Array.push_back(l);
		Line::inccount();
	}
	//******************任务二 圈1 
	cout << "Point:" << Point::GetCount() << endl;
	cout << "Rect:" << Rect::GetCount() << endl;
	cout << "Line:" << Line::GetCount() << endl;
	pFile.close();
	rFile.close();
	lFile.close();
	cout<<"***************任务二圈1结束********************"<<endl; 
	
	//******************任务二 圈3 
	vector<Point>::iterator Piter = Point_Array.begin();
	vector<Rect>::iterator Riter = Rect_Array.begin();
	vector<Line>::iterator Liter = Line_Array.begin();
	cout<<"***************在RECT中查找*******************"<<endl;
	Point test1(1,3128,2131,"hospital");
	for(;Riter!=Rect_Array.end();Riter++){
		if(Toupp(test1.GetDes()) == Riter->GetDes()){
			cout<<*Riter;
		}
	}
	Riter = Rect_Array.begin();
	cout<<"***************在POINT中查找*******************"<<endl;
	Rect test2(1,2341,12423,3425,43623,231,"shoppingmall");
	for(;Piter!=Point_Array.end();Piter++){
		if(Toupp(test2.GetDes()) == Piter->GetDes()){
			cout<<*Piter;
		}
	}
	Piter = Point_Array.begin(); 
	cout<<"*************任务二圈2结束************************" <<endl;
	 
	int MAX_NUM,MIN_NUM;
	MAX_NUM = MIN_NUM = 0;
	
	ofstream out_file1,out_file2;
	out_file1.open("Rect_data.txt");
	out_file2.open("Line_data.txt");
	float  area1 = Riter->Area();float  area2 = Riter->Area();
	for(;Riter!=Rect_Array.end();Riter++){
		if(Riter->Area() >= area1){
			area1 = Riter->Area();
			MAX_NUM = Riter->Shape::GetId();
		}
		else if(Riter->Area() <= area2){
			area2 = Riter->Area();
			MIN_NUM = Riter->Shape::GetId(); 
		}
	}
	Rect_Array[area2].WriteToFile(out_file1);
	Rect_Array[area1].WriteToFile(out_file1);
	
	float len1 = Liter->Area();float len2 = Liter->Area();
	for(;Liter!=Line_Array.end();Liter++){
		if(Liter->Area() >= len1){
			len1 = Liter->Area();
			MAX_NUM = Liter->Shape::GetId();
		}
		else if(Liter->Area() <= len2){
			len2 = Liter->Area();
			MIN_NUM = Liter->Shape::GetId(); 
		}
	}
	Line_Array[len2].WriteToFile(out_file2);
	Line_Array[len1].WriteToFile(out_file2);
	out_file1.close();
	out_file2.close();
	cout<<"************任务三结束************"<<endl;
	
	Point task3_1(1,2,3,"house");
	Point task3_2(1,2,4,"house");
	Point task3_3(1,3,2,"house");
	if(task3_1<task3_2){
	cout<<"task3_1 is smaller than task3_2"<<endl;
	}
	else{
	cout<<"task3_2 is smaller than task3_1"<<endl;
	}
	if(task3_3<task3_2){
		cout<<"task3_3 is smaller than task3_2"<<endl;
	}
	else{
		cout<<"task3_2 is smaller than task3_3"<<endl; 
	}
	
	cout<<task3_1+task3_2<<endl;
	cout<<Rect_Array[0]+Rect_Array[1]<<endl;
	cout<<"*************任务四结束*************"<<endl;
    cout<<Point_Array[0].Distance(Point_Array[1])<<endl;
    cout<<Rect_Array[0].Distance(Rect_Array[1])<<endl;
    cout<<Line_Array[0].Distance(Line_Array[1])<<endl;
    cout<<Rect_Array[0].Distance_R(Point_Array[1])<<endl;
    cout<<Line_Array[0].Distance_L(Point_Array[1])<<endl;
    cout<<"************任务五结束***************"<<endl;
    
    
    ofstream pFile1; pFile1.open("Point2.txt");   if(pFile){cout<<"成功打开"<<endl;}
    ofstream rFile1; rFile1.open("Rect2.txt");    if(rFile){cout<<"成功打开"<<endl;}
    ofstream lFile1; lFile1.open("Line2.txt");    if(lFile){cout<<"成功打开"<<endl;}
    sort(Point_Array.begin(),Point_Array.end());
    cout<<"排序成功"<<endl;
    for(Piter = Point_Array.begin();Piter != Point_Array.end();Piter++){
    	Piter->IntDes(Tolow(Piter->GetDes()));
    	Piter->WriteToFile(pFile1);
	}
	cout<<"写入成功"<<endl;
	sort(Rect_Array.begin(),Rect_Array.end());
	for(Riter = Rect_Array.begin();Riter!=Rect_Array.end();Riter++){
		Riter->WriteToFile(rFile1);
	}
	
	sort(Line_Array.begin(),Line_Array.end());
	for(Liter = Line_Array.begin();Liter!=Line_Array.end();Liter++){
		Liter->WriteToFile(lFile1);
	}
	cout<<"**********任务六结束************"<<endl;
}
