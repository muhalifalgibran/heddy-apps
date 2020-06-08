import 'package:fit_app/core/res/app_color.dart';
import 'package:fit_app/view/profile/sleepTime/sleepBloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SleepScreen extends StatefulWidget {
  @override
  _SleepScreenState createState() => _SleepScreenState();
}

class _SleepScreenState extends State<SleepScreen> {
  bool _isSleep = true;
  final _bloc = SleepBloc();

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id', null);
    Intl.defaultLocale = 'id';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<bool>(
          initialData: true,
          stream: _bloc.sleepStateStream,
          builder: (context, snapshot) {
            return SafeArea(
              child: Stack(
                children: <Widget>[background(snapshot), content(snapshot)],
              ),
            );
          }),
    );
  }

  Widget content(AsyncSnapshot<bool> snapshot) {
    var now = new DateTime.now();
    String formattedDate = DateFormat('kk:mm').format(now);
    String tanggal = DateFormat.yMMMMEEEEd().format(now);
    return Center(
      child: Container(
        padding:
            EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0, top: 80.0),
        child: Column(
          children: <Widget>[
            Text(
              "$tanggal",
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color:
                      snapshot.data ? Colors.white : AppColor.primaryColorFont),
            ),
            SizedBox(
              height: 30.0,
            ),
            CircularPercentIndicator(
              radius: 250.0,
              lineWidth: 10.0,
              backgroundColor:
                  snapshot.data ? AppColor.blueSoft : AppColor.yellowSoft,
              center: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                  ),
                  Text(
                    "$formattedDate",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 36.0,
                        color: snapshot.data
                            ? Colors.white
                            : AppColor.primaryColor),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Image.asset(snapshot.data
                      ? "assets/images/midNight.png"
                      : "assets/images/midDay.png")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget background(AsyncSnapshot<bool> snapshot) {
    return Stack(children: <Widget>[
      Container(color: snapshot.data ? AppColor.bgSleep : AppColor.bgWakeUp),
      Positioned(
        top: 20.0,
        child: Image.asset(
          snapshot.data
              ? "assets/images/sleepTopLeft.png"
              : "assets/images/wakeUpTopLeft.png",
        ),
      ),
      Positioned(
        bottom: 1,
        right: 1,
        child: Image.asset(
          snapshot.data
              ? "assets/images/sleepBottomRight.png"
              : "assets/images/wakeUpBottomRight.png",
        ),
      ),
      Positioned(
        child: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color:
                    snapshot.data ? Colors.white : AppColor.primaryColorFont),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text("Waktu Tidur",
              style: TextStyle(
                  color: snapshot.data
                      ? Colors.white
                      : AppColor.primaryColorFont)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: <Widget>[],
        ),
      ),
      Positioned(
        left: 100,
        bottom: 100.0,
        child: FlatButton(
            color: Colors.amber,
            onPressed: () {
              setState(() {
                _isSleep = !_isSleep;
                if (_isSleep) {
                  _bloc.sleepEventSink.add(IsSleep());
                } else {
                  _bloc.sleepEventSink.add(IsWake());
                }
              });
            },
            child: null),
      )
    ]);
  }
}
