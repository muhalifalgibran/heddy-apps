import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:fit_app/core/firebase/firebase_auth.dart';
import 'package:fit_app/core/res/app_color.dart';
import 'package:fit_app/core/tools/constants.dart';
import 'package:fit_app/view/auth/signIn.dart';
import 'package:fit_app/view/home/bloc.dart';
import 'package:fit_app/view/home/fragment.dart';
import 'package:fit_app/view/profile/foodComsumtion/food_consumtion.dart';
import 'package:fit_app/view/profile/sleepTime/sleepScreen.dart';
import 'package:fit_app/view/profile/waterConsumtion/water_consumtion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:table_calendar/table_calendar.dart';

class NewHomeScreenFragment implements BaseHomeFragment {
  NewHomeScreenFragment(this.position);
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
  Widget view = NewHomeScreen();

  @override
  void onTabSelected(BuildContext mContext) {
    BlocProvider.of<HomeScreenBloc>(mContext).add(this);
  }
}

class NewHomeScreen extends StatefulWidget {
  @override
  _NewHomeScreenState createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
  var _calendarController;
  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    initializeDateFormatting('id', null);
    Intl.defaultLocale = 'id';
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void choiceAction(String items) {
    if (items == MenuLogout.logout) {
      signOutGoogle().then((value) {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
          builder: (context) {
            return SignIn();
          },
        ), ModalRoute.withName('/login'));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: <Widget>[
          background(),
          Positioned(
            child: AppBar(
              leading: null,
              title: Text("HEDDY.ID"),
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: <Widget>[
                PopupMenuButton<String>(
                  onSelected: choiceAction,
                  itemBuilder: (BuildContext context) {
                    return MenuLogout.pilihan.map((String e) {
                      return PopupMenuItem<String>(
                        value: e,
                        child: Text(e),
                      );
                    }).toList();
                  },
                )
              ],
            ),
          ),
          content()
        ],
      )),
    );
  }

  Widget content() {
    return Container(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 60.0),
      child: ListView(
        children: <Widget>[
          nameCard(),
          TableCalendar(
            locale: Intl.defaultLocale,
            initialCalendarFormat: CalendarFormat.week,
            calendarController: _calendarController,
            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
              selectedColor: AppColor.primaryColor,
              weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
              holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
            ),
            onDaySelected: (date, events) {
              // _onDaySelected(date, events);
              print(date.toString());
            },
          ),
          SizedBox(
            height: 10.0,
          ),
          healthCondition()
        ],
      ),
    );
  }

  Widget healthCondition() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Pantau kondisi kesehatanmu",
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: AppColor.primaryColorFont)),
        SizedBox(
          height: 5.0,
        ),
        Text("Informasi rekapan harian kesehatanmu. Yuk capai tergetmu!",
            style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.normal,
                color: AppColor.colorParagraphGrey)),
        SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            //air mineral
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WaterConsumtion()));
              },
              child: Container(
                padding: EdgeInsets.all(8.0),
                height: 210.0,
                width: 190.0,
                child: Card(
                  color: AppColor.blueHard,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                padding: EdgeInsets.all(4.0),
                                color: Colors.white,
                                child: Icon(
                                  Entypo.water,
                                  color: AppColor.primaryColor,
                                  size: 10.0,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              "Air Mineral",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.0),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Center(
                          child: CircularPercentIndicator(
                            radius: 80.0,
                            percent: 0.87,
                            progressColor: AppColor.blueHard2,
                            animationDuration: 1000,
                            lineWidth: 10.0,
                            center: Text(
                              "87%",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        RichText(
                          text: TextSpan(
                            text: '750 ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'ml', style: TextStyle(fontSize: 12.0)),
                            ],
                          ),
                        ),
                        Text(
                          "Target 800ml",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // waktu tidur
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return SleepScreen();
                    },
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(8.0),
                height: 210.0,
                width: 190.0,
                child: Card(
                  color: AppColor.blueCyan,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                padding: EdgeInsets.all(4.0),
                                color: Colors.white,
                                child: Icon(
                                  FontAwesome.bed,
                                  color: AppColor.blueCyan,
                                  size: 10.0,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              "Waktu Tidur",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.0),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Center(child: Image.asset("assets/images/heart-1.png")),
                        Spacer(),
                        RichText(
                          text: TextSpan(
                            text: '6 ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                  text: ' h ',
                                  style: TextStyle(fontSize: 12.0)),
                              TextSpan(
                                text: '43 ',
                              ),
                              TextSpan(
                                  text: 'min',
                                  style: TextStyle(fontSize: 12.0)),
                            ],
                          ),
                        ),
                        Text(
                          "Target 8 Jam",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            //konsumsi makan
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FoodConsumtion()));
              },
              child: Container(
                padding: EdgeInsets.all(8.0),
                height: 210.0,
                width: 190.0,
                child: Card(
                  color: AppColor.pinkHard,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                padding: EdgeInsets.all(4.0),
                                color: Colors.white,
                                child: Icon(
                                  FontAwesome.food,
                                  color: AppColor.pinkHard,
                                  size: 10.0,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              "Konsumsi Makan",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.0),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          height: 30.0,
                          child: Row(
                            children: <Widget>[
                              Checkbox(value: true, onChanged: null),
                              Text(
                                "Makan Pagi",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                          child: Row(
                            children: <Widget>[
                              Checkbox(value: false, onChanged: null),
                              Text(
                                "Makan Siang",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                          child: Row(
                            children: <Widget>[
                              Checkbox(value: true, onChanged: null),
                              Text(
                                "Makan Malam",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0),
                              )
                            ],
                          ),
                        ),
                        Spacer(),
                        Text('Makan Pagi ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold)),
                        Text(
                          "06:00 - 06:30",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            //olahraga
            Container(
              padding: EdgeInsets.all(8.0),
              height: 210.0,
              width: 190.0,
              child: Card(
                color: AppColor.yellowHard,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              padding: EdgeInsets.all(4.0),
                              color: Colors.white,
                              child: Icon(
                                FontAwesome.fire,
                                color: AppColor.yellowHard,
                                size: 10.0,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "Olahraga",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10.0),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Center(child: Image.asset("assets/images/step-1.png")),
                      Spacer(),
                      Text('Jalan Santai ',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold)),
                      Text(
                        "06:00 - 06:30",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget nameCard() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 30.0,
            ),
            SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Halo Lorem,",
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  "Apa yang sedang kamu kerjakan hari ini?",
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                ),
              ],
            ),
            Spacer(),
            Icon(
              Typicons.pencil,
              size: 16.0,
              color: Colors.white,
            )
          ],
        ),
        SizedBox(
          height: 20.0,
        ),
        Container(
          height: 190.0,
          child: Card(
            elevation: 1.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            color: AppColor.blueGrey,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      score(),
                      SizedBox(
                        width: 24.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Health Score",
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            width: 230.0,
                            child: Text(
                              "Berdasarkan hasil tes kesehatan keseluruhan kamu, nilai yang didapatkan termasuk kategori Baik. ",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                              style: TextStyle(
                                  color: AppColor.colorParagraphGrey,
                                  fontSize: 12.0),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            "Sampai ketemu besok, Lorem!",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                            style: TextStyle(
                                color: AppColor.colorParagraphGrey,
                                fontSize: 12.0),
                          ),
                        ],
                      )
                    ],
                  ),
                  Spacer(),
                  Icon(Typicons.down_outline, color: AppColor.primaryColor)
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget score() {
    return Card(
      color: AppColor.primaryColor,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Card(
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: AppColor.blueGrey,
        child: Card(
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          color: AppColor.primaryColor,
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              "87",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Widget background() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: ClipPath(
        clipper: ClippingClass(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 200.0,
          decoration: BoxDecoration(gradient: AppColor.blueGradient),
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
