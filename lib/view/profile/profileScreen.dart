import 'dart:ui';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:fit_app/core/firebase/firebase_auth.dart';
import 'package:fit_app/core/res/app_color.dart';
import 'package:fit_app/core/tools/injector.dart';
import 'package:fit_app/models/user_activity.dart';
import 'package:fit_app/network/Response.dart';
import 'package:fit_app/view/auth/signIn.dart';
import 'package:fit_app/view/home/bloc.dart';
import 'package:fit_app/view/home/fragment.dart';
import 'package:fit_app/view/profile/blocProfile.dart';
import 'package:fit_app/view/profile/foodComsumtion/food_consumtion.dart';
import 'package:fit_app/view/profile/waterConsumtion/water_consumtion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:native_color/native_color.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:fit_app/core/tools/constants.dart' as Constants;

class ProfileFragment implements BaseHomeFragment {
  ProfileFragment(this.position);
  @override
  BottomNavyBarItem bottomNavyBarItem = BottomNavyBarItem(
    icon: Icon(LineIcons.home),
    title: Text('Beranda'),
    activeColor: Colors.blue,
    inactiveColor: Colors.white,
  );

  @override
  int position;

  @override
  Widget view = ProfileScreen();

  @override
  void onTabSelected(BuildContext mContext) {
    BlocProvider.of<HomeScreenBloc>(mContext).add(this);
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static GetPreferences userRef = locator<GetPreferences>();
  String photoUrl = userRef.photoUrl;
  String name = userRef.name;
  ProfileBloc _bloc;
  // static GetToken userRef1 = locator<GetToken>();
  @override
  void initState() {
    // getStringValuesSF();
    // bloc.fetchUserActivity();

    super.initState();
    // print("token :  1:" + userRef1.token);
    print(Constants.token);
    _bloc = ProfileBloc();
  }

  @override
  void dispose() {
    // bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchUserPr(),
        child: StreamBuilder<Response<UserActivity>>(
          stream: _bloc.profileDataStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 5,
                        sigmaY: 5,
                      ),
                      child: Stack(children: <Widget>[
                        CircularProgressIndicator(),
                        background(context)
                      ]));
                  break;
                case Status.SUCCESS:
                  return stack(snapshot.data.data);
                  break;
                case Status.ERROR:
                  print(snapshot.data.message);
                  // return Center(child: Text("Periksa kembali jaringan anda"));
                  return Error(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () => _bloc.fetchUserPr(),
                  );
                  break;
              }
            }
            return Container();
          },
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
          height: 320.0,
          decoration: BoxDecoration(gradient: AppColor.blueGradient),
        ),
      ),
    );
  }

  Widget stack(UserActivity user) {
    return Stack(children: <Widget>[
      background(context),
      Padding(
        padding: EdgeInsets.only(left: 12.0, right: 12.0),
        child: ListView(padding: EdgeInsets.all(0), children: <Widget>[
          SizedBox(height: 50),
          cardProfile(context),
          SizedBox(height: 10.0),
          cardPedometer(context, user),
          SizedBox(height: 10.0),
          fitCards(context),
          // profile(context),
          // SizedBox(
          //   height: 20,
          // ),
          // dailyMission(context),
          // //  dailyMissionDone(context)
        ]),
      ),
    ]);
  }

  Widget cardProfile(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 80.0,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Colors.transparent,
          child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage("$photoUrl"),
                    backgroundColor: Colors.grey,
                    radius: 24.0,
                  ),
                  SizedBox(width: 12),
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "$name",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 2.0,
                      ),
                      Text(
                        "Laki-laki, 17thn",
                        style: TextStyle(
                            fontWeight: FontWeight.w100, fontSize: 12.0),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 180.0,
                    height: 10,
                  ),
                  GestureDetector(
                      onTap: () {
                        _showDialog();
                      },
                      child: Icon(Entypo.logout))
                ],
              )),
        ));
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Logout"),
          content: new Text("Ingin keluar dari aplikasi?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Oke"),
              onPressed: () {
                signOutGoogle();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return SignIn();
                    },
                  ),
                );
              },
            ),

            new FlatButton(
              child: new Text("Batal"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Widget cardPedometer(BuildContext context, UserActivity user) {
    return SizedBox(
      width: double.infinity,
      height: 270.0,
      child: Card(
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                child: Text(
                  "Hari ke 1/30",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                width: double.infinity,
                height: 20.0,
              ),
              CircularPercentIndicator(
                radius: 130.0,
                animation: true,
                animationDuration: 1200,
                lineWidth: 5.0,
                percent: 0.4,
                center: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      "13 Mei 2020",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10.0,
                          color: AppColor.primaryColor),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "1600",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          color: AppColor.primaryColor),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "/8000 langkah harian",
                      style: TextStyle(
                          fontWeight: FontWeight.w100, fontSize: 10.0),
                    ),
                  ],
                ),
                circularStrokeCap: CircularStrokeCap.butt,
                backgroundColor: AppColor.primaryColor,
                progressColor: Colors.red,
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  fitSetWater(user.data.mineralWaterConsumption),
                  iconSeparator(),
                  fitSetCal(user.data.calorieFoods),
                  iconSeparator(),
                  fitSetSleep(user.data.sleepDuration),
                  iconSeparator(),
                  fitSetFood(user.data.calorieFoods)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget iconSeparator() {
    return Icon(Icons.more_vert);
  }

  Widget fitSetWater(int mineralWaterConsumption) {
    return Column(
      children: <Widget>[
        Card(
            color: HexColor('ffccdd'),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(
                Icons.local_drink,
                size: 16.0,
                color: HexColor('EB5757'),
              ),
            )),
        SizedBox(
          height: 5.0,
        ),
        Text("$mineralWaterConsumption L",
            style: TextStyle(fontWeight: FontWeight.bold)),
        Text("Air Mineral",
            style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w300)),
      ],
    );
  }

  Widget fitSetCal(int calorieFoods) {
    return Column(
      children: <Widget>[
        Card(
            color: HexColor('add0ff'),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(
                LineIcons.fire,
                size: 16.0,
                color: HexColor('2F80ED'),
              ),
            )),
        SizedBox(
          height: 5.0,
        ),
        Text("$calorieFoods kkal",
            style: TextStyle(fontWeight: FontWeight.bold)),
        Text("Kalori Terbakar",
            style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w300)),
      ],
    );
  }

  Widget fitSetSleep(int sleepDuration) {
    return Column(
      children: <Widget>[
        Card(
            color: HexColor('d5a8ff'),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(
                LineIcons.bed,
                size: 16.0,
                color: HexColor('8448bd'),
              ),
            )),
        SizedBox(
          height: 5.0,
        ),
        Text("$sleepDuration H", style: TextStyle(fontWeight: FontWeight.bold)),
        Text("Waktu Tidur",
            style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w300)),
      ],
    );
  }

  Widget fitSetFood(int calorieFoods) {
    return Column(
      children: <Widget>[
        Card(
            color: HexColor('a3ffca'),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(
                Icons.fastfood,
                size: 16.0,
                color: HexColor('27AE60'),
              ),
            )),
        SizedBox(
          height: 5.0,
        ),
        Text("$calorieFoods kkal",
            style: TextStyle(fontWeight: FontWeight.bold)),
        Text("Kalori Makanan",
            style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w300)),
      ],
    );
  }

  Widget fitCards(context) {
    return Column(
      children: <Widget>[
        waterCard(context),
        SizedBox(
          height: 8.0,
        ),
        caloryCard(),
        SizedBox(
          height: 8.0,
        ),
        sleepCard(),
        SizedBox(
          height: 8.0,
        ),
        foodCard(),
        SizedBox(
          height: 8.0,
        ),
      ],
    );
  }

  Widget waterCard(context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => WaterConsumtion()));
      },
      child: SizedBox(
        height: 90.0,
        width: double.infinity,
        child: Card(
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Card(
                      color: HexColor('ffccdd'),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(
                          Icons.local_drink,
                          size: 16.0,
                          color: HexColor('EB5757'),
                        ),
                      )),
                ),
                SizedBox(width: 5.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  children: <Widget>[
                    Text(
                      "Konsumsi Air Mineral",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "Segelas air akan Anda konsentrasi \ndan tetap segar.",
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 12.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget caloryCard() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FoodConsumtion()));
      },
      child: SizedBox(
        height: 90.0,
        width: double.infinity,
        child: Card(
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Card(
                      color: HexColor('add0ff'),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(
                          LineIcons.fire,
                          size: 16.0,
                          color: HexColor('2F80ED'),
                        ),
                      )),
                ),
                SizedBox(width: 5.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  children: <Widget>[
                    Text(
                      "Konsumsi Makan",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "Segelas air akan Anda konsentrasi \ndan tetap segar.",
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 12.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget sleepCard() {
    return SizedBox(
      height: 90.0,
      width: double.infinity,
      child: Card(
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Card(
                    color: HexColor('d5a8ff'),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(
                        LineIcons.bed,
                        size: 16.0,
                        color: HexColor('8448bd'),
                      ),
                    )),
              ),
              SizedBox(width: 5.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection: VerticalDirection.down,
                children: <Widget>[
                  Text(
                    "Total waktu tidur",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Segelas air akan Anda konsentrasi \ndan tetap segar.",
                    style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 12.0),
                  ),
                ],
              ),
              SizedBox(
                width: 80.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget foodCard() {
    return SizedBox(
      height: 90.0,
      width: double.infinity,
      child: Card(
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Card(
                    color: HexColor('a3ffca'),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.fastfood,
                        size: 16.0,
                        color: HexColor('27AE60'),
                      ),
                    )),
              ),
              SizedBox(width: 5.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection: VerticalDirection.down,
                children: <Widget>[
                  Text(
                    "Keseimbangan Gizi",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Segelas air akan Anda konsentrasi \ndan tetap segar.",
                    style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 12.0),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Error extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  const Error({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Pastikan kamu terhubung dengan internet",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          RaisedButton(
            color: Colors.white,
            child: Text('Retry', style: TextStyle(color: Colors.black)),
            onPressed: onRetryPressed,
          )
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
  final String loadingMessage;

  const Loading({Key key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 24),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ],
      ),
    );
  }
}

class ClippingClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 10);
    var secondControlPoint =
        Offset(size.width - (size.width / 2.0), size.height - 80);
    var secondEndPoint = Offset(size.width, size.height - 10);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
