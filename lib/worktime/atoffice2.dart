import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_page_ui/dashboard/home.dart' as prefix0;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

import '../main.dart';

var now2 = new DateTime.now();
var y = now2.year;
var date1 = new DateFormat("yyyy-MM-dd hh:mm:ss").format(now2);
var now3;

//int  day; //ทดสอบจำนวนวันที่

var datecurrent = new DateFormat("yyyy-MM-dd").format(now2);

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

var strg_getTokene = storage.getItem("stor_getToken"); //Token ทั้งหมด

var area_status; //1=อยู่ในพื้นที่,0=อยู่นอกพื้นที่

var VERIFYCODE; //0=เข้า,1=ออก
var VERIFYCODE_datail;
var timelog; //เวลาที่ระบบบันทึกข้อมูล

var time_period; //กะการเข้างานแบ่งตาม 1-6

var valueofEMIE; //  valueEMIE.leght=5 =>ต้องการ ค่า IMEI_expire

var expireStatus; //ตรวจสอบสถานะหมดอายุของ EMIE ถ้า []=ยังไม่หมดอายุ

var id_user; //รับค่า id_user

var CHECKTIME_serve; //เรียกเวลาที่ลงเวลาทำงาน
var totalhours_serve; //จำนวนชั่วโมงในการทำงาน

//http://http://10.3.42.61:3008/checkinout/Badge/4697
var ip2 = "http://10.3.42.61:3008/";

//http://10.3.42.163:3008/checkinout/Badge/4697  =>limit main list
/*
 querybadgenumber(knex: Knex, Badgenumber: string){
      return knex(this.tableName    )
      .where(this.Badgenumber,Badgenumber)
      .orderBy(this.primaryKey,'DESC')
      .limit(7);
  }
 */

var SENSORID = 99;

Map<String, dynamic> map = {}; //array key,value for fultter
List<String> list1 = [];

String jsonlist2;

//List<String> list2 = [];
List<String> list2 = new List<String>();

//https://stackoverflow.com/questions/50441168/iterating-through-a-list-to-render-multiple-widgets-in-flutter
List<Widget> listwidget = new List<Widget>();

//https://codeburst.io/top-10-array-utility-methods-you-should-know-dart-feb2648ee3a2
List<Map<String, dynamic>> arrinout = [];

//final urlJSONString = ip2 + "userinfo/" + strg_employeeNo;
//สำหรับ checkinout ทั้งหมดเวลามาทำงาน

final String url_userinfo = ip2 + "userinfo/" + strg_employeeNo;

//http://10.3.42.163:3008/checkinout/Badge/4697
final urlJSONString = ip2 + "checkinout/Badge/" + server_Badgenumber;

var server_Badgenumber; // Badgenumber ของพนักงาน

List<Map<String, dynamic>> listinout;

List jsonlist = []; //=>เอาไปใช้งาน ใน foreach json

List jsonexpirelist = []; // json emie expire

const String sharedSecret = '072f789acfee57e2c542da0d5169b4b8'; //ถูก

var decClaimSet;

class Atoffice2 extends StatefulWidget {
  @override
  _Atoffice2State createState() => _Atoffice2State();
}

class _Atoffice2State extends State<Atoffice2> {
  @override
  void initState() {
    super.initState();
//    loadData(); //โหลด list1.tostring

    List<String> list1 = [];
    callIdBadge();
//    _jsonSerivce();

    //เรียก Badgenumber พนักงาน => list1.add(rows2);
//    emieexpire(context); //=> jsonexpirelist  //ตรวจสอบ expire EMIE

    getExpire(); //EMIE_expire,id_user
    checkdateExpire();
    checkOutTime();

//    date1 = ""; //วันเดือน ปีลงเวลา
//    CHECKTIME_serve = "";

    /* "data": {
    "startdate": CHECKTIME_serve.toString(),
    "enddate": date1.toString()
    }
    */

    //ตรวจสอบ Token
  }

  Future checkOutTime() async {
//    var urlcheckOutTime = ip2 + "apptime/counHour/";
    var urlcheckOutTime = ip2 + "apptime/counHour/";

    /*
    {
      "data":{
    "startdate":"2019-12-06 08:30:20",
    "enddate":"2019-12-06 15:51:10"

    }
    }
    */

    Map<String, dynamic> body3 = {
      "data": {
        "startdate": CHECKTIME_serve.toString(),
        "enddate": date1.toString()
      }

      /*
      "data": {
        "startdate": "2019-12-06 08:30:20",
        "enddate": "2019-12-06 15:51:10"
      }
      */

      /*
      "data": {
        "startdate": "2019-12-06 08:30:20",
        "enddate": "2019-12-06 15:51:10"
      }
        */
    };
    String jsonBody3 = json.encode(body3);
    final encoding = Encoding.getByName('utf-8');
    final response = await http.post(
      urlcheckOutTime,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: jsonBody3,
      encoding: encoding,
    );
    var jsonDecoded = json.decode(response.body);
    var rows = jsonDecoded['rows'][0];
    var rows2 = rows[0];
    var totalhours = rows2['totalhours']; //จำนวนชั่วโมงในการทำงาน

    setState(() {
      totalhours_serve = totalhours.toString();
    });
//    msg('serve', body3.toString() + ',' + totalhours_serve.toString());
  }

  Future callstartDate(
    String id,
  ) async {
    //นับจำนวนชั่วโมงในการทำงาน
    //http://10.3.42.61:3008/checkinout/callID/3603914
    var url_callstartDate = ip2 + 'checkinout/callID/' + id;

    final response_userid = await http.get(
      url_callstartDate,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );
    var jsonDecoded2 = json.decode(response_userid.body);
    var rows = jsonDecoded2["rows"][0];
    var CHECKTIME = rows['CHECKTIME'];

    setState(() {
      CHECKTIME_serve = CHECKTIME;
    });

//    msg('server', CHECKTIME_serve.toString());
  }

  Future checkdateExpire() async {
    var urlexpire = ip2 + 'apptime/dateexpire/';

    Map<String, dynamic> bodycheckuser = {
      "data": {
//        "employeeNo": strg_employeeNo,
//        "IMEI": strg_gettoIMEI,
//        "simserial": strg_simSerialNumber,
//        "deviceID": strg_deviceId,
        "IMEI_expire": datecurrent,
        "id_user": id_user
      }
    };

    String jsonBody3 = json.encode(bodycheckuser);
    final encoding = Encoding.getByName('utf-8');
    final response = await http.post(
      urlexpire,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: jsonBody3,
      encoding: encoding,
    );
    var jsonDecoded = json.decode(response.body);
    var rowsexpire = jsonDecoded['rows'];

//    msg('check response', rowsexpire.toString());

    // msg('server resp', 'id_user : ' + id_user + ',' + urlexpire.toString());

//    msg('serv', bodycheckuser.toString());
//    msg('serv', bodycheckuser.toString());
//    msg('serve', rowsexpire.toString());

    setState(() {
      expireStatus = rowsexpire; //[] ยังไม่หมดอายุ
    });
  }

  Future getExpire() async {
    var urlexpire = ip2 + 'apptime/device/';
//    msg('', urlemie);

    Map<String, dynamic> bodycheckuser = {
      "data": {
        "employeeNo": strg_employeeNo,
        "IMEI": strg_gettoIMEI,
        "simserial": strg_simSerialNumber,
        "deviceID": strg_deviceId
      }
    };
    String jsonBody3 = json.encode(bodycheckuser);
    final encoding = Encoding.getByName('utf-8');
    final response = await http.post(
      urlexpire,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: jsonBody3,
      encoding: encoding,
    );

    var jsonDecoded = json.decode(response.body);
    var rows = jsonDecoded['rows'];

    var exparr1 = rows.toString().split(","); //แยกจาก , => [{'','',''}]

    var countarr1 = exparr1.length;
    var lastnumber1 = countarr1 - 1;

    var exparr2 =
        exparr1[lastnumber1].split(":"); // IMEI_expire:null}]=>ตัดจาก :

    var valueEMIElast = exparr2[1].toString(); //=>null}] ต้องทำการตัด })] ออก
    var valueEMIElast2 =
        valueEMIElast.replaceAll(new RegExp(']'), ''); // ตัดออก ]
    var valueEMIE = valueEMIElast2.replaceAll(
        new RegExp('}'), ''); // ตัดออก ] จะได้ค่า เป็น null

//    msg('server response', 'date expire :' + valueofEMIE);

    // ตัดเพื่อหา id_user
    var iduserarr1 = rows.toString().split(",");
    var iduserarr2 = iduserarr1[0].split(":"); //id_user
//    msg('server response', iduserarr2[1].toString());

    setState(() {
//      jsonexpirelist = rows;
      id_user = iduserarr2[1]; // ส่งค่ากลับ id_user
      return valueofEMIE = valueEMIE.trim(); // valueEMIE.leght=5
    });
  }

  /*
  Future emieexpire(BuildContext context) async {
    // ตรวจสอบ EMIE expire
    //ตรวจสอบ user expire => http://10.3.42.61:3008/apptime/code/A1631
    var urlemie = ip2 + 'apptime/code/' + strg_employeeNo;
    final response_userid = await http.get(
      urlemie,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );

    var jsonDecoded2 = json.decode(response_userid.body);
    var rows = jsonDecoded2['rows'];

    var exparr1 = rows.toString().split(","); //แยกจาก , => [{'','',''}]

    var countarr1 = exparr1.length;
    var lastnumber1 = countarr1 - 1;

    var exparr2 =
        exparr1[lastnumber1].split(":"); // IMEI_expire:null}]=>ตัดจาก :

    var valueEMIElast = exparr2[1].toString(); //=>null}] ต้องทำการตัด })] ออก
    var valueEMIElast2 =
        valueEMIElast.replaceAll(new RegExp(']'), ''); // ตัดออก ]
    var valueEMIE = valueEMIElast2.replaceAll(
        new RegExp('}'), ''); // ตัดออก ] จะได้ค่า เป็น null
    setState(() {
      return valueofEMIE = valueEMIE.trim(); // valueEMIE.leght=5
    });
  }
*/

  Future callIdBadge() async {
    final response_userid = await http.get(
      url_userinfo,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );
    var jsonDecoded2 = json.decode(response_userid.body);
    var rows = jsonDecoded2['rows'];
    var split1 = rows.toString().split(',');

    var arrBadgenumber = split1[1];
    var splitBadge = arrBadgenumber.split(':');

//    var Badgenumber = splitBadge[1];

    //-----------call json checkinout----------
    var urlJSONString2 = ip2 + "checkinout/Badge/" + splitBadge[1];

    var respense2 =
        await http.get(urlJSONString2, headers: {"Aceept": "application/json"});
    String responseBodyString2 = respense2.body;
    var jsonBody2 = json.decode(responseBodyString2);
    var status2 = jsonBody2['ok'].toString();
    var rows2 = jsonBody2['rows'].toString();

    setState(() {
//      server_Badgenumber = splitBadge[1];

//      return  splitBadge[1];
      list1.add(rows2);

      jsonlist = jsonBody2['rows']; //เอาตัวนี้ไปใช้งาน

//      map.add(rows2);
      return server_Badgenumber = splitBadge[1];

      //https://kodestat.com/flutter-listview-with-json-or-listdata/
    });

    for (var word in jsonBody2['rows']) {
      arrinout = [
        {
          "id": word['id'].toString(),
          "Badgenumber": word['Badgenumber'].toString(),
          "CHECKTIME": word['CHECKTIME'].toString(),
          "CHECKTYPE": word['CHECKTYPE'].toString(),
          "VERIFYCODE": word['VERIFYCODE'].toString(),
          "SENSORID": word['SENSORID'].toString(),
          "WorkCode": word['WorkCode'].toString(),
          "sn": word['sn'].toString(),
        }
      ];

      //-- listwidget =>https://stackoverflow.com/questions/50441168/iterating-through-a-list-to-render-multiple-widgets-in-flutter
      listwidget.add(new Text(word['id'].toString()));
      listwidget.add(new Text(word['Badgenumber'].toString()));
      listwidget.add(new Text(word['CHECKTIME'].toString()));
      listwidget.add(new Text(word['CHECKTYPE'].toString()));
      listwidget.add(new Text(word['VERIFYCODE'].toString()));
      listwidget.add(new Text(word['SENSORID'].toString()));
      listwidget.add(new Text(word['WorkCode'].toString()));
      listwidget.add(new Text(word['sn'].toString()));

      // https://codingwithjoe.com/dart-fundamentals-working-with-lists/
      list2.add(word['id'].toString());
      list2.add(word['Badgenumber'].toString());
      list2.add(word['CHECKTIME'].toString());
      list2.add(word['CHECKTYPE'].toString());
      list2.add(word['VERIFYCODE'].toString());
      list2.add(word['SENSORID'].toString());
      list2.add(word['WorkCode'].toString());
      list2.add(word['sn'].toString());
    }

    /*
    var alertDialog = AlertDialog(
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
//              side: BorderSide(color: Colors.black)),
      contentPadding: EdgeInsets.only(top: 0.0),

      content: Container(
        width: 250,
        height: 100,
        child: Column(
          children: <Widget>[
            Text(list2.toString()),
          ],
        ),
      ),

      title: Text('Bagenumber '),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });*/
  }

  Future _getCheckinout() async {
    var respense =
        await http.get(urlJSONString, headers: {"Aceept": "application/json"});

    String responseBodyString = respense.body;
    var jsonBody = json.decode(responseBodyString);

    var alertDialog = AlertDialog(
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
//              side: BorderSide(color: Colors.black)),
      contentPadding: EdgeInsets.only(top: 0.0),

      content: Container(
        width: 500,
        height: 500,
        child: Column(
          children: <Widget>[
            Text('' + jsonBody.toString()),
          ],
        ),
      ),

      title: Text('server Restponse : '),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: MaterialApp(
      title: 'เข้าสู่ระบบลงเวลา ',
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'รหัส:' +
                server_Badgenumber.toString() +
                '' +
                ',เวลาเข้าใช้ :' +
                date1.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
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
                        child: IconButton(
                          onPressed: () {
//                      debugPrint("Starred Me!");
//                            getChckinout(context);
//                            _getCheckinout();    // ok

                            callIdBadge();
//                            _jsonSerivce();

//                            emieexpire(context); //emie expire

//                            checkHours(); // เวลาออกอย่างน้อย 18 ชม

                            getExpire(); //check date expire
                            checkdateExpire();
                            checkOutTime();

                            // check Token จาก server

                            //https://pub.dev/packages/jaguar_jwt#-example-tab-
                            decClaimSet = verifyJwtHS256Signature(
                                strg_getTokene, sharedSecret);

                            if ((decClaimSet.subject != null) ||
                                (decClaimSet.jwtId != null) ||
                                (decClaimSet.issuedAt != null)) {
                              //------ alert---------
                              var alertDialog = AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(15.0)),
//              side: BorderSide(color: Colors.black)),
                                contentPadding: EdgeInsets.only(top: 0.0),
                                content: Container(
                                  width: 300,
                                  height: 400,
                                  child: Column(
                                    children: <Widget>[
//                      Text("$header64.$payload64.$sign64"),
                                      //Text(getTokenvalue)
                                      Text(decClaimSet.toString() +
                                          ',' +
                                          decClaimSet.issuedAt.toString())
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
                              //------ alert---------

                            }
                          },
                          color: Colors.green,
                          icon: Icon(
                            Icons.loop, //refresh
                            size: 30,
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
                          color: Colors.green,
                          icon: Icon(
                            Icons.first_page,
                            size: 30,
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
                          color: Colors.green,
                          icon: Icon(
                            Icons.last_page,
                            size: 30,
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
                    children: [
                      Container(
                        width: 130.0,
                        height: 60.0,
                        color: Colors.white,
                        child: RaisedButton(
                          onPressed: () {
                            /*
                            VERIFYCODE = 0; //0=เข้าทำงาน,1=เลิกงาน
                            sendInsert(context); //ส่งค่าทำการบันทึก
                            callIdBadge();
//                           emieexpire(context);
                              */

                            getExpire(); //check date expire
                            checkdateExpire();

                            /*   print('expireStatus:' +
                                expireStatus.toString().trim());
                            */
                            // expireStatus = [] แสดงว่ายังไม่หมดอายุ

//                            msg('response', expireStatus.toString());

                            if (expireStatus.toString().trim() == '[]') {
                              VERIFYCODE = 0; //0=เข้าทำงาน,1=เลิกงาน
                              sendInsert(context); //ส่งค่าทำการบันทึก
                              callIdBadge();
//                           emieexpire(context);

//                              msg('server', expireStatus.toString().trim());
                            } else {
                              msg('ไม่สามารถลงเวลาได้', 'สถานะ EMIE หมดอายุ ');
                            }
                          },
                          child: Text(
                            'เข้า',
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                          color: Colors.green,
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15.0)),
                        ),
                      ),

                      /*
                      Container(
                        width: 130.0,
                        height: 60.0,
                        color: Colors.white,
                        child: RaisedButton(
                          onPressed: () {
                            //ต้องเชคการทำงานให้ครบ 8 ชั่วโมงก่อน
                            VERIFYCODE = 1; //0=เข้าทำงาน,1=เลิกงาน
                            callIdBadge();
                            _jsonSerivce();
                            sendInsert(context); //ส่งค่าทำการบันทึก
                          },
                          child: Text(
                            'ออก',
                            style: TextStyle(fontSize: 25, color: Colors.black),
                          ),
                          color: Colors.blue,
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15.0)),
                        ),
                      ),
                      */
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Column(children: <Widget>[
                        for (var item in jsonlist)
                          Card(
                              color: Colors.grey[200],
                              child: ListTile(
                                leading: Icon(Icons.fingerprint,
                                    size: 25, color: Colors.black),
                                trailing: RaisedButton(
                                    onPressed: () {
                                      /*
                                      //ต้องเชคการทำงานให้ครบ 8 ชั่วโมงก่อน
                                      VERIFYCODE = 1; //0=เข้าทำงาน,1=เลิกงาน
                                      callIdBadge();
//                                      _jsonSerivce();
                                      sendInsert(context);

                                       */

                                      callstartDate(item["id"].toString());
                                      checkOutTime(); //ตรวจสอบชั่วโมงการทำงาน

//                                      msg('serve', totalhours_serve.toString());
                                      var my_totalhours_serve =
                                          int.parse(totalhours_serve);
                                      assert(my_totalhours_serve is int);
//                                      msg('', myInt.toString());
                                      if (my_totalhours_serve >= 18) {
                                        msg(
                                            'สถานะการทำงาน  ',
                                            'จำนวนชั่วโมงทำงาน :' +
                                                my_totalhours_serve.toString());
                                        //ต้องเชคการทำงานให้ครบ 8 ชั่วโมงก่อน
                                        VERIFYCODE = 1; //0=เข้าทำงาน,1=เลิกงาน
                                        callIdBadge();
//                                      _jsonSerivce();
                                        sendInsert(context);
                                      } else {
                                        msg(
                                            'สถานะเวลาทำงานต่ำกว่า 18 ชั่วโมง ',
                                            'จำนวนชั่วโมงทำงาน :' +
                                                my_totalhours_serve.toString());
                                      }
                                    },
                                    child: Text(
                                      'ออก',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    color: Colors.blue,
                                    elevation: 4.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(15.0))),

                                /*
                                trailing: Icon(
                                  Icons.access_time,
                                  color: Colors.black,
                                  size: 20.0,
                                  semanticLabel: 'KKH',
                                ),
                                */

                                title: Text(
//                                ' รหัสพนักงาน : ' +
//                                    item['Badgenumber'].toString() +
                                  'เวลา : ' + item['CHECKTIME'].toString(),
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 17.0),
                                ),
                                subtitle: Text('เข้า(0)-ออก(1) : ' +
                                    '[' +
                                    item['VERIFYCODE'].toString() +
                                    ']' +
                                    ', จากอุปกรณ์ : ' +
                                    item['SENSORID'].toString()),
                                enabled: true,
                                dense: false,
                                selected: true,
                                onLongPress: () {
                                  print('onLongPress');
                                },
                                onTap: () {},
                              )),
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

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => prefix0.Home()));
          }),
          tooltip: 'Back System',
          backgroundColor: Colors.white,
          child: Icon(
            Icons.clear,
            color: Colors.black,
            size: 35.0,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    ));
  }

  /*
  void loadData() async {
    var respense =
        await http.get(urlJSONString, headers: {"Aceept": "application/json"});

    String responseBodyString = respense.body;
    var jsonBody = json.decode(responseBodyString);

    var status = jsonBody['ok'].toString();
    var rows = jsonBody['rows'].toString();

    setState(() {
      return list1.add(rows);
    });

    var alertDialog = AlertDialog(
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
//              side: BorderSide(color: Colors.black)),
      contentPadding: EdgeInsets.only(top: 0.0),

      content: Container(
        width: 400,
        height: 500,
        child: Column(
          children: <Widget>[
//              Text(datas.toString()),
            Text(urlJSONString),
          ],
        ),
      ),

      title: Text(' Json response Badgenumber '),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
  */

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

  Future sendInsert(BuildContext context) async {
    var timelog =
        DateFormat('yyyy-MM-dd hh:mm:ss').format(now2); //เวลาในการบันทึกระบบ

    var urlbackend = ip2 + "apptime/";
//    var urlbackend2 = "http://10.3.42.163:3008/usertimelog/";
    var urlssn = ip2 + "userinfo/" + strg_employeeNo;

    var url_inst_profile = ip2 + "apptime/code/" + strg_employeeNo;
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
    var Badgenumber = BadgenumberARR[1]; //รหัสนิ้วของพนักงาน

    //http://192.168.1.25:3008/apptime/code/A1631
    Map<String, dynamic> body = {
      "employeeCode": strg_empCode,
      "employeeNo": strg_employeeNo,
      "IMEI": strg_gettoIMEI,
      "simserial": strg_simSerialNumber,
      "deviceID": strg_deviceId,
      "timelog": formattedDate,
      "Badgenumber": Badgenumber,
      "IMEI_expire": '0000-00-00',
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

    //จำลอง
    //--ถ้ามี ull คือ -มี user นี้แล้ว ใน userprofile---------
    if (id_user == 'ull') {
      var url_checkuser = ip2 + "apptime/device";
      Map<String, dynamic> bodycheckuser = {
        "data": {
          "employeeNo": strg_employeeNo,
          "IMEI": strg_gettoIMEI,
          "simserial": strg_simSerialNumber,
          "deviceID": strg_deviceId
        }
      };

      var url_userid = ip2 + "apptime/device/";
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
      var id_user_tb33 = arr2Json33[1].toString(); //คือ id_user จาก userprofile

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
      var urltimelog = ip2 + "usertimelog";
      String jsonBody2 = json.encode(body2);
      final response2 = await http.post(
        urltimelog,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonBody2,
        encoding: encoding,
      );
      var jsonDecoded_usertimelog = json.decode(response2.body);

      var status__timelog = jsonDecoded_usertimelog[
          'ok']; //ถ้า true คือ บันทึกได้ ->สถานะการบันทึก

      //-------> บันทึกข้อมูลใน tb=> checkinout ----------------------
      // "IMEI": strg_gettoIMEI, => เพิ่มใน WorkCode

      var url_checkinout = ip2 + "checkinout";
      Map<String, dynamic> body3 = {
        "data": {
          "Badgenumber": Badgenumber,
          "CHECKTIME": date1.toString(),
          "CHECKTYPE": "1",
          "VERIFYCODE": VERIFYCODE,
          "SENSORID": SENSORID,
          "WorkCode": strg_gettoIMEI,
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
              Text('รหัส : ' +
                  BadgenumberARR[1] +
                  '\n' +
                  'EMEI : ' +
                  strg_gettoIMEI),
            ],
          ),
        ),

        // status__timelog  == true  status_checkinout  == true บันทึกการทำงานสำเร็จ

        title: Text('บันทึกสำเร็จ'),
      );
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return alertDialog;
          });
    }
  }

  Future sendValue(BuildContext context) async {
    //ตัวอย่างการเรียกใช้งาน
    var timelog =
        DateFormat('yyyy-MM-dd hh:mm:ss').format(now2); //เวลาในการบันทึกระบบ

//    var urlbackend = "http://10.3.42.21:3008/apptime/";
    var urlbackend = ip2 + "apptime/";
//    var urlbackend2 = "http://10.3.42.163:3008/usertimelog/";
    var urlssn = ip2 + "userinfo/" + strg_employeeNo;

    var url_inst_profile = ip2 + "apptime/code/" + strg_employeeNo;
    // ตัวอย่างการเรียก ssn=>http://192.168.1.25:3008/userinfo/A1631

    final headers = {'Content-Type': 'application/json'};

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd hh:mm:ss').format(now);

    //--เรียกใช้งาน Badgenumber
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

    var alertDialog = AlertDialog(
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
        });

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
      var url_checkuser = ip2 + "apptime/device";
      Map<String, dynamic> bodycheckuser = {
        "data": {
          "employeeNo": strg_employeeNo,
          "IMEI": strg_gettoIMEI,
          "simserial": strg_simSerialNumber,
          "deviceID": strg_deviceId
        }
      };
      var url_userid = ip2 + "apptime/device/";
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

      var urltimelog = ip2 + "usertimelog";
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
      var url_checkinout = ip2 + "checkinout";
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
                Text('รหัสจากเครื่องแสกนนิ้ว : ' +
                    Badgenumber +
                    '\n' +
                    'EMEI : ' +
                    strg_gettoIMEI),
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
      var urltimelog = ip2 + "usertimelog";
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
      var url_checkinout = ip2 + "checkinout";
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
                Text('รหัสจากเครื่องแสกนนิ้ว :  ' +
                    Badgenumber +
                    '\n' +
                    'IMEI :' +
                    strg_gettoIMEI),
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

  Future msg(String title, String childtxt) {
    var alertDialog = AlertDialog(
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
//              side: BorderSide(color: Colors.black)),
      contentPadding: EdgeInsets.only(top: 0.0),

      content: Container(
        width: 300,
        height: 100,
        child: Column(
          children: <Widget>[
            Divider(
              color: Colors.black,
              height: 4.0,
            ),
            Text('' + childtxt),
          ],
        ),
      ),

      title: Text(
        '' + title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
      ),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  // https://api.dartlang.org/stable/2.6.1/dart-core/DateTime-class.html
  Future checkHours() //แสกนนิ้วออกต้องอย่างนอ้ย 18 ชม
  {
    var date1stamp = date1.toString() + ' 20:18:04';
    var moonLanding = DateTime.parse('1969-07-20 20:18:04Z');

//    print('print date1 = ' + date1);
  }
}

/*
//https://medium.com/flutter-community/parsing-complex-json-in-flutter-747c46655f51
class User {
  String id;
  String Badgenumber;
  String CHECKTIME;
  String CHECKTYPE;
  String VERIFYCODE;
  String SENSORID;
  String WorkCode;
  String sn;

  User(
      {this.id,
      this.Badgenumber,
      this.CHECKTIME,
      this.CHECKTYPE,
      this.VERIFYCODE,
      this.SENSORID,
      this.WorkCode,
      this.sn});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        Badgenumber: json['Badgenumber'],
        CHECKTIME: json['CHECKTIME'],
        CHECKTYPE: json['CHECKTYPE'],
        VERIFYCODE: json['VERIFYCODE'], //0=เข้า,1=ออก
        SENSORID: json['SENSORID'],
        WorkCode: json['WorkCode'], //เก็บ EMIE
        sn: json['sn']);
  }
}
 */
//  https://medium.com/flutter-community/parsing-complex-json-in-flutter-747c46655f51
