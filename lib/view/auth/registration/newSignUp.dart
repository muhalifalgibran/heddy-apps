import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_app/core/res/app_color.dart';
import 'package:fit_app/models/general_post.dart';
import 'package:fit_app/network/Response.dart';
import 'package:fit_app/view/auth/newSignUpBloc.dart';
import 'package:fit_app/view/auth/signIn.dart';
import 'package:fit_app/view/home/homeScreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:native_color/native_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewSignUp extends StatefulWidget {
  @override
  _NewSignUpState createState() => _NewSignUpState();
}

class _NewSignUpState extends State<NewSignUp> {
  NewSignUpBloc _bloc;
  bool _isVisible = false;
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final repeatPassword = TextEditingController();

  void loginState(bool loggedIn) {
    if (loggedIn) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
        ModalRoute.withName('/homeScreen'),
      );
    } else {}
  }

  @override
  void dispose() {
    _bloc.dispose();
    name.dispose();
    email.dispose();
    password.dispose();
    repeatPassword.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _bloc = NewSignUpBloc();
  }

  void saveData(FirebaseUser user) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString('email', user.email);
    _prefs.setString('name', user.displayName);
    _prefs.setString('uid', user.uid);
    _prefs.setString('photoUrl', user.photoUrl);
    _prefs.setBool('isLoggedIn', true);
  }

  void saveToken(String token) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString('token', token);
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
              Center(child: info()),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: fixBottomSheet(context)),
              Positioned(
                left: 0,
                bottom: 1,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignIn()));
                  },
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width,
                          color: AppColor.colorParagraphGrey,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Sudah punya akun? ',
                            style: TextStyle(color: AppColor.primaryColorFont),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'log in',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.primaryColor)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
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
        padding: EdgeInsets.only(bottom: 12.0),
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
                    "Masukan Data Valid",
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
                    "Kamu juga bisa mengubahnya nanti",
                    style: TextStyle(color: Colors.black, fontSize: 14.0),
                  ),
                ),
                StreamBuilder<Response<GeneralResponse>>(
                    stream: _bloc.signUpDataStream,
                    builder: (context,
                        AsyncSnapshot<Response<GeneralResponse>> snapshot) {
                      if (snapshot.hasData) {
                        switch (snapshot.data.status) {
                          case Status.LOADING:
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                            break;
                          case Status.SUCCESS:
                            if (!snapshot.data.data.success) {
                              return Center(
                                  child: Text(
                                snapshot.data.data.message,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ));
                            } else {
                              name.text = null;
                              email.text = null;
                              password.text = null;
                              return Center(
                                  child: Text(
                                "Sukses daftar, silahkan kembali ke Login",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColor.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ));
                            }
                            break;
                          case Status.ERROR:
                            return Center(
                                child: Text(
                              "Periksa kembali masukan anda",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ));
                            break;
                        }
                      }
                      return Container();
                    }),
                SizedBox(
                  height: 12.0,
                ),
                form()
              ],
            ),
          ),
        ));
  }

  void dialogSuccess(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Center(child: Text("Registrasi")),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(message),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("Kembali ke login?"),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Oke'),
                onPressed: () {
                  // Navigator.of(context).pop();
                  // Navigator.of(context).pushReplacementNamed('/login');
                },
              ),
            ],
          );
        });
  }

  Future navigateToPage(BuildContext context, int code) async {
    Navigator.pushReplacementNamed(context, '/signIn');
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
          controller: name,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              labelText: 'Nama Pengguna', hintText: "Heddy Cantika"),
        ),
        TextFormField(
          controller: email,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              labelText: 'Email', hintText: "asdfghjk@aaaa.com"),
        ),
        TextFormField(
          controller: password,
          obscureText: _obscureText,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            labelText: 'Kata sandi',
            hintText: 'Password',
          ),
        ),
        TextFormField(
          controller: repeatPassword,
          obscureText: _obscureText,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            labelText: 'Ulangi kata sandi',
            hintText: 'Password',
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Visibility(
          visible: _isVisible,
          child: Center(
            child: Text(
              "Pastikan password yang kamu masukan sama",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
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
            if (password.text != repeatPassword.text) {
              setState(() {
                _isVisible = true;
              });
            } else {
              _bloc.createUserManual(name.text, email.text, password.text);
            }

            /*...*/
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => HomeScreen()));
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
