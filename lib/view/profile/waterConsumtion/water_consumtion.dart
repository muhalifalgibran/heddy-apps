import 'package:fit_app/core/res/app_color.dart';
import 'package:fit_app/models/user_activity.dart';
import 'package:fit_app/view/profile/blocProfile.dart';
import 'package:flat_icons_flutter/flat_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:native_color/native_color.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class WaterConsumtion extends StatefulWidget {
  @override
  _WaterConsumtionState createState() => _WaterConsumtionState();
}

class _WaterConsumtionState extends State<WaterConsumtion> {
  @override
  void initState() {
    bloc.fetchUserActivity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColor.appBackground,
          child: Stack(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 2.0),
              child: ClipPath(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  decoration: BoxDecoration(gradient: AppColor.blueGradient),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12.0, right: 12.0),
              child: ListView(padding: EdgeInsets.all(0), children: <Widget>[
                SizedBox(height: 80.0),
                cardPedometer(context),
                SizedBox(height: 10.0),
                // //  dailyMissionDone(context)
              ]),
            ),
            Positioned(
              child: AppBar(
                title: Text("Air Mineral"),
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: <Widget>[],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget cardPedometer(BuildContext context) {
    return Stack(alignment: Alignment.center, children: <Widget>[
      Container(
        alignment: Alignment.topCenter,
        height: 300.0,
        width: MediaQuery.of(context).size.width,
        child: SizedBox(
          width: double.infinity,
          height: 220.0,
          child: Card(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            color: AppColor.blueSoft,
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            padding: EdgeInsets.all(4.0),
                            color: AppColor.blueHard,
                            child: Icon(
                              FlatIcons.reading,
                              color: Colors.white,
                              size: 10.0,
                            ),
                          ),
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          "Air Mineral",
                          style: TextStyle(
                              fontSize: 10.0, color: AppColor.blueHard),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "Hari ini kamu butuh konsumsi \n",
                        style: TextStyle(
                          color: AppColor.primaryColorFont,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: '250 ml',
                              style: TextStyle(
                                  color: AppColor.blueHard,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24.0)),
                          TextSpan(text: ' air mineral'),
                        ],
                      ),
                    ),
                    Text("hampir sampai! tetap jaga tubuh kamu terhidrasi",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColor.primaryColorFont,
                            fontSize: 10.0)),
                    SizedBox(height: 15.0),
                    Text('PERFECT',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColor.colorParagraphGrey,
                            fontSize: 10.0))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 0.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(130.0),
          child: Container(
            padding: EdgeInsets.all(4.0),
            color: Colors.white,
            child: CircularPercentIndicator(
              radius: 130.0,
              footer: Text('GOOD',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColor.colorParagraphGrey,
                      fontSize: 10.0)),
              animation: true,
              animationDuration: 1200,
              lineWidth: 20.0,
              percent: 0.87,
              center: Text(
                "87%",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 36.0,
                    color: AppColor.primaryColor),
              ),
              circularStrokeCap: CircularStrokeCap.butt,
              backgroundColor: AppColor.blueSoft,
              progressColor: AppColor.primaryColor,
            ),
          ),
        ),
      ),
    ]);
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
