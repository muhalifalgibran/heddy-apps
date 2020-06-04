import 'package:fit_app/core/firebase/firebase_auth.dart';
import 'package:fit_app/core/res/app_color.dart';
import 'package:fit_app/core/tools/injector.dart';
import 'package:fit_app/models/first_auth.dart';
import 'package:fit_app/network/Response.dart';
import 'package:fit_app/view/auth/auth_bloc.dart';
import 'package:fit_app/view/home/homeScreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:line_icons/line_icons.dart';
import 'package:native_color/native_color.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var _bloc = AuthBloc();

  void loginState(bool loggedIn) {
    if (loggedIn) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
        ModalRoute.withName('/homeScreen'),
      );
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: StreamBuilder<Response<FirstAuth>>(
                      stream: _bloc.authDataStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          print("snapshot:" + snapshot.data.data.toString());
                          switch (snapshot.data.status) {
                            case Status.LOADING:
                              print("l");
                              return CircularProgressIndicator();
                              break;
                            case Status.SUCCESS:
                              //TODO bikin case kalau profil lengkap dengan belum lengkap
                              print("s");
                              setupLocatorToken(
                                  snapshot.data.data.message.token);
                              _bloc.dispose();
                              break;
                            case Status.ERROR:
                              print("e" + snapshot.data.message);
                              return fixBottomSheet(context);
                              break;
                          }
                        } else {
                          print("2");
                        }
                        return fixBottomSheet(context);
                      })),
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
            child: ListView(
              children: <Widget>[
                Center(
                  child: Text(
                    "Selamat Datang!",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Center(
                  child: Text(
                    "Kamu bisa lanjut pake akun media sosialmu",
                    style: TextStyle(color: Colors.black, fontSize: 14.0),
                  ),
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
                        signInWithGoogle().then((user) => {
                              // setupLocator(user),
                              _bloc.fetchFirstAuth(user.uid, user.displayName,
                                  user.email, user.photoUrl),
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/home', (Route<dynamic> route) => false)
                            });
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
                              child: Dash(
                                length: 80.0,
                                dashColor: Colors.grey,
                              ),
                            ),
                            Text(
                              "atau masuk dengan email",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12.0),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Dash(
                                length: 80.0,
                                dashColor: Colors.grey,
                              ),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 20.0,
                    ),
                    form()
                  ],
                )
              ],
            ),
          ),
        ));
  }

  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Widget form() {
    return Column(
      children: <Widget>[
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              labelText: 'Email', hintText: "asdfghjk@aaaa.com"),
        ),
        TextFormField(
          obscureText: _obscureText,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Password',
              suffixIcon: FlatButton(
                  onPressed: _toggle,
                  child: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: HexColor('2D9CDB'),
                  ))),
        ),
        SizedBox(
          height: 30.0,
        ),
        FlatButton(
          color: HexColor('2D9CDB'),
          textColor: Colors.white,
          disabledColor: Colors.grey,
          disabledTextColor: Colors.black,
          padding: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
          splashColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)),
          onPressed: () {
            /*...*/
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
          child: Row(
            children: <Widget>[
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Masuk",
                    style: TextStyle(fontSize: 14.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5.0),
        RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 10.0, color: Colors.grey),
            children: <TextSpan>[
              TextSpan(
                  text: 'Lupa Kata Sandi ? ',
                  style:
                      TextStyle(fontWeight: FontWeight.normal, fontSize: 12.0)),
              TextSpan(
                  text: 'Dapatkan Bantuan untuk Masuk!',
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () {
                      print('Tap Here onTap');
                    },
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 12.0,
                      color: AppColor.primaryColor)),
            ],
          ),
        )
      ],
    );
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
