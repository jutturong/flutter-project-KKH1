import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:time_machine/time_machine.dart';

import 'map.dart' as mapfile;

//https://stackoverflow.com/questions/41369633/how-can-i-save-to-local-storage-using-flutter
//Future<String> getLogin() async {
//  final SharedPreferences prefs = await SharedPreferences.getInstance();
//  //  final fullname = prefs.getString("stor_fullname");
//  return prefs.getString("stor_fullname");
////  setState()
//}

final LocalStorage storage = new LocalStorage('some_key');
//Map<String, dynamic> data = storage.getItem('stor_fullname');

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

String place_status;

var now = Instant.now();

//https://androidkt.com/format-datetime-in-flutter/
var now2 = new DateTime.now();
var y = now2.year;
var date1 = new DateFormat("yyyy-MM-dd hh:mm:ss").format(now2);
var now3;

var place_location; //ถ้า place_location=0 จะอยู่นอก,place_location=1 จะอยู่ใน
var area_status;

int type_go_to_work; //ขึ้นปฏฺิบัติงาน(ปกติ-นอกเวลาราชการ)
int type_time_stamp; //ประเภทของการลงเวลา(เช้า-บ่าย)
int type_work_state; //เวร(เช้า-บ่าย)

Future setdate() async {
  try {
    await TimeMachine.initialize();
    var tzdb = await DateTimeZoneProviders.tzdb;
    var paris = await tzdb["Europe/Paris"];
    setState() {
      now3 = Instant.now();
    }
  } catch (error, stack) {
    print(error);
    print(stack);
  }
}

void main() => runApp(
      Mainpage(),
//        var tzdb = await DateTimeZoneProviders.tzdb;
    );

//-------------localtion--------------
//var currentLocation = LocationData;
//var location = new Location();

//String str_ans;

//var currentLocation = LocationData;
//var location = new Location();

//double cur_latitude = storage.getItem("cur_latitude");
//double cur_longitude = storage.getItem("cur_longitude");

//https://github.com/Lyokone/flutterlocation

//  void initState() {
//    _getLocation();
//
//    super.initState();
//  }

//-------------localtion--------------

//int _currentIndex = 0;
//final List<Widget> _children = [
////  PlaceholderWidget(Colors.white),
//];
//void onTabTapped(int index) {
//  setState() {
//    _currentIndex = index;
//  }
//}

void _onNavigationTap() {
  print('on tap');
}

//class Mainpage extends StatelessWidget {

class User {
  const User(this.name);
  final String name;
}

class Mainpage extends StatelessWidget {
//  String str_fullname = getLogin().toString();

  User selectedUser;

  List<DropdownMenuItem<int>> listDrop = [];
  int selected = null;

  List<DropdownMenuItem<int>> listDrop2 = [];

  List<DropdownMenuItem<int>> listDrop3 = [];

  //ขึ้นปฏิบัติงาน(ปกติ-นอกเวลาราชการ)
  void LoadData3() {
    listDrop3 = [];
    listDrop3
        .add(new DropdownMenuItem(child: new Text('(1)"ปกติ"  '), value: 1));
    listDrop3.add(
        new DropdownMenuItem(child: new Text('(2)"นอกเวลา(เวร)"  '), value: 2));
  }

  //ประเภทของการลงเวลา(เช้า-บ่าย)
  void loadData() {
    listDrop = [];
    listDrop.add(new DropdownMenuItem(
      child: new Text('(1)"เช้า" เข้าทำงาน'),
      value: 1,
    ));
    listDrop.add(
        new DropdownMenuItem(child: new Text('(2)"เย็น" เลิกงาน'), value: 2));
  }

  //เวร(เช้า-บ่าย)
  void LoadData2() {
    listDrop2 = [];
    listDrop2.add(new DropdownMenuItem(
        child: new Text('(1)"อยู่ในเวลาปรกติ"  '), value: 1));
    listDrop2
        .add(new DropdownMenuItem(child: new Text('(2)"เวรเช้า"  '), value: 2));
    listDrop2
        .add(new DropdownMenuItem(child: new Text('(3)"เวรบ่าย"  '), value: 3));
  }

//  Future<void> setup() async {
//    await initializeTimeZone();
//    final detroit = getLocation('America/Detroit');
//    final now = new TZDateTime.now(detroit);
//  }

  //time_machine 0.9.12
  //https://pub.dev/packages/time_machine#-example-tab-

  @override
  Widget build(BuildContext context) {
//      var call_fullname = await getFullname();

//    print('test print');

//    var alertDialog = AlertDialog(
//      title: Text('response server '),
//    );
//    showDialog(
//        context: context,
//        builder: (BuildContext context) {
//          return alertDialog;
//        });

//    _fullname
    loadData();
    LoadData2();
    LoadData3();

    if (strg_checkInKKH == true) {
      place_status = "อยู่ภาย 'ใน' พื้นที่";
//      place_location = 1;
      area_status = 1;
    } else {
      place_status = "อยู่ภาย 'นอก' พื้นที่";
//      place_location = 0;
      area_status = 0;
    }

    return MaterialApp(
        title: 'Second page',
        home: Scaffold(
          appBar:
              AppBar(title: const Text(' ระบบลงเวลาทำงาน '), actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.search,
                size: 25,
                color: Colors.white,
              ),
              tooltip: 'Alert in system',
              onPressed: () {
                print('test search');
              },
            ),

//            IconButton(
//              icon: const Icon(
//                Icons.search,
//                size: 20,
//                color: Colors.black,
//              ),
//              tooltip: 'Next page',
//              onPressed: () {},
//            ),
//            IconButton(
//              icon: const Icon(Icons.control_point,
//                  size: 20, color: Colors.black),
//            ),
          ]),
          drawer: Drawer(
            child: Column(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountEmail: Text('เลขที่เงินเดือน : ' + strg_employeeNo),
                  accountName: Text('ชื่อ-นามสกุล : ' + strg_fullname),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://avatars1.githubusercontent.com/u/200613?s=460&v=4'),
                  ),
                  otherAccountsPictures: <Widget>[
                    GestureDetector(
                      onTap: () {
//                        print("Clicked");
//                        showDialog(
//                            context: context,
//                            builder: (context) {
//                              return AlertDialog(
//                                  title: Text('Adding new account...'));
//                            });
                      },
                    ),
                    CircleAvatar(
                      child: Icon(Icons.add),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                ListTile(
//                  leading: Icon(FontAwesomeIcons.inbox),
                  leading: Icon(
                    Icons.face,
                    size: 35,
                    color: Colors.black,
                  ),
                  title: Text("MY PROFILE"),
                  trailing: Chip(
                    label: Text(
                      '11',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: Colors.blue[100],
                  ),
                ),
                ListTile(
//                  leading: Icon(FontAwesomeIcons.edit),
                  leading: Icon(
                    Icons.attach_money,
                    size: 35,
                    color: Colors.black,
                  ),
                  title: Text("เงินเดือน"),
                ),
                ListTile(
//                  leading: Icon(FontAwesomeIcons.archive),
                  leading: Icon(
                    Icons.card_giftcard,
                    size: 35,
                    color: Colors.black,
                  ),
                  title: Text("การลา"),
                ),
                ListTile(
//                  leading: Icon(FontAwesomeIcons.paperPlane),
                  leading: Icon(
                    Icons.date_range,
                    size: 35,
                    color: Colors.black,
                  ),
                  title: Text("นัดหมาย"),
                ),
                ListTile(
//                  leading: Icon(FontAwesomeIcons.trash),
                  leading: Icon(
                    Icons.business_center,
                    size: 35,
                    color: Colors.black,
                  ),
                  title: Text("บัญชีครัวเรือน"),
                ),
                Divider(),
                ListTile(
//                  leading: Icon(FontAwesomeIcons.trash),
                  leading: Icon(
                    Icons.add_alarm,
                    size: 30,
                    color: Colors.black,
                  ),
                  title: Text("สถิติการมาทำงาน"),
                ),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: ListTile(
                      leading: Icon(FontAwesomeIcons.cog),
                      title: Text("Setting"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body:

//         new const Center(
//            child:
//                Text('ยินดีต้อนรับเข้าสู่ระบบ', style: TextStyle(fontSize: 24)),
//          ),
//

              new Column(
            children: <Widget>[
              /*
              new ListTile(
                leading: const Icon(Icons.person),
                title: const Text('ชื่อ-นามสกุล'),
                subtitle: const Text(
                  "",
                ),
              ),
              new ListTile(
                leading: const Icon(Icons.today),
                title: const Text('Birthday'),
                subtitle: const Text('F'),
              ),
              new ListTile(
                leading: const Icon(Icons.group),
                title: const Text('Contact group'),
                subtitle: const Text('Not specified'),
              ),
              new ListTile(
                leading: const Icon(Icons.person),
                title: new TextField(
                  decoration: new InputDecoration(
                    hintText: "Name",
                  ),
                ),
              ),
              const Divider(
                height: 1.0,
              ),
              new ListTile(
                  leading: const Icon(Icons.pages),
                  title: new TextFormField(
//                  controller: name1,
                    decoration: InputDecoration(
                      labelText: 'test : ',
                      labelStyle: TextStyle(color: Colors.lightBlue),
                      errorStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  )),
              new ListTile(
                  leading: const Icon(Icons.storage), title: new Card()),
//              new ListTile(title: new TextFormField()),
              new ListTile(
                  leading: const Icon(Icons.four_k),
                  title: new TextField(
                    enabled: true,
                    maxLength: 2,
                    maxLengthEnforced: true,
                    style: new TextStyle(color: Colors.red),
                    obscureText: false,
                  )),
                 */

//              new ListTile(
//                leading: Icon(CustomIcons.facebook,size:12.0);
//              ),

              new ListTile(
                  leading: const Icon(
                    Icons.account_circle,
//                      color: Colors.blueAccent, size: 96.0),
                    color: Colors.black,
                  ),
                  title: new Text(
                    "ชื่อ-นามสกุล,เลขที่เงินเดือน : " +
                        strg_fullname +
                        ',' +
                        strg_employeeNo +
                        ',' +
                        strg_empCode.toString(),
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontFamily: '',
                    ),
                  )),

              /*
              new ListTile(
                leading: const Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                title: new Text(
                  "เลขที่เงินเดือน : " + strg_employeeNo,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: '',
                  ),
                ),
              ),
               */

              new ListTile(
                leading: const Icon(
                  Icons.store,
                  color: Colors.black,
                ),
                title: new Text(
                  "Token : " + strg_token,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: '',
                  ),
                ),
              ),
              new ListTile(
                leading: const Icon(
                  Icons.sync_disabled,
                  color: Colors.black,
                ),
                title: new Text(
                  "Token expire : " + strg_tokenExpire,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: '',
                  ),
                ),
              ),
              new ListTile(
                leading: const Icon(
                  Icons.speaker_phone,
                  color: Colors.black,
                ),
                title: new Text(
                  "IMEI : " + strg_gettoIMEI,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: '',
                  ),
                ),
              ),

              /*
              new ListTile(
                leading: const Icon(
                  Icons.add_call,
                  color: Colors.blueAccent,
                ),

                title: new Text(
                  "เบอร์โทรศํพท์ : " + strg_phoneNumber,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: '',
                  ),
                ),
              ),
               */

              new ListTile(
                leading: const Icon(
                  Icons.sim_card,
                  color: Colors.black,
                ),
                title: new Text(
                  "SIM serialnumber : " + strg_simSerialNumber,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: '',
                  ),
                ),
              ),

              new ListTile(
                leading: const Icon(
                  Icons.stay_current_portrait,
                  color: Colors.black,
                ),
                title: new Text(
                  "Device ID : " + strg_deviceId,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: '',
                  ),
                ),
              ),
              new ListTile(
                  leading: const Icon(
                    Icons.person_pin_circle,
                    color: Colors.black,
                  ),
                  title: new Text(
                    "Location (lat,long) : " +
                        strg_cur_latitude.toString() +
                        ',' +
                        strg_cur_longitude.toString(),
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontFamily: '',
                    ),
                  )),

              new ListTile(
                leading: const Icon(
                  Icons.person_pin_circle,
                  color: Colors.green,
                ),
                title: new Text(
                  "ตรวจสอบบริเวณ : " + place_status,
                  style: TextStyle(fontSize: 17.0, color: Colors.green),
                ),
              ),

              new ListTile(
                  leading: const Icon(
                    Icons.access_time,
                    color: Colors.green,
                  ),
                  title: new Text(
//                    "เวลาปัจจุบัน : ${DateTimeZone.local}",
//                    "เวลาปัจจุบัน : ${now.inLocalZone().toString('dddd yyyy-MM-dd HH:mm z')}",
//                    "เวลาปัจจุบัน : " + now2.toLocal().toString(),
                    "เข้าสู่ระบบเวลา : " + date1,
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                      fontFamily: '',
                    ),
                  )),

              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
//                    Container(
//                      padding: const EdgeInsets.all(0.0),
//                      color: Colors.cyanAccent,
//                      width: 80.0,
//                      height: 80.0,
//                    ),

//                    https://medium.com/@serbelga/material-components-bottomappbar-flutter-9008a6e54382
//                    FloatingActionButton.extended(
//                      icon: Icon(Icons.camera_front),
////                      label: Text('ลงเวลา'),
//                      onPressed: () {},
//                    ),
                  ]),

              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.only(left: 10.0, right: 16.0, top: 16.0),
                    ),
                    Expanded(
                      child: new DropdownButton(
                        iconSize: 15,
                        elevation: 16,
                        isExpanded: true,
                        icon: Icon(
                          Icons.computer,
                          color: Colors.black,
                        ),

                        value: selected,
                        items: listDrop3,
                        hint: new Text(
                          '* ขึ้นปฏิบัติงาน (ปกติ-นอกเวลาราชการ) :  ',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'THSaraban',
                          ),
                        ),
//                        onChanged: (value) => print('you selected $value')
                        underline: Container(
                          height: 1,
                          color: Colors.blue,
                        ),
                        onChanged: (int value) {
//                          int type_go_to_work;

                          setState() {
//                            return selected value;
                            return value;
//                            return type_go_to_work = 4;
                          }

                          type_go_to_work = value;

                          /*
                          var alertDialog = AlertDialog(
                            title: Text('Sever resonse'),

//                            content: Text(value.toString()),
                            content: Text(type_go_to_work.toString()),
                          );
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alertDialog;
                              });
                          */
                        },
                      ),
                    )
                  ]),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.only(left: 10.0, right: 20.0, top: 16.0),
                  ),
                  Expanded(
//                    fliex:2,
                    child: new DropdownButton(
                      icon: Icon(
                        Icons.contact_mail,
                        color: Colors.black,
                      ),
                      iconSize: 15,
                      elevation: 16,
                      isDense: false,
                      isExpanded: true,
                      value: selected,
                      items: listDrop,
                      hint: new Text(
                        '* ประเภทของการลงเวลา (เช้า-บ่าย) :  ',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'THSaraban',
                        ),
                      ),
                      underline: Container(
                        height: 1,
                        color: Colors.blue,
                      ),
//                        onChanged: (value) => print('you selected $value')
                      onChanged: (int value) {
                        setState() {
                          return value;
                        }

                        type_time_stamp = value;
                      },
                    ),
                  ),
                ],
              ),

              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.only(left: 10.0, right: 16.0, top: 16.0),
                    ),
                    Expanded(
                      child: new DropdownButton(
                        iconSize: 15,
                        elevation: 16,
                        isExpanded: true,
                        icon: Icon(
                          Icons.control_point_duplicate,
                          color: Colors.black,
                        ),
                        value: selected,
                        items: listDrop2,
                        hint: new Text(
                          '* เวร (เช้า-บ่าย) :  ',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'THSaraban',
                          ),
                        ),
//                        onChanged: (value) => print('you selected $value')
                        underline: Container(
                          height: 1,
                          color: Colors.blue,
                        ),
                        onChanged: (int value) {
                          setState() {
                            return value;
                          }

                          type_work_state = value;
                        },
                      ),
                    )
                  ]),

              /*
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(10),
              ),
                */

              FloatingActionButton(
                  mini: false,
//                        disabledElevation: 3.0,
                  tooltip: 'ลงเวลาทำงาน',
                  child: new Icon(
                    Icons.assignment_turned_in,
                    size: 25.0,
                    color: Colors.black,
                  ),
                  backgroundColor: Colors.white,
                  onPressed: () {
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) => prefix0.Map()),
//                    );

                    /*
                    var alertDialog = AlertDialog(
                      title: Text('Response Status'),
                      content: Text('test..e'),
                    );
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alertDialog;
                        });
                        
                   */

                    sendValue(context);
                  }),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: 0,
            backgroundColor: Colors.blue[100],
            onTap: (index) {
//              print("selected Index : $index ");
              switch (index) {
                case 0:
//                  print("selected Index : $index ");

                  break;
                case 1:
                  Navigator.pop(context);

                  break;
                case 2:
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => mapfile.Map()));

                  break;
              }
            },

            type: BottomNavigationBarType.fixed,
//            currentIndex: _currentIndex,
//            onTap: onTabTapped,
            items: const <BottomNavigationBarItem>[
//            BottomNavigationBarItem(
//              icon: Icon(Icons.home),
//              title: Text('Home'),
//            ),

              BottomNavigationBarItem(
                icon: Icon(
                  Icons.cast_connected,
                  size: 20,
                  color: Colors.black,
                ),
                title: Text('Menu'),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.lock_open,
                  size: 20,
                  color: Colors.black,
                ),
                title: Text('Logout'),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_location,
                  size: 20,
                  color: Colors.green,
                ),
                title: Text(
                  'Map KKH',
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'THSaraban'),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.dashboard,
                  size: 20,
                  color: Colors.black,
                ),
                title: Text('About Us'),
              )
            ],

//            currentIndex: _selectedIndex,
          ),
        ));
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }

  Future sendValue(BuildContext context) async {
    //ตัวอย่างการเรียกใช้งาน

    var urlbackend = "http://10.3.42.163:3008/apptime/";
    var urlbackend2 = "http://10.3.42.163:3008/usertimelog/";
    final headers = {'Content-Type': 'application/json'};

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd hh:mm:ss').format(now);

//    Map<String, dynamic> body = {'username': 'a1631', 'password': 'basic4321'};
    Map<String, dynamic> body = {
      "employeeCode": strg_empCode,
      "employeeNo": strg_employeeNo,
      "IMEI": strg_gettoIMEI,
      "simserial": strg_simSerialNumber,
      "deviceID": strg_deviceId,
      "timelog": formattedDate
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');
    final response = await http.post(
//      'http://iconnect.kkh.go.th:3008/login/old-user',
//      'http://10.3.42.21:3008/login/old-user',
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

    //----ถ้าค่ามีการบันทึกในฐานข้อมูล---------
    if (checkstatus) {
//      var _token = jsonDecoded['token'];

      /*
      var alertDialog = AlertDialog(
        title: Text('Sever resonse'),
//        content: Text('' + jsonDecoded.toString() + '=>' + result.toString()),
//        content: Text(jsonDecoded.toString() + '|' ',' + result.toString() + ',' + id_user.toString()  ),
        content: Text(id_user.toString()),
      );
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return alertDialog;
          });
     */

//      print('print user_id : ' + id_user.toString());

      Map<String, dynamic> body2 = {
        "data": {
          "id_user": id_user.toString(),
          "place_location": strg_cur_latitude.toString() +
              "," +
              strg_cur_longitude.toString(),
          "area_status": area_status.toString(), //0=นอก,1=ใน
          "time_stamp_work": date1.toString(),

          "type_go_to_work": type_go_to_work.toString(),
          "type_time_stamp": type_time_stamp.toString(),
          "type_work_state": type_work_state.toString(),
          "timelog": formattedDate.toString()
        }
      };
      String jsonBody2 = json.encode(body2);
      final response2 = await http.post(
//      'http://iconnect.kkh.go.th:3008/login/old-user',
//      'http://10.3.42.21:3008/login/old-user',
        urlbackend2,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonBody2,
        encoding: encoding,
      );
      var jsonDecoded2 = json.decode(response2.body);

      var alertDialog = AlertDialog(
        title: Text('Sever resonse'),
//        content: Text('' + jsonDecoded.toString() + '=>' + result.toString()),
//        content: Text(jsonDecoded.toString() + '|' ',' + result.toString() + ',' + id_user.toString()  ),
        content: Text(jsonDecoded2.toString() + '\n' + body2.toString()),
      );
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return alertDialog;
          });
    }
  }

//  void getText() => print('get test');

}
