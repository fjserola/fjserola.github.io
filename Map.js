var markers = [];
var infoWindow = new AMap.InfoWindow({ offset: new AMap.Pixel(0, -30) });
var click_infor = [0, 0];
//初始化地图对象，加载地图
var map = new AMap.Map('container', {
    resizeEnable: true
});
map.on('click', function (e) {
    document.getElementById("click_location").value = e.lnglat.getLng() + ',' + e.lnglat.getLat();
    click_infor[0] = e.lnglat.getLng();
    click_infor[1] = e.lnglat.getLat();
});
var options = {
    'showButton': true,//是否显示定位按钮
    'buttonPosition': 'LB',//定位按钮的位置
    /* LT LB RT RB */
    'buttonOffset': new AMap.Pixel(10, 20),//定位按钮距离对应角落的距离
    'showMarker': true,//是否显示定位点
    'markerOptions': {//自定义定位点样式，同Marker的Options
        'offset': new AMap.Pixel(-18, -36),
        'content': '<img src="https://a.amap.com/jsapi_demos/static/resource/img/user.png" style="width:36px;height:36px"/>'
    },
    'showCircle': true,//是否显示定位精度圈
    'circleOptions': {//定位精度圈的样式
        'strokeColor': '#0093FF',
        'noSelect': true,
        'strokeOpacity': 0.5,
        'strokeWeight': 1,
        'fillColor': '#02B0FF',
        'fillOpacity': 0.25
    }
}
//获取地理位置 start
AMap.plugin('AMap.Geolocation', function () {
    var geolocation = new AMap.Geolocation(options);
    map.addControl(geolocation);
    geolocation.getCurrentPosition();
    AMap.event.addListener(geolocation, 'complete', onComplete);
    AMap.event.addListener(geolocation, 'error', onError);
});
function onComplete(success) {
    console.log(success);
    var loc_lat = success.position.lat;
    var loc_lng = success.position.lng;
    var array;//用于存储请求的信息
    var Http = new XMLHttpRequest();//这里可能要改成兼容的写法
    var url = 'https://site.maple.today/RubbishSeparator/MainMobile';
    Http.open("POST", url, false);
    Http.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    var data = 'requestCode=001&longitude=' + loc_lng + "&latitude=" + loc_lat;
    Http.send(data);
    Http.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            var res = Http.responseText;
            console.log(res);
            array = JSON.parse(res);
        }
        else {
            console.log(Http);
        }
    }
    Http.onreadystatechange();
    addMarker(array);
}
function onError(error) {
    console.log(error);
}

// 实例化点标记 start
function addMarker(array) {
    for (i in array) {
        marker = new AMap.Marker({
            icon: "http://webapi.amap.com/theme/v1.3/markers/n/mark_b.png",
            position: [array[i].longitude, array[i].latitude],
            offset: new AMap.Pixel(-13, -30),
            map: map,
        });
        var content = [];
        content.push("<h4>" + array[i].name + "</h4>");
        content.push("<p>经度:" + array[i].longitude + "</p>");
        content.push("<p>纬度:" + array[i].latitude + "</p>");
        content.push("<p>Id:" + array[i].Id + "</p>");
        content.push("<p>温度:" + "temp" + "</p>");
        content.push("<p>湿度:" + "water" + "</p>");
        content.push("<p>可燃气体浓度:" + "fire" + "</p>");
        content.push("<p>重量:" + "weight" + "</p>");
        content.push("<p>桶满状态:" + "state" + "</p>");
        content.push("<p>开合状态:" + "openstate" + "</p>");
        marker.content = content.join("");
        marker.on('click', markerClick);
        marker.emit('click', { target: marker });
        markers.push(marker);
    }
}
function markerClick(e) {
    infoWindow.setContent(e.target.content);
    infoWindow.open(map, e.target.getPosition());
}
//实例化点标记 end

function aroundMarker() {
    removeMarkers();
    AMap.plugin('AMap.Geolocation', function () {
        var geolocation = new AMap.Geolocation(options);
        map.addControl(geolocation);
        geolocation.getCurrentPosition();
        AMap.event.addListener(geolocation, 'complete', onComplete)
        AMap.event.addListener(geolocation, 'error', onError)
    });
}

function allMarker() {
    removeMarkers();
    var array;//用于存储请求的信息
    var Http = new XMLHttpRequest();//这里可能要改成兼容的写法
    var url = 'https://site.maple.today/RubbishSeparator/MainControl';
    Http.open("POST", url, false);
    Http.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    var data = 'requestCode=002';
    Http.send(data);
    Http.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            var res = Http.responseText;
            console.log(res);
            array = JSON.parse(res);
        }
        else {
            console.log(Http);
        }
    }
    Http.onreadystatechange();
    addMarker(array);
}
function removeMarkers() {
    map.remove(markers);
}
function loc_arround() {
    removeMarkers();
    var array;//用于存储请求的信息
    var Http = new XMLHttpRequest();//这里可能要改成兼容的写法
    var url = 'https://site.maple.today/RubbishSeparator/MainMobile';
    Http.open("POST", url, false);
    Http.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    console.log(click_infor);
    var data = 'requestCode=001&longitude=' + click_infor[0] + "&latitude=" + click_infor[1];
    Http.send(data);
    Http.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            var res = Http.responseText;
            console.log(res);
            array = JSON.parse(res);
        }
        else {
            console.log(Http);
        }
    }
    Http.onreadystatechange();
    addMarker(array);
}
