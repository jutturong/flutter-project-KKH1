import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextEditingController txt_username = new TextEditingController(); //username
TextEditingController txt_password = new TextEditingController(); //password

class FormCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      height: ScreenUtil.getInstance().setHeight(500),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 15.0),
                blurRadius: 15.0),
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, -10.0),
                blurRadius: 10.0),
          ]),
      child: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
//            Icon(
//              Icons.four_k,
//              size: 30,
//              color: Colors.green,
//            ),

            /*
            Text("",
                style: TextStyle(
//                    fontSize: ScreenUtil.getInstance().setSp(45),
                    fontSize: ScreenUtil.getInstance().setSp(35),
                    fontFamily: "Poppins-Bold",
//                    fontFamily: "THSarabun",
                    letterSpacing: .6)),
            */
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            Icon(
              Icons.person_pin_circle,
              size: 30,
              color: Colors.green,
            ),
            Text("Username",
                style: TextStyle(
                    fontFamily: "Poppins-Medium",
                    fontSize: ScreenUtil.getInstance().setSp(30))),
            TextField(
              controller: txt_username,
              obscureText: true,
//              autofocus: true, //show *
              cursorWidth: 4.0,
              cursorRadius: Radius.circular(8.0),
              cursorColor: Colors.green,
              maxLength: 10,
              keyboardType: TextInputType.multiline,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                  hintText: "ระบุ Username",
//                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
            ),

//            SizedBox(
//              height: ScreenUtil.getInstance().setHeight(35),
//            ),

            Icon(
              Icons.https,
              size: 20,
              color: Colors.green,
            ),
            Text("PassWord",
                style: TextStyle(
                    fontFamily: "Poppins-Medium",
                    fontSize: ScreenUtil.getInstance().setSp(30))),
            TextField(
              controller: txt_password,
              obscureText: true, //password

              cursorWidth: 4.0,
              cursorRadius: Radius.circular(8.0),
              cursorColor: Colors.green,

              decoration: InputDecoration(
                  hintText: "ระบุ Password",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(35),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
//                Text(
//                  "iHospital @KKH โรงพยาบาลขอนแก่น",
//                  style: TextStyle(
//                      color: Colors.blue,
//                      fontFamily: "Poppins-Medium",
//                      fontSize: ScreenUtil.getInstance().setSp(28)),
//                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
