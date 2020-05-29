import 'package:fit_app/core/res/app_color.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:native_color/native_color.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     'Masuk Akun',
      //     style: TextStyle(
      //         color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
      //   ),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0,
      // ),
      backgroundColor: HexColor("2E3D68"),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(gradient: AppColor.blueGradient),
          child: Stack(
            children: <Widget>[
              Positioned(
                child: AppBar(
                  title: Text("Masuk Akun"),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: <Widget>[],
                ),
              ),
              background(context),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: fixBottomSheet(context)),
              Center(child: info()),
            ],
          ),
        ),
      ),
    );
  }

  Widget background(context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: ClippingClass(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          Align(
              alignment: Alignment.topRight,
              child: Image.asset('assets/images/ornamen-kanan.png'))
        ],
      ),
    );
  }

  Widget info() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 70.0,
        ),
        Image.asset('assets/images/pesawat.png'),
      ],
    );
  }

  Widget fixBottomSheet(context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 520.0,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(50.0),
                topRight: const Radius.circular(50.0))),
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    FlatButton(
                      color: HexColor('4267B2'),
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
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Masuk dengan Facebook",
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
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
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Masuk dengan Google",
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Container(
                                height: 1.0,
                                width: 80.0,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              "atau masuk dengan email",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12.0),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Container(
                                height: 1.0,
                                width: 80.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        )),
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
