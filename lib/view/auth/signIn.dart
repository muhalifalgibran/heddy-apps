import 'package:fit_app/core/res/app_color.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:native_color/native_color.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("2E3D68"),
      body: SafeArea(
        child: Container(
          child: Stack(
            children: <Widget>[
              background(context),
              Center(child: info()),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: fixBottomSheet(context))
            ],
          ),
        ),
      ),
    );
  }

  Widget background(context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: ClipPath(
        clipper: ClippingClass(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: AppColor.primaryColor),
        ),
      ),
    );
  }

  Widget info() {
    return Column(
      children: <Widget>[
        Image.asset('assets/images/img_marketing.png'),
        SizedBox(
          height: 30.0,
        ),
        Text(
          'Say hi to your self-care journal',
          style: TextStyle(
              color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          'Feel better, sleep better. We’re a guided \n journal made with therapists..',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.0,
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Widget fixBottomSheet(context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 150.0,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10.0),
                topRight: const Radius.circular(10.0))),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Selamat Datang!",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  "Kamu bisa lanjut pake akun media sosialmu",
                  style: TextStyle(color: Colors.black, fontSize: 14.0),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    FlatButton(
                      color: AppColor.primaryColor,
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      padding: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
                      splashColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () {
                        /*...*/
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(LineIcons.facebook),
                          Text(
                            "Facebook",
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ],
                      ),
                    ),
                    OutlineButton(
                      color: Colors.white,
                      textColor: Colors.black,
                      disabledTextColor: Colors.black,
                      padding: EdgeInsets.fromLTRB(35.0, 8.0, 35.0, 8.0),
                      splashColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () {
                        /*...*/
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(LineIcons.google),
                          Text(
                            "Google",
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

class ClippingClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, 120.0);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
