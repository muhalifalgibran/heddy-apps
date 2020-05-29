import 'package:fit_app/core/res/app_color.dart';
import 'package:fit_app/view/auth/signIn.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FlashScreen extends StatefulWidget {
  @override
  _FlashScreenState createState() => _FlashScreenState();
}

class _FlashScreenState extends State<FlashScreen> {
  PageController _controller;
  String _txtBtn = 'Lanjut';

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 1.0, initialPage: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height - 60,
            child: PageView(
              controller: _controller,
              children: [
                flashScreen1(context),
                flashScreen2(context),
                flashScreen3(context),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 24.0,
                ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: WormEffect(),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 250.0,
                ),
                RaisedButton(
                  color: AppColor.primaryColor,
                  onPressed: () {
                    if (_controller.hasClients) {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                      if (_controller.page == 1) {
                        setState(() {
                          _txtBtn = "Mulai";
                        });
                      } else {
                        setState(() {
                          if (_controller.page < 1) {
                            _txtBtn = "Lanjut";
                          }
                        });
                      }
                      if (_controller.page == 2) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignIn()));
                      }
                    }
                  },
                  child: Text(
                    _txtBtn,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget textButton() {
    return _controller.page != 1.0
        ? Text(
            "Next",
            style: TextStyle(fontSize: 14.0),
          )
        : Text(
            "Start",
            style: TextStyle(fontSize: 14.0),
          );
  }

  Widget flashScreen1(context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 400.0,
            decoration: BoxDecoration(gradient: AppColor.blueGradient),
          ),
          clipper: BottomWaveClipper(),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 90.0,
              ),
              Image.asset('assets/images/lingakaran-kiri1.png'),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Image.asset('assets/images/lingkarkanan1.png'),
        ),
        Column(
          children: <Widget>[
            SizedBox(
              height: 90.0,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset('assets/images/frame-ilustrasi1.png'),
            ),
            SizedBox(
              height: 20.0,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Makan Teratur",
                      style: TextStyle(
                          color: AppColor.primaryColor,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Pola makan seimbang akan lebih mudah menjaga \nkesehatan dan berat badan Anda.",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w300),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 56.0,
            child: Row(
              children: <Widget>[],
            ),
          ),
        )
      ],
    );
  }

  Widget flashScreen2(context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 400.0,
            decoration: BoxDecoration(gradient: AppColor.blueGradient),
          ),
          clipper: BottomWaveClipper2(),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Image.asset('assets/images/lingk-kiri2.png'),
        ),
        Column(
          children: <Widget>[
            SizedBox(
              height: 90.0,
            ),
            Align(
              alignment: Alignment.topRight,
              child: Image.asset('assets/images/lingk.kanan2.png'),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            SizedBox(
              height: 90.0,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset('assets/images/frame-ilustrasi2.png'),
            ),
            SizedBox(
              height: 20.0,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Bangun dengan Segar",
                      style: TextStyle(
                          color: AppColor.primaryColor,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Kualitas tidur malam yang baik akan membuat \nAnda merasa segar keesokan harinya..",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w300),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 56.0,
            child: Row(
              children: <Widget>[],
            ),
          ),
        )
      ],
    );
  }

  Widget flashScreen3(context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 400.0,
            decoration: BoxDecoration(gradient: AppColor.blueGradient),
          ),
          clipper: BottomWaveClipper3(),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Image.asset('assets/images/lingk-kiri3.png'),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 90.0,
              ),
              Image.asset('assets/images/lingk-kanan3.png'),
            ],
          ),
        ),
        Column(
          children: <Widget>[
            SizedBox(
              height: 90.0,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset('assets/images/frame-ilustrasi3.png'),
            ),
            SizedBox(
              height: 20.0,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Tubuh lebih Terhidrasi",
                      style: TextStyle(
                          color: AppColor.primaryColor,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Feel better, sleep better. We’re a guided \njournal made with therapists..",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w300),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 56.0,
            child: Row(
              children: <Widget>[],
            ),
          ),
        )
      ],
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height);

    var firstControlPoint = Offset(size.width / 3.1, size.height);
    var firstEndPoint = Offset(size.width / 3.0, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 6.25), size.height - 400.0);
    var secondEndPoint = Offset(size.width, size.height - 270.0);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    // path.lineTo(size.width, size.height - 60);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class BottomWaveClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height - 270);

    var firstControlPoint = Offset(size.width / 7.0, size.height - 40.0);
    var firstEndPoint = Offset(size.width / 1.8, size.height - 128.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 2.5), size.height - 155.0);
    var secondEndPoint = Offset(size.width, size.height);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    //  path.lineTo(size.width, size.height - 60);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class BottomWaveClipper3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height);

    var firstControlPoint = Offset(size.width / 3.1, size.height - 300);
    var firstEndPoint = Offset(size.width / 2.0, size.height - 100.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 2.25), size.height - 20.0);
    var secondEndPoint = Offset(size.width, size.height - 270.0);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    // path.lineTo(size.width, size.height - 60);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
