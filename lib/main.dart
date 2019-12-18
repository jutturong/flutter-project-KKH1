import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:imei_plugin/imei_plugin.dart';
import 'package:localstorage/localstorage.dart';
import 'package:location/location.dart';
import 'package:poly/poly.dart' as ckPoly;
import 'package:sim_service/models/sim_data.dart';

import 'Widgets/FormCard.dart';
import 'dashboard/home.dart';

//import 'package:localstorage/localstorage.dart';

//import 'package:jaguar_jwt/jaguar_jwt.dart';

//import 'package:android_multiple_identifier/android_multiple_identifier.dart';

//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//final storage = new FlutterSecureStorage();
// user ทดสอบ  user=dixon2,password=462520
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';

//import 'package:rflutter_alert/rflutter_alert.dart';

//import 'dart:convert' as convert;
//import 'package:http/http.dart' as http;

//------clear  session

/*
storage.setItem("stor_checkstatus", "" );
storage.setItem("stor_fullname", "" );
storage.setItem("stor_employeeNo", "" );
storage.setItem("stor_token", "" );
storage.setItem("stor_tokenExpire", "" );
storage.setItem("stor_gettoIMEI", "");
storage.setItem("stor_phoneNumber", "" );
storage.setItem("stor_simSerialNumber", "" );
storage.setItem("stor_deviceId", "" );

storage.setItem("stor_empCode", "" );

storage.setItem("stor_cur_latitude", "" );
storage.setItem("stor_cur_longitude", "" );

storage.setItem("stor_checkInKKH", "" );
storage.setItem("stor_str_ans", "" );
storage.setItem("stor_area_status", "" );
   */

//var SECRET_KEY = '072f789acfee57e2c542da0d5169b4b8';

var url = "http://iconnect.kkh.go.th:3008/login/old-user";
//var url = "http://iconnect.kkh.go.th:3008/login/old-user";
//http://iconnect.kkh.go.th:3008/login

//String value = await storage.read(key: key);

final LocalStorage storage = new LocalStorage('some_key');
// final LocalStorage localStorage = new LocalStorage;

//const String sharedSecret = 's3cr3t';
final key = 's3cr3t'; //JWT token
const String sharedSecret = 's3cr3t';

// IMEI
//String imei = await AndroidMultipleIdentifier.imeiCode;
//String serial = await AndroidMultipleIdentifier.serialCode;
//String androidID = await AndroidMultipleIdentifier.androidID;
//Map idMap = await AndroidMultipleIdentifier.idMap;

String gettoIMEI = '';

//var      gettoIMEI =  await getIMEI();

const MethodChannel _channel = const MethodChannel('sim_service');

var currentLocation = LocationData;
var location = new Location();

double _cur_latitude = 0;
double _cur_longitude = 0;

String str_ans = "";
bool checkInKKH;

var area_status;

void main() => runApp(MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSelected = false;

  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  void _getlocation() {
    location.onLocationChanged().listen((LocationData currentLocation) {
      setState(() {
        _cur_latitude = currentLocation.latitude;
        _cur_longitude = currentLocation.longitude;
      });
    });
  }

  void initState() {
    _getlocation();

    super.initState();

    logout();

    txt_username.text = "";
    txt_password.text = "";

    storage.setItem("stor_checkstatus", "");
    storage.setItem("stor_fullname", "");
    storage.setItem("stor_employeeNo", "");
    storage.setItem("stor_token", "");
    storage.setItem("stor_tokenExpire", "");
    storage.setItem("stor_gettoIMEI", "");
    storage.setItem("stor_phoneNumber", "");
    storage.setItem("stor_simSerialNumber", "");
    storage.setItem("stor_deviceId", "");

    storage.setItem("stor_empCode", "");

    storage.setItem("stor_cur_latitude", "");
    storage.setItem("stor_cur_longitude", "");

    storage.setItem("stor_checkInKKH", "");
    storage.setItem("stor_str_ans", "");
    storage.setItem("stor_area_status", "");

    var strg_fullname = storage.getItem("stor_fullname");

    var strg_empCode = storage.getItem("stor_empCode");

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
    var strg_str_ans = storage.getItem("stor_str_ans");
    var stor_area_status = storage.getItem("stor_area_status");
  }

  Widget radioButton(bool isSelected) => Container(
        width: 16.0,
        height: 16.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2.0, color: Colors.black)),
        child: isSelected
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.black),
              )
            : Container(),
      );

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: 50.0,
                  right: 30.0,
                ),
//                child: Image.asset("assets/image_01.png"),
                child: Image.asset(
                  "assets/Unknown.png",
                  fit: BoxFit.fitHeight,
//                  color: Colors.red,
                  colorBlendMode: BlendMode.darken,

//                  scale: 2.0,
//                  width: ScreenUtil.getInstance().setWidth(110),
//                  height: ScreenUtil.getInstance().setHeight(110),
                ),
              ),
              Expanded(
                child: Container(),
              ),
//              Image.asset("assets/image_02.png")
            ],
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
//                      Image.asset(
//                        "assets/logo.png",
//                        width: ScreenUtil.getInstance().setWidth(110),
//                        height: ScreenUtil.getInstance().setHeight(110),
//                      ),

//                      Text("LOGO",
//                          style: TextStyle(
//                              fontFamily: "Poppins-Bold",
//                              fontSize: ScreenUtil.getInstance().setSp(46),
//                              letterSpacing: .6,
//                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(180),
                  ),
                  FormCard(),
                  SizedBox(height: ScreenUtil.getInstance().setHeight(40)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
//                          Icon(Icons.four_k),
                          SizedBox(
                            width: 12.0,
                          ),

                          /*
                          GestureDetector(
                            onTap: _radio,
                            child: radioButton(_isSelected),
                          ),


                          SizedBox(
                            width: 8.0,
                          ),
                          Text("บันทึกการเข้าใช้งาน",
                              style: TextStyle(
                                  fontSize: 20, fontFamily: "Poppins-Medium"))
                           */
                        ],
                      ),
                      InkWell(
                        child: Container(
                          width: ScreenUtil.getInstance().setWidth(330),
                          height: ScreenUtil.getInstance().setHeight(100),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xFF17ead9),
                                Color(0xFF6078ea)
                              ]),
                              borderRadius: BorderRadius.circular(6.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xFF6078ea).withOpacity(.3),
                                    offset: Offset(0.0, 8.0),
                                    blurRadius: 10.0)
                              ]),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                callservice();
                              },
                              child: Center(
                                child: Text("Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins-Bold",
                                        fontSize: 18,
                                        letterSpacing: 1.0)),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(40),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
//                      horizontalLine(),
//                      Text("Social Login",
//                          style: TextStyle(
//                              fontSize: 16.0, fontFamily: "Poppins-Medium")),
//                      horizontalLine()
                    ],
                  ),

//                  SizedBox(
//                    height: ScreenUtil.getInstance().setHeight(40),
//                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      /*
                      SocialIcon(
                        colors: [
                          Color(0xFF102397),
                          Color(0xFF187adf),
                          Color(0xFF00eaf8),
                        ],
                        iconData: CustomIcons.facebook,
                        onPressed: () {},
                      ),
                      SocialIcon(
                        colors: [
                          Color(0xFFff4f38),
                          Color(0xFFff355d),
                        ],
                        iconData: CustomIcons.googlePlus,
                        onPressed: () {},
                      ),
                      SocialIcon(
                        colors: [
                          Color(0xFF17ead9),
                          Color(0xFF6078ea),
                        ],
                        iconData: CustomIcons.twitter,
                        onPressed: () {},
                      ),
                      SocialIcon(
                        colors: [
                          Color(0xFF00c6fb),
                          Color(0xFF005bea),
                        ],
                        iconData: CustomIcons.linkedin,
                        onPressed: () {},
                      )
                        */

                      /*
                      Image.asset(
                        "assets/Kkh1.jpg",
                        fit: BoxFit.fitHeight,
//                  scale: 2.0,
//                  width: ScreenUtil.getInstance().setWidth(110),
//                  height: ScreenUtil.getInstance().setHeight(110),
                      ),
                       */

                      /*
                      Image.asset(
//                        "assets/KKH_place.jpg",
                        "assets/Kkh1.jpg",
                        fit: BoxFit.fitHeight,
//                        scale: 8.0,
                        width: ScreenUtil.getInstance().setWidth(330),
                      ),
                       */

//                      SizedBox(
//                        height: ScreenUtil.getInstance().setHeight(10),
//                      ),
//                      Text('กลุ่มงานเทคโนโลยีสารสนเทศและการสื่อสาร'),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(30),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      /*
                      Text(
                        "New User? ",
                        style: TextStyle(fontFamily: "Poppins-Medium"),
                      ),

                      InkWell(
                        onTap: () {},
                        child: Text("SignUp",
                            style: TextStyle(
                                color: Color(0xFF5d74e3),
                                fontFamily: "Poppins-Bold")),
                      )
                        */
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

//  https://www.smartherd.com/raised-button-alert-popup-dialog-widget/
  void bookflight(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text('show us&ps'),
      content: Text('\n Username : ' +
          txt_username.text +
          '\n Password : ' +
          txt_password.text),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  void aliertJson(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text('Show status'),
      content: Text(''),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  // login user,password=>https://stackoverflow.com/questions/49797558/how-to-make-http-post-request-with-url-encoded-body-in-flutter
  Future callservice() async {
//    var url = "http://iconnect.kkh.go.th:3008/login";

    final headers = {'Content-Type': 'application/json'};
//    Map<String, dynamic> body = {'username': 'dixon2', 'password': '462520'};
    Map<String, dynamic> body = {
      'username': txt_username.text,
      'password': txt_password.text
    };

    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');
    final response = await http.post(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: jsonBody,
      encoding: encoding,
    );

    var jsonDecoded = json.decode(response.body);

    var checkstatus = jsonDecoded['ok']; //check status login
    if (checkstatus) {
      var _token = jsonDecoded['token'];

      print('token : ' + _token);

      var alldata = jsonDecoded['data']; //data
      print(' all data : ' + alldata.toString());

      gettoIMEI = await getIMEI(); // call  IMEI

      var _fname = alldata['fname']; //ชื่อ
      var _lname = alldata['lname']; //นามสกุล
      var _employeeNo = alldata['employeeNo']; //เลขที่เงินเดือน

      var _tokenKey = alldata['tokenKey'];
      var _tokenExpire = alldata['tokenExpire'];

      var _empCode = alldata['employeeCode'];

      var _employeeCode = _empCode.toString();

//--------sim------------------------------------------------------------
//https://github.com/osamagamal65/sim_service/blob/master/lib/sim_service.dart
//try {

      dynamic simData = await _channel.invokeMethod('getSimData');

      Map json_simData = jsonDecode(simData);

      var _carrierName = json_simData['carrierName'];
      var _countryCode = json_simData['countryCode'];
      var _phoneNumber = json_simData['phoneNumber'];
      var _simSerialNumber = json_simData['simSerialNumber'];
      var _deviceId = json_simData['deviceId'];

//      print('sim data : ' + simData);

      var fullname = ' ชื่อ : ' +
          _fname +
          ' นามสกุล : ' +
          _lname +
          '\n' +
          ' เลขที่เงินเดือน : ' +
          _employeeNo +
          '\n' +
          ' _employeeCode ' +
          _employeeCode +
          ' tokenKey : ' +
          _tokenKey +
          '\n' +
          ' tokenExpire : ' +
          _tokenExpire +
          '\n' +
          ' employeeCode : ' +
          _employeeCode +
          '\n' +
          'get IMEI ' +
          gettoIMEI +
          '\n' +
          'phoneNumber : ' +
          _phoneNumber +
          '\n' +
          'simSerialNumber : ' +
          _simSerialNumber +
          '\n' +
          'deviceId : ' +
          _deviceId;

      List<Point<num>> l = [
//      Point(18.4851825, 73.8498851),
//      Point(18.4849214, 73.8498675),
//      Point(18.4855965, 73.8520493),
//      Point(18.4859711, 73.8512369),
//      Point(18.4857828, 73.8500299),
//      Point(18.4851825, 73.8498851)

        Point(16.428891, 102.850693),
        Point(16.428899, 102.850758),
        Point(16.429585, 102.850776),
        Point(16.429574, 102.850021),
        Point(16.429635, 102.849779),
        Point(16.431335, 102.849790),
        Point(16.431419, 102.849723),

        Point(16.431429, 102.848435),
        Point(16.430633, 102.848444),
        Point(16.430744, 102.846771), //ประตูข้าง

        Point(16.430698, 102.846760),
        Point(16.430665, 102.847132),
        Point(16.429981, 102.846998),
        Point(16.429971, 102.847251),
        Point(16.430233, 102.847303),
        Point(16.430219, 102.847951),
        Point(16.428882, 102.847924),
        Point(16.428891, 102.850693),
      ];

      // tokenExpire: 2019-09-05 21:18:48, เอาตัวนี้ไปใช้
//             https://github.com/lakexyde/flutter_localstorage

      storage.setItem("stor_checkstatus", checkstatus);
      storage.setItem("stor_fullname", _fname + ' ' + _lname);
      storage.setItem("stor_employeeNo", _employeeNo);
      storage.setItem("stor_token", _tokenKey);
      storage.setItem("stor_tokenExpire", _tokenExpire);
      storage.setItem("stor_gettoIMEI", gettoIMEI);
      storage.setItem("stor_phoneNumber", _phoneNumber);
      storage.setItem("stor_simSerialNumber", _simSerialNumber);
      storage.setItem("stor_deviceId", _deviceId);

      storage.setItem("stor_empCode", _empCode);

      storage.setItem("stor_cur_latitude", _cur_latitude);
      storage.setItem("stor_cur_longitude", _cur_longitude);

      var strg_fullname = storage.getItem("stor_fullname");

      var strg_empCode = storage.getItem("stor_empCode");

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

      if (strg_cur_latitude != null && strg_cur_longitude != null) {
        var testPolygon = ckPoly.Polygon(l);
        Point point_current = Point(strg_cur_latitude, strg_cur_longitude);
//        var checkInKKH = testPolygon.isPointInside(point_current);
        checkInKKH = testPolygon.isPointInside(point_current);
        if (checkInKKH == true) {
          str_ans = "อยู่ภาย 'ใน' พื้นที่";
          area_status = 1;
        } else {
          str_ans = "อยู่ภาย 'นอก' พื้นที";
          area_status = 0;
        }
      }

      storage.setItem("stor_checkInKKH", checkInKKH);
      storage.setItem("stor_str_ans", str_ans);
      storage.setItem("stor_area_status", area_status);

      var strg_checkInKKH = storage.getItem("stor_checkInKKH");
      var strg_str_ans = storage.getItem("stor_str_ans");
      var stor_area_status = storage.getItem("stor_area_status");

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );

      /*
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Atoff.Atoffice()));
        */

    } else {
      //login status false

      var alertDialog = AlertDialog(
        title: Text(' '),

        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        contentPadding: EdgeInsets.only(top: 5.0),

//               content:Text(' username และ password ไม่ถูกต้อง ' ),

        content: Container(
          width: 300.0,
          height: 70.0,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Username และ Password ไม่ถูกต้อง",
//                                  style: TextStyle(fontSize: 24.0),
                      ),
                    ]),
                SizedBox(
                  height: 5.0,
                ),

//                           Divider(
//                             color: Colors.grey,
//                             height: 4.0,
//                           ),
              ]),
        ),
      );

      // messagebox เข้าสู่ระบบ
//      showDialog(
//          context: context,
//          builder: (BuildContext context) {
//            return alertDialog;
//          });

    } //end else
  }

//
  Future getIMEI() async {
    var imei = await ImeiPlugin.getImei;
    return imei;
//    print('get IMEI : ' + imei);
  }

  Future msg() {
    var token_fullname = ' ชื่อ-นามสกุล : ' +
        strg_fullname +
        '\n' +
        ' เลขที่เงินเดือน : ' +
        strg_employeeNo +
        '\n' +
        ' tokenKey : ' +
        strg_token +
        '\n' +
        ' tokenExpire : ' +
        strg_tokenExpire +
        '\n' +
        ' IMEI : ' +
        strg_gettoIMEI +
        '\n' +
        ' phoneNumber : ' +
        strg_phoneNumber +
        '\n' +
        ' simSerialNumber : ' +
        strg_simSerialNumber +
        '\n' +
        ' deviceId : ' +
        strg_deviceId +
        '\n' +
        'lat,long : ' +
//          _cur_latitude.toString() +
        strg_cur_latitude.toString() +
        ',' +
        strg_checkInKKH.toString() +
        ',' +

//          _cur_longitude.toString()
        strg_cur_longitude.toString() +
        ',';

    var alertDialog = AlertDialog(
//               title:Text('response  server '),

//                 content:Text('Storage token response : '+ strg_token  ),
//                   content:Text('jsonDecode : '  + jsonDecoded.toString() ),
//                 content:Text(  fullname ),

      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      contentPadding: EdgeInsets.only(top: 50.0),

//               content:Text(  token_fullname  ),
      content: Container(
        width: 400.0, height: 220.0,
//
        child: Column(

//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     mainAxisSize: MainAxisSize.min,

            children: <Widget>[
              Row(

//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           mainAxisSize: MainAxisSize.min,

                  children: <Widget>[
                    Text(token_fullname),
                  ]),

//                       SizedBox(
//                         height: 5.0,
//                       ),

//                           Divider(
//                             color: Colors.grey,
//                             height: 4.0,
//                           ),
            ]),
      ),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  static Future<SimData> get getSimData async {
    const MethodChannel _channel = const MethodChannel('sim_service');

    try {
      dynamic simData = await _channel.invokeMethod('getSimData');
      var data = json.decode(simData);
      SimData finalSimData = SimData.fromJson(data);
      return finalSimData;
    } catch (e) {
      print('Sim Service faild to retrive sim data $e');
      throw e;
    }
  }

  Future<Null> logout() async {
    storage.setItem("stor_checkstatus", "");
    storage.setItem("stor_fullname", "");
    storage.setItem("stor_employeeNo", "");
    storage.setItem("stor_token", "");
    storage.setItem("stor_tokenExpire", "");
    storage.setItem("stor_gettoIMEI", "");
    storage.setItem("stor_phoneNumber", "");
    storage.setItem("stor_simSerialNumber", "");
    storage.setItem("stor_deviceId", "");

    storage.setItem("stor_empCode", "");

    storage.setItem("stor_cur_latitude", "");
    storage.setItem("stor_cur_longitude", "");

    storage.setItem("stor_checkInKKH", "");
    storage.setItem("stor_str_ans", "");
    storage.setItem("stor_area_status", "");

    var strg_fullname = storage.getItem("stor_fullname");

    var strg_empCode = storage.getItem("stor_empCode");

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
    var strg_str_ans = storage.getItem("stor_str_ans");
    var stor_area_status = storage.getItem("stor_area_status");
  }
}
