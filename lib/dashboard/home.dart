import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_page_ui/main.dart' as login;
import 'package:flutter_login_page_ui/map.dart';
import 'package:flutter_login_page_ui/worktime/atoffice.dart';
import 'package:flutter_login_page_ui/worktime/atoffice2.dart';
import 'package:intl/intl.dart';

var strg_fullname = login.storage.getItem("stor_fullname");

//SECRET_KEY=072f789acfee57e2c542da0d5169b4b8
const String sharedSecret = '072f789acfee57e2c542da0d5169b4b8';

//var strg_empCode = storage.getItem("stor_empCode");

var strg_empCode = login.storage.getItem("stor_empCode"); //code ใน employee

var strg_employeeNo = login.storage.getItem("stor_employeeNo");
var strg_token = login.storage.getItem("stor_token");

var strg_tokenExpire = login.storage.getItem("stor_tokenExpire");
var strg_gettoIMEI = login.storage.getItem("stor_gettoIMEI");
var strg_phoneNumber = login.storage.getItem("stor_phoneNumber");
var strg_simSerialNumber = login.storage.getItem("stor_simSerialNumber");
var strg_deviceId = login.storage.getItem("stor_deviceId");

var strg_cur_latitude = login.storage.getItem("stor_cur_latitude");
var strg_cur_longitude = login.storage.getItem("stor_cur_longitude");

var strg_checkInKKH = login.storage.getItem("stor_checkInKKH");
//var strg_str_ans = storage.getItem("stor_str_ans");

//storage.setItem("stor_checkInKKH", checkInKKH);
//storage.setItem("stor_str_ans", str_ans);

var stor_checkInKKH = login.storage.getItem("stor_checkInKKH");
var stor_str_ans = login.storage.getItem("stor_str_ans");

DateTime now = DateTime.now();
String formattedDate = DateFormat('yyyy-MM-dd hh:mm:ss').format(now);

//Token => https://www.youtube.com/watch?v=BCbO4iRNNsM
var getToken = ""; //คืนค่า Token จาก login

var header = {
  "alg": "HS256",
  "typ": "JWT",
};

String header64 = jsonEncode(header);

var rountworking =
    new MaterialPageRoute(builder: (BuildContext context) => new SecondRoute());

//var SECRET_KEY = '072f789acfee57e2c542da0d5169b4b8';

final List<String> _listViewData = [
  "A List View with many Text - Here's one!",
  "A List View with many Text - Here's another!",
  "A List View with many Text - Here's more!",
  "A List View with many Text - Here's more!",
];

class Home extends StatelessWidget {
  BuildContext get context => null;

  void initState() {
    checkToken(context);
//    print(" Storage token response : " + strg_token);
  }

  void msgconfigmobile() {
    var alertDialog = AlertDialog(
      title: Text(''),
      backgroundColor: Colors.yellow,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      contentPadding: EdgeInsets.only(top: 0.0),
//                                content: Text('test'),
      content: Container(
        width: 500,
        height: 270,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.bubble_chart,
                    size: 40,
                    color: Colors.black,
                  ),
                  Text('ข้อมูลระบบ'),
                ]),
            SizedBox(
              height: 5.0,
            ),
            Divider(
              color: Colors.black,
              height: 4.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'รหัสเครื่อง : ' + strg_gettoIMEI,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'รหัสโทรศัพท์ : ' + strg_deviceId,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'รหัส SIM : ' + strg_simSerialNumber.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Token Expire  : ' + strg_tokenExpire.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'เวลาเข้าสู่ระบบ  : ' + formattedDate.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.black,
              height: 4.0,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {},
                    child: Text(
                      'ปิด',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  RaisedButton(
                    onPressed: () {
                      /*
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      gotomap.Map()),
                                            );
                                             */
                    },
                    child: Text(
                      'Google Map',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  ),
                ]),
          ],
        ),
      ),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          InputBorder.none;
          return alertDialog;
        });
  }

  Widget menuIcon({
    @required Size deviceSize,
    @required String text,
    @required IconData icon,

//    @required title,
//    @required description,
//    @required buttonText, image,
  }) {
    return Container(
      height: 60.0,
      width: deviceSize.width / 5,
      padding: EdgeInsets.all(2.0),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Icon(
              icon,
              color: Colors.grey[100],
            ),
          ),
          Text(
            text,
            style: TextStyle(
              color: Colors.grey[100],
            ),
          ),
        ],
      ),
    );
  }

  Widget mainMenuIcon({
    @required Size deviceSize,
    @required String text,
    @required String src,
  }) {
    return Container(
      padding: EdgeInsets.all(6.0),
      child: Column(
        children: <Widget>[
          Container(
            child: CircleAvatar(
              child: Image.asset(src),
              foregroundColor: Colors.red,
              backgroundColor: Colors.white,
            ),
            width: 80.0,
            height: 80.0,
            padding: EdgeInsets.all(2.0), // borde width
            decoration: BoxDecoration(
              color: Colors.grey[200], // border color
              shape: BoxShape.circle,
            ),
          ),
          Text(text),
        ],
      ),
    );
  }

  Widget topMenu({
    @required Size deviceSize,
  }) {
    return Row(
      children: <Widget>[
        menuIcon(
          deviceSize: deviceSize,
          icon: Icons.folder_shared,
          text: "หน้าหลัก",
        ),
        menuIcon(
          deviceSize: deviceSize,
          icon: Icons.directions_walk,
          text: "ข่าว",
        ),
        menuIcon(
          deviceSize: deviceSize,
          icon: Icons.monetization_on,
          text: "DASHBOARD",
        ),
        menuIcon(
          deviceSize: deviceSize,
          icon: Icons.account_balance_wallet,
          text: "SETUP",
        ),
        menuIcon(
          deviceSize: deviceSize,
          icon: Icons.signal_cellular_4_bar,
          text: "ABOUT",
        ),
      ],
    );
  }

  Widget balanceInfo() {
    return Container(
      padding: EdgeInsets.only(left: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("ชื่อ-นามสกุล : " + strg_fullname,
                  style: TextStyle(
                    color: Colors.grey[200],
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  )),
              Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      "เลขที่เงินเดือน : ",
                      style: TextStyle(
                        color: Color(0xffd0993c),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    "" + strg_employeeNo,
                    style: TextStyle(
                      color: Color(0xffd0993c),
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Text("รหัสพนักงาน : ",
                      style: TextStyle(
//                        color: Colors.grey[200],
//                        fontSize: 15.0,
                        color: Color(0xffd0993c),
                        fontWeight: FontWeight.bold,
                      )),
                  Text(
                    "" + strg_empCode.toString(),
                    style: TextStyle(
                      color: Color(0xffd0993c),
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(

                  /*
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  Icons.refresh,
                  color: Colors.white,
                  size: 40.0,
                ),
                */

                  ),
              Container(
                height: 50.0,
                width: 120.0,

                /*
                child: RaisedButton(


                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(9.0))),
                  child: Text(
                    "ออกจากระบบ ",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: Color(0xFF14b8c7),
                  onPressed: () {
                    //redirect ออกจากระบบ
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => login.MyApp()));

//                    msg('response','test');
                  },
                ),
                */
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget stackedMenuIcon({
    @required Size deviceSize,
    @required String src,
    @required String text,
  }) {
    return Container(
      width: (deviceSize.width - 45) / 3,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 12.0),
            child: Image.asset(src),
          ),
          Text(text),
        ],
      ),
    );
  }

  Widget stackedMenuSeparator() {
    return Container(
      height: double.infinity,
      width: 2.0,
      color: Colors.grey[300],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4d2a86),
        elevation: 0.0,
        title: Container(
//          child: Image.asset("res/images/ovo_logo.png"),
//          child: Image.asset("assets/Kkh1.jpg"),
            ),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
//            child: Icon(FontAwesomeIcons.bell),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.settings),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(250.0),
          child: Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.white),
            child: Container(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  topMenu(
                    deviceSize: deviceSize,
                  ),
                  Container(
                    height: 1.0,
                    color: Colors.grey[500],
                  ),
                  balanceInfo(),
                  Stack(
                    children: <Widget>[
                      Container(
                        height: 95.0,
                        color: Color(0xFF4d2a86),
                      ),
                      Positioned(
                        top: 50.0,
                        child: Container(
                          height: 45.0,
                          width: deviceSize.width,
                          color: Color(0xfffafafa),
                        ),
                      ),
                      Positioned(
                        top: 10.0,
                        left: 20.0,
                        child: Card(
                          child: Container(
                            height: 80.0,
                            width: deviceSize.width - 40,
                            color: Colors.white,
                            child: Row(
                              children: <Widget>[
                                stackedMenuIcon(
                                  src: "res/images/transfer.png",
                                  text: "MY PROFILE",
                                  deviceSize: deviceSize,
                                ),
                                stackedMenuSeparator(),
                                stackedMenuIcon(
                                  src: "res/images/scan.png",
                                  text: "Scan",
                                  deviceSize: deviceSize,
                                ),
                                stackedMenuSeparator(),
                                stackedMenuIcon(
                                  src: "res/images/user_id.png",
                                  text: "ข้อมูลส่วนตัว",
                                  deviceSize: deviceSize,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      /*
       body:Center(
         child: Container(
           child: Column(
             children: <Widget>[

             ],
           ),
         ),
       )
        */

      /*
      body: ListView(
          padding: const EdgeInsets.all(8.0),
          itemExtent: 106.0,
          children: <Home>[
            Home(
              user: 'Flutter',
              viewCount: 999000,
              thumbnail: Container(
                decoration: const BoxDecoration(color: Colors.blue),
              ),
              title: 'The Flutter YouTube Channel',
            ),
          ]),
       */

      /*
      body: ListView(children: const <Widget>[
        Card(
          child: ListTile(
            leading: FlutterLogo(size: 56.0),
            title: Text('Two-line ListTile'),
            subtitle: Text('Here is a second line'),
            trailing: Icon(Icons.more_vert),
          ),
        ),
        Card(
          child: ListTile(
            leading: FlutterLogo(size: 72.0),
            title: Text('Three-line ListTile'),
            subtitle:
                Text('A sufficiently long subtitle warrants three lines.'),
            trailing: Icon(Icons.more_vert),
            isThreeLine: true,
          ),
        ),
        Card(
          child: ListTile(
            leading: FlutterLogo(size: 72.0),
//          leading: Icon(
//              Icons.add_alarm,
//              size: 40,
//            ),
//            title: Text('A'),

            title: FloatingActionButton(
//              onPressed:(){ },
              child: Icon(Icons.add),
              backgroundColor: Colors.grey,
            ),
            subtitle: Text('ลงเวลาทำงาน'),
            trailing: Icon(Icons.more_vert),
            isThreeLine: false,

          ),
        ),
      ]),
      */

      body: GridView.count(
        crossAxisCount: 4,
        padding: EdgeInsets.all(8.0),
        mainAxisSpacing: 5.0,
        children: <Widget>[
          Card(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: ListTile(
//                leading: FlutterLogo(size: 50.0),
//                leading: Icon(Icons.add),
//                leading: FloatingActionButton(),

                leading: CircleAvatar(
                  radius: 30.0,
//                  backgroundColor: Colors.brown,
                  backgroundImage: NetworkImage(
                      'https://cdn3.iconfinder.com/data/icons/business-and-seo-7/48/53-128.png'),
                  backgroundColor: Colors.transparent,
//                  foregroundColor: Colors.black,
//                  child: Text('ลงเวลาทำงาน'),
                ),

//                title: Text('One-line ListTile'),
//                title: FloatingActionButton(
//                  child: Icon(
//                    Icons.perm_contact_calendar,
//                    size: 30.0,
//                    color: Colors.white,
//                  ),
//                  backgroundColor: Colors.blue,
////                  shape: RoundedRectangleBorder(
////                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
//                ),
                subtitle: Text('ลงเวลาทำงาน',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold)),
//                trailing: Icon(
//                  Icons.bluetooth_audio,
//                  color: Colors.black,
//                ),
                onTap: () {
//                  print('ontap 1');

//                  checkToken(context); //check token

//                backup code redirect

                  /*  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SecondRoute()));*/

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RouteAtoffice2()));
                },
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: ListTile(
//                leading: FlutterLogo(size: 50.0),
                leading: CircleAvatar(
                  radius: 30.0,
//                  backgroundColor: Colors.brown,
                  backgroundImage: NetworkImage(
                      'https://cdn3.iconfinder.com/data/icons/business-and-seo-7/48/84-128.png'),
                  backgroundColor: Colors.transparent,
//                  foregroundColor: Colors.black,
//                  child: Text('ลงเวลาทำงาน'),
                ),
//                leading: Icon(Icons.four_k, size: 40),
//                leading: FloatingActionButton(),
//                title: Text('>> ตรวจสอบ'),
//                title: FloatingActionButton(),
//                title: FloatingActionButton(
//                  child: Icon(
//                    Icons.compare,
//                    size: 30.0,
//                  ),
//                  backgroundColor: Colors.blue,
//                ),
//                title: FloatingActionButton(
//                  child: Icon(
//                    Icons.compare,
//                    size: 30.0,
//                  ),
//                  backgroundColor: Colors.blue,
//                ),
//                leading: Icon(
//                  Icons.add_location,
//                  size: 40,
//                ),
//                title: Text('>>ตำแหน่งที่เราอยู่'),
                subtitle: Text('>>ตำแหน่งที่เราอยู่',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold)),
////                trailing: Icon(Icons.more_vert),
//                trailing: Icon(
//                  Icons.bluetooth_audio,
//                  color: Colors.black,
////                  size: 40,
//                ),
                onTap: () {
//                  print('ontap 1');
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MapRoute()));
                },
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: ListTile(
//                leading: FlutterLogo(size: 56.0),
                leading: CircleAvatar(
                  radius: 30.0,
//                  backgroundColor: Colors.brown,
                  backgroundImage: NetworkImage(
                      'https://cdn3.iconfinder.com/data/icons/business-and-seo-7/48/83-128.png'),
                  backgroundColor: Colors.transparent,
//                  foregroundColor: Colors.black,
//                  child: Text('ลงเวลาทำงาน'),
                ),
//                title: Text('Two-line ListTile'),
//                title: FloatingActionButton(),
                subtitle: Text('Config ระบบจากมือถือ'),
//                trailing: Icon(Icons.more_vert),
//                trailing: Icon(
//                  Icons.bluetooth_audio,
//                  color: Colors.black,
//                ),
                onTap: () {
//                  msgconfigmobile();

                  var alertDialog = AlertDialog(
                    title: Text(''),
                    backgroundColor: Colors.yellow,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0))),
                    contentPadding: EdgeInsets.only(top: 0.0),
//                                content: Text('test'),
                    content: Container(
                      width: 500,
                      height: 270,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.bubble_chart,
                                  size: 40,
                                  color: Colors.black,
                                ),
                                Text('ข้อมูลระบบ'),
                              ]),
                          SizedBox(
                            height: 5.0,
                          ),
                          Divider(
                            color: Colors.black,
                            height: 4.0,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'รหัสเครื่อง : ' + strg_gettoIMEI,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'รหัสโทรศัพท์ : ' + strg_deviceId,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'รหัส SIM : ' + strg_simSerialNumber.toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Token Expire  : ' +
                                    strg_tokenExpire.toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'เวลาเข้าสู่ระบบ  : ' +
                                    formattedDate.toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.black,
                            height: 4.0,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                RaisedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'ปิด',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                RaisedButton(
                                  onPressed: () {
                                    /*
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      gotomap.Map()),
                                            );
                                             */
                                  },
                                  child: Text(
                                    'Google Map',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                ),
                              ]),
                        ],
                      ),
                    ),
                  );
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        InputBorder.none;
                        return alertDialog;
                      });
                },
              ),
            ),
          ),
        ],
      ),

      /*
      body: Center(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                FloatingActionButton(
                  child: Icon(
                    Icons.departure_board,
//                               src: "res/images/pulsa.png",
                    size: 40.0,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SecondRoute()));
                  },
                ),
              ],
            ),
            Row(),
          ],


        ),
      ),
      */

      /*
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 30.0,
                          ),
                        ]),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: <
                        Widget>[
                      FloatingActionButton(
                        child: Icon(
                          Icons.departure_board,
//                              src: "res/images/pulsa.png",
                          size: 40.0,
                        ),
                        backgroundColor: Colors.blue,

                        foregroundColor: Colors.white,
//                            shape: RoundedRectangleBorder(
//                                side: BorderSide(color: Colors.pink)),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0))),
                        onPressed: () {
                          var alertDialog = AlertDialog(
                            title: Text(''),
                            backgroundColor: Colors.green[400],
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32.0))),
                            contentPadding: EdgeInsets.only(top: 0.0),
//                                content: Text('test'),
                            content: Container(
                              width: 500,
                              height: 900,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.bubble_chart,
                                          size: 50,
                                          color: Colors.white,
                                        ),
//                                        Text('บันทึกการลงเวลาทำงาน'),
                                      ]),
                                  SizedBox(
                                    height: 5.0,
                                  ),

                                  /*
                                  Divider(
                                    color: Colors.grey,
                                    height: 10.0,
                                  ),
                                    */

                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'ชื่อ-นามสกุล : ' + strg_fullname,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'เลขที่เงินเดือน : ' + strg_employeeNo,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'รหัสพนักงาน : ' +
                                            strg_empCode.toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'GPS  : ' +
                                            strg_cur_latitude.toString() +
                                            ',' +
                                            strg_cur_longitude.toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Location  : ' +
                                            stor_str_ans.toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'เวลาที่เข้าสู่ระบบ  : ' +
                                            formattedDate.toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                            // tag: 'hero',
                                            child: LinearProgressIndicator(
                                                backgroundColor: Color.fromRGBO(
                                                    209, 224, 224, 0.2),
                                                value: null,
                                                valueColor:
                                                    AlwaysStoppedAnimation(
                                                        Colors.grey)),
                                          )),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 20.0,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0))),
                                            child: Column(
                                              children: <Widget>[
                                                Row(children: <Widget>[
                                                  SizedBox(
                                                    height: 10.0,
                                                    width: 5.0,
                                                  ),
                                                  Icon(
                                                    Icons.filter_1,
                                                    color: Colors.red,
                                                  ),
                                                  Text(
                                                    'เข้า 08:00 - ออก 16:00 ',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 30.0),
                                                  ),
                                                ]),
                                                Row(
                                                  children: <Widget>[
                                                    FloatingActionButton(
                                                      onPressed: () {
//                                                        /*
//                                                        print(
//                                                            'เข้า 8:00 - ออก 16:00 ');
//                                                        */

                                                        /*
                                                      Navigator.push(
                                                        context,MaterialPageRoute(builder: (context)=>gotomap.Map())
                                                      );
                                                       */
                                                      },
                                                      child: Icon(
                                                          Icons.fingerprint),
                                                      backgroundColor:
                                                          Colors.black,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 20.0,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0))),
                                            child: Column(
                                              children: <Widget>[
                                                Row(children: <Widget>[
                                                  SizedBox(
                                                    height: 10.0,
                                                    width: 5.0,
                                                  ),
                                                  Icon(
                                                    Icons.filter_1,
                                                    color: Colors.red,
                                                  ),
                                                  Text(
                                                    'เข้า 08:30 - ออก 16:30 ',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 30.0),
                                                  ),
                                                ]),
                                                Row(
                                                  children: <Widget>[
                                                    FloatingActionButton(
                                                      onPressed: () {
                                                        print(
                                                            'เข้า 08:30 - ออก 16:30 ');
                                                      },
                                                      child: Icon(
                                                          Icons.fingerprint),
                                                      backgroundColor:
                                                          Colors.black,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 20.0,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0))),
                                            child: Column(
                                              children: <Widget>[
                                                Row(children: <Widget>[
                                                  SizedBox(
                                                    height: 10.0,
                                                    width: 5.0,
                                                  ),
                                                  Icon(
                                                    Icons.filter_2,
                                                    color: Colors.red,
                                                  ),
                                                  Text(
                                                    'เข้า 16:30 - ออก 24:00 ',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 30.0),
                                                  ),
                                                ]),
                                                Row(
                                                  children: <Widget>[
                                                    FloatingActionButton(
                                                      onPressed: () {
                                                        print(
                                                            'เข้า 16:30 - ออก 24:00 ');
                                                      },
                                                      child: Icon(
                                                          Icons.fingerprint),
                                                      backgroundColor:
                                                          Colors.black,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 20.0,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0))),
                                            child: Column(
                                              children: <Widget>[
                                                Row(children: <Widget>[
                                                  SizedBox(
                                                    height: 10.0,
                                                    width: 5.0,
                                                  ),
                                                  Icon(
                                                    Icons.filter_3,
                                                    color: Colors.red,
                                                  ),
                                                  Text(
                                                    'เข้า 24:00 - ออก 08:00 ',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 30.0),
                                                  ),
                                                ]),
                                                Row(
                                                  children: <Widget>[
                                                    FloatingActionButton(
                                                      onPressed: () {
                                                        print(
                                                            'เข้า 24:00 - ออก 8:00 ');
                                                      },
                                                      child: Icon(
                                                          Icons.fingerprint),
                                                      backgroundColor:
                                                          Colors.black,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        RaisedButton(
                                          /*
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        gotomap.Map()));
                                          },
                                           */

                                          onPressed: () => Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      SecondRoute())),
                                          child: Text(
                                            'สถิติการมาทำงาน',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          color: Colors.purple,
                                          highlightColor: Colors.orange,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0))),
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        RaisedButton(
                                          onPressed: () {},
                                          child: Text('ปิด'),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0))),
                                        ),
                                      ]),
                                ],
                              ),
                            ),
                          );
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                InputBorder.none;
                                return alertDialog;
                              });
                        },
                      ),
                      SizedBox(
//                            height: 30.0,
                        width: 40.0,
                      ),
                      FloatingActionButton(
                        child: Icon(Icons.build, size: 35),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0))),
                        onPressed: () {
//                          print("onpress1");
                          var alertDialog = AlertDialog(
                            title: Text(''),
                            backgroundColor: Colors.yellow,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32.0))),
                            contentPadding: EdgeInsets.only(top: 0.0),
//                                content: Text('test'),
                            content: Container(
                              width: 500,
                              height: 270,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.bubble_chart,
                                          size: 40,
                                          color: Colors.black,
                                        ),
                                        Text('ข้อมูลระบบ'),
                                      ]),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Divider(
                                    color: Colors.black,
                                    height: 4.0,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'รหัสเครื่อง : ' + strg_gettoIMEI,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'รหัสโทรศัพท์ : ' + strg_deviceId,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'รหัส SIM : ' +
                                            strg_simSerialNumber.toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Token Expire  : ' +
                                            strg_tokenExpire.toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'เวลาเข้าสู่ระบบ  : ' +
                                            formattedDate.toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.black,
                                    height: 4.0,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        RaisedButton(
                                          onPressed: () {},
                                          child: Text(
                                            'ปิด',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0))),
                                        ),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        RaisedButton(
                                          onPressed: () {
                                            /*
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      gotomap.Map()),
                                            );
                                             */
                                          },
                                          child: Text(
                                            'Google Map',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0))),
                                        ),
                                      ]),
                                ],
                              ),
                            ),
                          );
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                InputBorder.none;
                                return alertDialog;
                              });
                        },
                      ),
                      SizedBox(
//                            height: 30.0,
                        width: 40.0,
                      ),
                      FloatingActionButton(
                        child: Icon(Icons.date_range, size: 45),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0))),
                        onPressed: () {
                          print("onpress1");
                        },
                      ),
                      SizedBox(
//                            height: 30.0,
                        width: 40.0,
                      ),
                      FloatingActionButton(
                          child: Icon(Icons.block),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0))),

                          /*
                        onPressed: () {
//                          print("onpress1");
//                            Navigator.push(context, );

                        /*
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SecondRoute()));

                         */




                          child:
                          Icon(Icons.add, color: Colors.white);
                        },
                        */

                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SecondRoute()))
                          /*
                            Navigator.of(context).push(MaterialPageRoute(


                                builder: (context) => Scaffold(
                                      appBar: AppBar(
                                        title: Text('Simple rounte'),
                                      ),
                                      body: Center(
                                        child: Text('Test page'),
                                      ),
                                    ))),
                            */

                          ),
                    ]),
                    Row(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20.0),
                      height: 140.0,
                      child: ListView(
                        // This next line does the trick.
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      */

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        backgroundColor: Colors.blue[100],
        onTap: (index) {
//              print("selected Index : $index ");
          switch (index) {
            case 0:
              print("selected Index : $index ");

              break;
            case 1:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => login.MyApp()));

              break;
            case 2:
              print('ทดสอบ');
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

          /*
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
          */

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
    );
  }

  Future checkToken(context) {
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
            Text(' Token expire : ' +
                strg_tokenExpire +
                '\n' +
                'เวลาในระบบปัจจุบัน :' +
                formattedDate),
          ],
        ),
      ),

      title: Text(' ตรวจสอบสถานะของ Token '),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}

class _HomeState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    return Container();
    return MaterialApp(
      title: 'หน้าหลักของระบบ',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Home(),
    );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'หน้าหลักของระบบ',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Atoffice(),
    );
  }
}

class RouteAtoffice2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'หน้าหลักของระบบ',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Atoffice2(),
    );
  }
}

class MapRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: Text('Hello ,world'),
      ),
    );
    */

    return MaterialApp(
      title: 'หน้าหลักของระบบ',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Map(),
    );
  }
}

class LogoutRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
