import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:fit_app/core/res/app_color.dart';
import 'package:fit_app/models/user_activity.dart';
import 'package:fit_app/view/home/bloc.dart';
import 'package:fit_app/view/home/fragment.dart';
import 'package:fit_app/view/profile/blocProfile.dart';
import 'package:fit_app/view/profile/waterConsumtion/water_consumtion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:native_color/native_color.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

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
  @override
  void initState() {
    bloc.fetchUserActivity();
    super.initState();
  }

  @override
  void dispose() {
    // bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 2.0),
          child: ClipPath(
            clipper: ClippingClass(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 320.0,
              decoration: BoxDecoration(gradient: AppColor.blueGradient),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 12.0, right: 12.0),
          child: ListView(padding: EdgeInsets.all(0), children: <Widget>[
            SizedBox(height: 50),
            cardProfile(context),
            SizedBox(height: 10.0),
            cardPedometer(context),
            SizedBox(height: 10.0),
            fitCards(),
            // profile(context),
            // SizedBox(
            //   height: 20,
            // ),
            // dailyMission(context),
            // //  dailyMissionDone(context)
          ]),
        ),
      ]),
    );
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
                    backgroundImage: NetworkImage(
                        "https://pbs.twimg.com/media/EM5QvUDXkAI6h5N.jpg"),
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
                        "Riski Wahyu",
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
                  Icon(LineIcons.edit)
                ],
              )),
        ));
  }

  Widget cardPedometer(BuildContext context) {
    return StreamBuilder(
        stream: bloc.userAct,
        builder: (context, AsyncSnapshot<UserActivity> snapshot) {
          if (snapshot.hasData) {
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
                          fitSetWater(
                              snapshot.data.data.mineralWaterConsumption),
                          iconSeparator(),
                          fitSetCal(snapshot.data.data.calorieFoods),
                          iconSeparator(),
                          fitSetSleep(snapshot.data.data.sleepDuration),
                          iconSeparator(),
                          fitSetFood(snapshot.data.data.calorieFoods)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          } else if (snapshot.hasData) {
            return Center(child: Text(snapshot.error.toString()));
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
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

  Widget fitCards() {
    return Column(
      children: <Widget>[
        waterCard(),
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

  Widget waterCard() {
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
                    "Kalori yang terbakar",
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
