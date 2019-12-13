import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

class Mainpage extends StatelessWidget {
//  String str_fullname = getLogin().toString();

  List<DropdownMenuItem<int>> listDrop = [];
  int selected = null;

  List<DropdownMenuItem<int>> listDrop2 = [];

  List<DropdownMenuItem<int>> listDrop3 = [];

  void loadData() {
    listDrop = [];
    listDrop.add(new DropdownMenuItem(
      child: new Text('"เช้า" ทำงาน'),
      value: 1,
    ));
    listDrop
        .add(new DropdownMenuItem(child: new Text('"เย็น" เลิกงาน'), value: 2));
//    listDrop.add(new DropdownMenuItem(child: new Text('B'), value: '3'));
//    listDrop.add(value)
  }

  void LoadData2() {
    listDrop2 = [];
    listDrop2.add(new DropdownMenuItem(child: new Text('"เช้า"  '), value: 1));
    listDrop2.add(new DropdownMenuItem(child: new Text('"บ่าย"  '), value: 2));
  }

  void LoadData3() {
    listDrop3 = [];
    listDrop3.add(new DropdownMenuItem(child: new Text('"ปกติ"  '), value: 1));
    listDrop3
        .add(new DropdownMenuItem(child: new Text('"นอกเวลา"  '), value: 2));
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
    } else {
      place_status = "อยู่ภาย 'นอก' พื้นที่";
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
                        strg_employeeNo,
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
                  Icons.add_to_queue,
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
                    "เวลาปัจจุบัน : " + date1,
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
                        EdgeInsets.only(left: 10.0, right: 20.0, top: 16.0),
                  ),
                  Expanded(
//                    fliex:2,
                    child: new DropdownButton(
                      icon: Icon(
                        Icons.contact_mail,
                        color: Colors.black,
                      ),
                      iconSize: 20,
                      elevation: 16,
                      isDense: false,
                      isExpanded: true,
                      value: selected,
                      items: listDrop,
                      hint: new Text(
                        'ประเภทของการลงเวลา :  ',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'THSaraban',
                        ),
                      ),
                      underline: Container(
                        height: 1,
                        color: Colors.blue,
                      ),
//                        onChanged: (value) => print('you selected $value')
                      onChanged: (value) {
                        setState() {
                          return selected = value;
                        }
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
                        iconSize: 20,
                        elevation: 16,
                        isExpanded: true,
                        icon: Icon(
                          Icons.control_point_duplicate,
                          color: Colors.black,
                        ),
                        value: selected,
                        items: listDrop2,
                        hint: new Text(
                          'เวร :  ',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'THSaraban',
                          ),
                        ),
//                        onChanged: (value) => print('you selected $value')
                        underline: Container(
                          height: 1,
                          color: Colors.blue,
                        ),
                        onChanged: (value) {
                          setState() {
                            return selected = value;
                          }
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
                          EdgeInsets.only(left: 10.0, right: 16.0, top: 16.0),
                    ),
                    Expanded(
                      child: new DropdownButton(
                        iconSize: 20,
                        elevation: 16,
                        isExpanded: true,
                        icon: Icon(
                          Icons.computer,
                          color: Colors.black,
                        ),

                        value: selected,
                        items: listDrop3,
                        hint: new Text(
                          'ขึ้นปฏิบัติงาน :  ',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'THSaraban',
                          ),
                        ),
//                        onChanged: (value) => print('you selected $value')
                        underline: Container(
                          height: 1,
                          color: Colors.blue,
                        ),
                        onChanged: (value) {
                          setState() {
                            return selected = value;
                          }
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
                    Icons.add_to_home_screen,
                    size: 22.0,
                    color: Colors.green,
                  ),
                  backgroundColor: Colors.black,
                  onPressed: () {
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) => prefix0.Map()),
//                    );
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

//  void getText() => print('get test');

}
