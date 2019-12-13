import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../main.dart';

var now2 = new DateTime.now();
var y = now2.year;
var date1 = new DateFormat("yyyy-MM-dd hh:mm:ss").format(now2);
var now3;

var strg_fullname = storage.getItem("stor_fullname");

//var strg_empCode = storage.getItem("stor_empCode");
var strg_empCode = storage.getItem("stor_empCode"); //code ใน employee

var strg_employeeNo = storage.getItem("stor_employeeNo");
var strg_token = storage.getItem("stor_token");
//              print( " Storage token response : " + strg_token );
var strg_tokenExpire = storage.getItem("stor_tokenExpire");
var strg_gettoIMEI = storage.getItem("stor_gettoIMEI");
var strg_phoneNumber = storage.getItem("stor_phoneNumber");
var strg_simSerialNumber = storage.getItem("stor_simSerialNumber");
var strg_deviceId = storage.getItem("stor_deviceId");

var strg_cur_latitude = storage.getItem("stor_cur_latitude");
var strg_cur_longitude = storage.getItem("stor_cur_longitude");

var strg_checkInKKH = storage.getItem("stor_checkInKKH");
//var strg_str_ans = storage.getItem("stor_str_ans");

//storage.setItem("stor_checkInKKH", checkInKKH);
//storage.setItem("stor_str_ans", str_ans);

var stor_checkInKKH = storage.getItem("stor_checkInKKH");
var stor_str_ans = storage.getItem("stor_str_ans");

var stor_area_status = storage.getItem("stor_area_status"); //1=อยู่ใน,0=อยู่นอก

var area_status; //1=อยู่ในพื้นที่,0=อยู่นอกพื้นที่

var VERIFYCODE; //0=เข้า,1=ออก
var VERIFYCODE_datail;
var timelog; //เวลาที่ระบบบันทึกข้อมูล

var time_period; //กะการเข้างานแบ่งตาม 1-6

var ip2 = "http://10.3.42.21:3008/";

var SENSORID = 99;

List<String> exitem = ["1", "2", "3", "4"];

class Atoffice2 extends StatefulWidget {
  @override
  _Atoffice2State createState() => _Atoffice2State();
}

class _Atoffice2State extends State<Atoffice2> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: MaterialApp(
      title: 'เข้าสู่ระบบลงเวลา ',
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'เวลาที่เข้าสู่ระบบ : ' + date1.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.wifi_tethering,
                size: 35,
                color: Colors.white,
              ),
              tooltip: 'Alert in system',
              onPressed: () {
                print('test search');
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: new Text("TakeoffAndroid"),
                accountEmail: new Text("takeoffandroid@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.yellow,
                  child: Text('T', style: TextStyle(color: Colors.black87)),
                ),
              ),
              new ListTile(
                  leading: Icon(Icons.home),
                  title: new Text("Home"),
                  onTap: () {
                    Navigator.pop(context);
                  }),
              new ListTile(
                  leading: Icon(Icons.person),
                  title: new Text("Friends"),
                  onTap: () {
                    Navigator.pop(context);
                  }),
              new ListTile(
                  leading: Icon(Icons.share),
                  title: new Text("Share"),
                  onTap: () {
                    Navigator.pop(context);
                  }),
              new Divider(),
              new ListTile(
                  leading: Icon(Icons.settings),
                  title: new Text("Settings"),
                  onTap: () {
                    Navigator.pop(context);
                  }),
              new ListTile(
                  leading: Icon(Icons.power_settings_new),
                  title: new Text("Logout"),
                  onTap: () {
                    Navigator.pop(context);
                  }),
            ],
          ),
        ),
        body: Container(
          child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(0.0),
//                  color: Colors.cyanAccent,
                        width: 55.0,
                        height: 55.0,
                        child:

                            /*
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text(
                      'เข้า',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ),
                    */

                            IconButton(
                          onPressed: () {
//                      debugPrint("Starred Me!");
                            getChckinout(context);
                          },
                          color: Colors.black,
                          icon: Icon(
                            Icons.loop,
                            size: 45,
                          ),
                          disabledColor: Colors.red,
                          highlightColor: Colors.black,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(0.0),
//                  color: Colors.blueAccent,
                        width: 55.0,
                        height: 55.0,
                        child: IconButton(
                          onPressed: () {
                            debugPrint("Starred Me!");
                          },
                          color: Colors.black,
                          icon: Icon(
                            Icons.first_page,
                            size: 45,
                          ),
                          disabledColor: Colors.red,
                          highlightColor: Colors.black,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(0.0),
//                  color: Colors.orangeAccent,
                        width: 55.0,
                        height: 55.0,
                        child: IconButton(
                          onPressed: () {
                            debugPrint("Starred Me!");
                          },
                          color: Colors.black,
                          icon: Icon(
                            Icons.last_page,
                            size: 45,
                          ),
                          disabledColor: Colors.red,
                          highlightColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          width: 130.0,
                          height: 70.0,
                          color: Colors.white,
                          child: RaisedButton(
                            onPressed: () {},
                            child: Text(
                              'เข้า',
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            ),
                            color: Colors.blue,
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(15.0)),
                          )),
                      /*
                      Container(
                        width: 130.0,
                        height: 70.0,
                        color: Colors.grey,
                        child: Text('B'),
                      ),
                       */
                      Container(
                          width: 130.0,
                          height: 70.0,
                          color: Colors.white,
                          child: RaisedButton(
                            onPressed: () {},
                            child: Text(
                              'ออก',
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            ),
                            color: Colors.blue,
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(15.0)),
                          )),
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Column(children: <Widget>[
                        Card(
                            child: ListTile(
                          leading: Icon(Icons.fingerprint,
                              size: 35, color: Colors.grey),
                          trailing: IconButton(
                            icon: Icon(Icons.watch, size: 20),
                            tooltip: 'Increase volume by 10',
                          ),
                          title: Text(
                            'เข้า - ออก ',
                            style:
                                TextStyle(color: Colors.black, fontSize: 20.0),
                          ),
                          subtitle:
                              const Text('เวลาเข้า 08:00 - เวลาออก 16:00 '),
                          enabled: true,
                          dense: false,
                          selected: true,
                          onLongPress: () {
                            print('onLongPress');
                          },
                          onTap: () {},
                        )),
                        Card(
                          child: ListView.builder(
                            itemCount: exitem.length,
                            itemBuilder: (BuildContext context, int index) {
                              return new Text(exitem[index]);
                            },
                          ),
                        ),
                      ])),
                ],
              )),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Container(
            height: 50.0,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => setState(() {
//            getChckinout(context);
          }),
          tooltip: 'Back System',
          backgroundColor: Colors.white,
          child: Icon(
            Icons.reply_all,
            color: Colors.blue,
            size: 30.0,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    ));
  }

  Future getChckinout(BuildContext context) async {
    if (stor_checkInKKH) {
      area_status = 1;
      VERIFYCODE = 0; //0=เข้า, 1=ออก
      time_period = 2; //1=กะ1
      VERIFYCODE_datail = '(เข้า)';
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd hh:mm:ss').format(now);

      var timelog =
          DateFormat('yyyy-MM-dd hh:mm:ss').format(now2); //เวลาในการบันทึกระบบ

      //-- เรียก จาก userinfo  เพื่อเรียก Badgenumber จาก เลขที่เงินเดือน---
      // ตัวอย่างการเรียก ssn=>http://192.168.1.25:3008/userinfo/A1631
      var urlssn = ip2 + "userinfo/" + strg_employeeNo;

      final headers = {'Content-Type': 'application/json'};

      final response2 = await http.get(
        urlssn,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      );
      var jsonDecoded2 = json.decode(response2.body);
      var rows = jsonDecoded2['rows'];

      var arrsplit = rows.toString().split(",");
      var strBadgenumber = arrsplit[1].toString();
      var arrsplit2 = strBadgenumber.split(":");

      var Badgenumber = arrsplit2[1].toString();
//      strg_employeeNo =>เลขที่เงินเดือน

      //--ต่อไปคือการเรียก tb=>checkinout จาก Badgenumber
      var url_query_checkinout = ip2 + "checkinout/Badge/" + Badgenumber;
      final response3 = await http.get(
        url_query_checkinout,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      );
      var jsonDecoded3 = json.decode(response3.body);
      var rows3 = jsonDecoded3["rows"];

      print(rows3.toString());

      var alertDialog = AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(15.0)),
//              side: BorderSide(color: Colors.black)),
        contentPadding: EdgeInsets.only(top: 0.0),

        content: Container(
          width: 500,
          height: 300,
          child: Column(
            children: <Widget>[
              Text(rows3.toString()),
            ],
          ),
        ),

        title: Text('สถานะของ Server '),
      );
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return alertDialog;
          });
    } else {}
  }

  /*
  Future sendValue(BuildContext context) async {
    //ตัวอย่างการเรียกใช้งาน
    var timelog =
    DateFormat('yyyy-MM-dd hh:mm:ss').format(now2); //เวลาในการบันทึกระบบ

//    var urlbackend = "http://10.3.42.21:3008/apptime/";
    var urlbackend = ip + "apptime/";
//    var urlbackend2 = "http://10.3.42.163:3008/usertimelog/";
    var urlssn = ip + "userinfo/" + strg_employeeNo;

    var url_inst_profile = ip + "apptime/code/" + strg_employeeNo;
    // ตัวอย่างการเรียก ssn=>http://192.168.1.25:3008/userinfo/A1631

    final headers = {'Content-Type': 'application/json'};

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd hh:mm:ss').format(now);

    //------get ssn=>urlssn http://192.168.1.25:3008/userinfo/A1631---
    final response2 = await http.get(
      urlssn,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );
    var jsonDecoded2 = json.decode(response2.body);
    var resultssn = jsonDecoded2['rows'];
    var ssnhead = resultssn.toString().substring(1);
    var ssntail = ssnhead.toString().replaceAll(new RegExp(']'), '');
    var ssnarr = ssntail.split(",");
    var badgearr = ssnarr[1];
    var BadgenumberARR = badgearr.split(":"); //Badgenumber ของพนักงาน
    var Badgenumber = BadgenumberARR[1];
    //------get ssn=>urlssn http://192.168.1.25:3008/userinfo/A1631---

    //-----------------------insert tb=>userprofile--------------------
    //http://192.168.1.25:3008/apptime/code/A1631

    Map<String, dynamic> body = {
      "employeeCode": strg_empCode,
      "employeeNo": strg_employeeNo,
      "IMEI": strg_gettoIMEI,
      "simserial": strg_simSerialNumber,
      "deviceID": strg_deviceId,
      "timelog": formattedDate,
      "Badgenumber": Badgenumber,
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');
    final response = await http.post(
      urlbackend,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: jsonBody,
      encoding: encoding,
    );
    var jsonDecoded = json.decode(response.body);

    var checkstatus = jsonDecoded['ok'];

    var result = jsonDecoded['result'];
    var id_head = result.toString().substring(1);
    var id_user = id_head.toString().replaceAll(new RegExp(']'), '');
//    var id_user_int = int.parse(id_user.toString());

    /*var alertDialog = AlertDialog(
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
//              side: BorderSide(color: Colors.black)),
      contentPadding: EdgeInsets.only(top: 0.0),
      content: Container(
        width: 200,
        height: 50,
        child: Column(
          children: <Widget>[
            Text(id_user.toString()),
          ],
        ),
      ),

      title: Text('Server response'),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });*/

    //---มี user นี้แล้ว ใน userprofile---------
    if (id_user == 'ull') {
      //--------- get ค่าเพื่อหา จาก เลขที่เงินเดือน ค้าหาจาก   this.tableName = 'app_time.userprofile';
/*  ส่งค่าไปเทส
{"ok":true,"rows":[{"id_user":385,"employeeCode":88370,"employeeNo":"A1631","IMEI":"864394020164945","simserial":"89014103211649460193","deviceID":"864394020164945","timelog":"2019-11-11 11:17:40","Badgenumber":4697}]}
*/

//http://10.3.42.21:3008/apptime/device =>post
      /*{
        "data":{
    "employeeNo":"A1631",
    "IMEI":"864394020164945",
    "simserial":"89014103211649460193",
    "deviceID":"864394020164945"
    }
    }*/
      var url_checkuser = ip + "apptime/device";
      Map<String, dynamic> bodycheckuser = {
        "data": {
          "employeeNo": strg_employeeNo,
          "IMEI": strg_gettoIMEI,
          "simserial": strg_simSerialNumber,
          "deviceID": strg_deviceId
        }
      };
      var url_userid = ip + "apptime/device/";
      String jsonBodycheckuser = json.encode(bodycheckuser);
      final response33 = await http.post(
        url_userid,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonBodycheckuser,
        encoding: encoding,
      );
      var jsonDecoded33 = json.decode(response33.body);
      var status_checkuser = jsonDecoded33['ok']; // ture บันทึกผลได้
      var checkuserrow = jsonDecoded33['rows'];
      var arrJson33 = checkuserrow.toString().split(",");
      var arr2Json33 = arrJson33[0].toString().split(":");
      var id_user_tb33 = arr2Json33[1].toString();

//      print(bodycheckuser);

      /*
      var alertDialog = AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(15.0)),
//              side: BorderSide(color: Colors.black)),
        contentPadding: EdgeInsets.only(top: 0.0),
        content: Container(
          width: 200,
          height: 50,
          child: Column(
            children: <Widget>[
              Text(bodycheckuser.toString()),
            ],
          ),
        ),
        title: Text('Server response'),
      );
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return alertDialog;
          });
       */

      /*
      final response_userid = await http.get(
        url_userid,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      );

      var jsonDecoded2 = json.decode(response_userid.body);
      var jsonRow = jsonDecoded2['rows'];
      var arrJson = jsonRow.toString().split(",");
      var arr2Json = arrJson[0].toString().split(":");
      var arr3Json = arr2Json.toString().split(":");
      var arr4Json = arr2Json.toString().split(",");
      var arr4H1 = arr4Json[1].toString().replaceAll(new RegExp(']'), '');
      var id_user_tb = arr4H1.toString().replaceAll(new RegExp(','), '');
      */
      //-----insert tb => usertimelog----

      Map<String, dynamic> body2 = {
        "data": {
          "id_user": id_user_tb33.toString(),
          "place_location": strg_cur_latitude.toString() +
              "," +
              strg_cur_longitude.toString(),
          "area_status": area_status,
          "time_stamp_work": date1.toString(),
          "timelog": timelog.toString(),
          "Badgenumber": Badgenumber,
          "VERIFYCODE": VERIFYCODE,
          "time_period": time_period,
        }
      };

      var urltimelog = ip + "usertimelog";
      String jsonBody2 = json.encode(body2);
      final response2 = await http.post(
        urltimelog,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonBody2,
        encoding: encoding,
      );
      var jsonDecoded_usertimelog = json.decode(response2.body);
      var status__timelog =
      jsonDecoded_usertimelog['ok']; //ถ้า true คือ บันทึกได้

      //-------> บันทึกข้อมูลใน tb=> checkinout ----------------------
      var url_checkinout = ip + "checkinout";
      Map<String, dynamic> body3 = {
        "data": {
          "Badgenumber": Badgenumber,
          "CHECKTIME": date1.toString(),
          "CHECKTYPE": "1",
          "VERIFYCODE": VERIFYCODE,
          "SENSORID": SENSORID,
          "WorkCode": "",
          "sn": "S"
        }
      };
      String jsonBody3 = json.encode(body3);
      final response3 = await http.post(
        url_checkinout,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonBody3,
        encoding: encoding,
      );
      var jsonDecoded3 = json.decode(response3.body);
      var status_checkinout =
      jsonDecoded3["ok"]; //ถ้า true แสดงว่าบันทึกข้อมูลได้

      if (status__timelog == true && status_checkinout == true) {
        var alertDialog = AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(15.0)),
//              side: BorderSide(color: Colors.black)),
          contentPadding: EdgeInsets.only(top: 0.0),

          content: Container(
            width: 200,
            height: 50,
            child: Column(
              children: <Widget>[
                Text('รหัสจากเครื่องแสกนนิ้ว : ' + Badgenumber),
              ],
            ),
          ),

          title: Text('บันทึกสำเร็จ : ' + VERIFYCODE_datail.toString()),
        );
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return alertDialog;
            });
      } else {
        var alertDialog = AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(15.0)),
//              side: BorderSide(color: Colors.black)),
          contentPadding: EdgeInsets.only(top: 0.0),

          content: Container(
            width: 200,
            height: 50,
            child: Column(
              children: <Widget>[
                Text('ลองใหม่อีกครั้ง'),
              ],
            ),
          ),

          title: Text('บันทึกไม่สำเร็จ'),
        );
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return alertDialog;
            });
      }
    } else {
      //ยังไม่มี user นี้

      //------> insert tb=> userprofile
      /*
      Map<String, dynamic> body = {
        "employeeCode": strg_empCode,
        "employeeNo": strg_employeeNo,
        "IMEI": strg_gettoIMEI,
        "simserial": strg_simSerialNumber,
        "deviceID": strg_deviceId,
        "timelog": formattedDate
      };

      var urlinsertapptime = ip + "apptime/";
      String jsonBody = json.encode(body);
      final encoding = Encoding.getByName('utf-8');
      final response = await http.post(
        urlinsertapptime,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonBody,
        encoding: encoding,
      );
      var jsonDecoded = json.decode(response.body);
      var status_userprofile =
          jsonDecoded["ok"]; // ตรวจสอบสถานการบันทึกข้อมูล true= บันทึก
      var id_user_tb = jsonDecoded["result"];
      */

      //-----insert tb => usertimelog----

      Map<String, dynamic> body2 = {
        "data": {
//          "id_user": id_user_tb.toString(),
          "id_user": id_user.toString(),
          "place_location": strg_cur_latitude.toString() +
              "," +
              strg_cur_longitude.toString(),
          "area_status": area_status,
          "time_stamp_work": date1.toString(),
          "timelog": timelog.toString(),
          "Badgenumber": Badgenumber,
          "VERIFYCODE": VERIFYCODE,
          "time_period": time_period,
        }
      };
      var urltimelog = ip + "usertimelog";
      String jsonBody2 = json.encode(body2);
      final response2 = await http.post(
        urltimelog,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonBody2,
        encoding: encoding,
      );
      var jsonDecoded_usertimelog = json.decode(response2.body);
      var status__timelog =
      jsonDecoded_usertimelog['ok']; //ถ้า true คือ บันทึกได้

      //-------> บันทึกข้อมูลใน tb=> checkinout ----------------------
      var url_checkinout = ip + "checkinout";
      Map<String, dynamic> body3 = {
        "data": {
          "Badgenumber": Badgenumber,
          "CHECKTIME": date1.toString(),
          "CHECKTYPE": "1",
          "VERIFYCODE": VERIFYCODE,
          "SENSORID": SENSORID,
          "WorkCode": "",
          "sn": "S"
        }
      };
      String jsonBody3 = json.encode(body3);
      final response3 = await http.post(
        url_checkinout,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonBody3,
        encoding: encoding,
      );
      var jsonDecoded3 = json.decode(response3.body);
      var status_checkinout =
      jsonDecoded3["ok"]; //ถ้า true แสดงว่าบันทึกข้อมูลได้

      if (status__timelog == true && status_checkinout == true) {
        var alertDialog = AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(15.0)),
//              side: BorderSide(color: Colors.black)),
          contentPadding: EdgeInsets.only(top: 0.0),

          content: Container(
            width: 200,
            height: 50,
            child: Column(
              children: <Widget>[
                Text('รหัสจากเครื่องแสกนนิ้ว :  ' + Badgenumber),
              ],
            ),
          ),

          title: Text('บันทึกสำเร็จ : ' + VERIFYCODE_datail.toString()),
        );
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return alertDialog;
            });
      } else {
        var alertDialog = AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(15.0)),
//              side: BorderSide(color: Colors.black)),
          contentPadding: EdgeInsets.only(top: 0.0),

          content: Container(
            width: 200,
            height: 50,
            child: Column(
              children: <Widget>[
                Text('ลองใหม่อีกครั้ง'),
              ],
            ),
          ),

          title: Text('บันทึกไม่สำเร็จ'),
        );
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return alertDialog;
            });
      }
    }
  }
   */

  Future loop1() {
    for (int i = 0; i < 3; i++) {
      print(i);
    }
  }
}
