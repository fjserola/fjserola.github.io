var test = [
    { temp: 21.2, water: 0.2, fire: 0.01, weight: 21, state: 0, openstate: 0 },
    { temp: 24.2, water: 0.3, fire: 0.01, weight: 22, state: 1, openstate: 0 },
    { temp: 22.6, water: 0.2, fire: 0.01, weight: 17, state: 1, openstate: 1 },
    { temp: 21.8, water: 0.2, fire: 0.03, weight: 5, state: 1, openstate: 0 },
    { temp: 21.5, water: 0.1, fire: 0.01, weight: 12, state: 1, openstate: 0 },
    { temp: 22.4, water: 0.2, fire: 0.01, weight: 21, state: 0, openstate: 1 },
    { temp: 22.7, water: 0.5, fire: 0.02, weight: 31, state: 0, openstate: 0 },
    { temp: 23.5, water: 0.2, fire: 0.01, weight: 4, state: 1, openstate: 0 },
    { temp: 24.1, water: 0.1, fire: 0.00, weight: 15, state: 1, openstate: 1 },
    { temp: 21.9, water: 0.2, fire: 0.01, weight: 30, state: 0, openstate: 0 },
    { temp: 21.2, water: 0.2, fire: 0.01, weight: 9, state: 0, openstate: 0 },
]
// function GetInfor() {
onload = function () {
    //getinformation in http
    //基础数据 start
    var longitude;//经度
    var latitude;//纬度
    var Id;
    var name;
    var temp = "null";//垃圾桶实时温度
    var water = "null";//垃圾桶实时湿度
    var fire = "null";//垃圾桶实时可燃性气体浓度
    var weight = "null";//垃圾桶重量
    var state = "null";//垃圾桶桶满状态
    var openstate = "null";//垃圾桶开合状态
    //基础数据 end

    var text = document.getElementById("activeTable");
    text.innerHTML = "";//清空
    var string = "";
    var Table_Http = new XMLHttpRequest();
    var array;
    var url = [
        'https://site.maple.today/RubbishSeparator/MainMobile',//url_1
        'https://site.maple.today/RubbishSeparator/MainControl',//url_2
        'https://site.maple.today/RubbishSeparator/SMS'];//url_3
    Table_Http.open("POST", url[1], false);
    Table_Http.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    Table_Http.send('requestCode=002');
    Table_Http.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            var res = Table_Http.responseText;
            console.log(JSON.parse(res));
            array = JSON.parse(res);
        }
        else {
            console.log(Table_Http);
        }
    }
    Table_Http.onreadystatechange();
    //getinformation in http

    //get bin information
    var BinString = "requestCode=004&can_id=";
    var Bin_Http = new XMLHttpRequest();

    for (i in array) {
        Bin_Http.open("POST", url[0], false);
        Bin_Http.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        Bin_Http.send(BinString + array[i].Id);
        console.log(BinString + array[i].Id);
        Bin_Http.BinInformation = function () {
            if (this.readyState == 4 && this.status == 200) {
                var res = Bin_Http.responseText;
                console.log(res);
            }
            else {
                console.log(Bin_Http);
            }
        }
        Bin_Http.BinInformation();
    }
    //get bin information

    //active create table
    for (i in array) {
        longitude = array[i].longitude;
        latitude = array[i].latitude;
        Id = array[i].Id;
        name = array[i].name;
        /*
        暂时省略数据
        */
        string += "<tr><td>" + longitude + "</td>";
        string += "<td>" + latitude + "</td>";
        string += "<td>" + Id + "</td>";
        string += "<td>" + name + "</td>";
        string += "<td>" + test[i].temp + "</td>";
        string += "<td>" + test[i].water + "</td>";
        string += "<td>" + test[i].fire + "</td>";
        string += "<td>" + test[i].weight + "</td>";
        string += "<td>" + STATE(test[i].state) + "</td>";
        string += "<td>" + OPENSTATE(test[i].openstate) + "</td></tr>";
    }
    text.innerHTML = string;
    //active create table
}

function STATE(state) {
    if (state == 1)
        return "已满";
    else
        return "未满";
}
function OPENSTATE(openstate) {
    if (openstate == 1)
        return "打开";
    else
        return "关闭"

}

// }
//question can_id