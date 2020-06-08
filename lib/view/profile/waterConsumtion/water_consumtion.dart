import 'dart:ui';

import 'package:fit_app/core/res/app_color.dart';
import 'package:fit_app/models/today_water_consum.dart';
import 'package:fit_app/network/Response.dart';
import 'package:fit_app/view/profile/waterConsumtion/water_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:native_color/native_color.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:date_format/date_format.dart';

class WaterConsumtion extends StatefulWidget {
  @override
  _WaterConsumtionState createState() => _WaterConsumtionState();
}

class _WaterConsumtionState extends State<WaterConsumtion> {
  int _cup = 1;
  WaterBloc _bloc;
  int _select = 0;
  int _size = 100;

  @override
  void initState() {
    super.initState();
    _bloc = WaterBloc();
    _bloc.fetchWater();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Air Mineral"),
          backgroundColor: AppColor.secondaryColor,
          elevation: 0.0,
          actions: <Widget>[],
        ),
        body: SafeArea(
          child: RefreshIndicator(
              onRefresh: () => _bloc.fetchWater(),
              child: StreamBuilder<Response<WaterConsumeToday>>(
                stream: _bloc.waterDataStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    switch (snapshot.data.status) {
                      case Status.LOADING:
                        return BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 5,
                              sigmaY: 5,
                            ),
                            child: Center(child: CircularProgressIndicator()));

                        break;
                      case Status.SUCCESS:
                        print("success");
                        return body(context, snapshot.data.data);
                        break;
                      case Status.ERROR:
                        print("error");
                        print(snapshot.data.data.toString());
                        return Text(snapshot.data.message);
                        break;
                    }
                  }
                  return Text("Error Load");
                },
              )),
        ));
  }

  Widget body(BuildContext context, WaterConsumeToday data) {
    return Container(
      color: AppColor.appBackground,
      child: Stack(children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 12.0, right: 12.0),
          child: ListView(padding: EdgeInsets.all(0), children: <Widget>[
            SizedBox(height: 8.0),
            cardPedometer(context, data),
            SizedBox(height: 10.0),
            addWater(context),
            SizedBox(
              height: 12.0,
            ),
            dailyNote(context, data)
          ]),
        ),
      ]),
    );
  }

  Widget dailyNote(BuildContext context, WaterConsumeToday data) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Catatan Hari ini",
            style: TextStyle(
                fontSize: 16.0,
                color: AppColor.primaryColorFont,
                fontWeight: FontWeight.bold),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Rekapan harian konsumsi minuman kamu.",
            style: TextStyle(
                fontSize: 12.0,
                color: AppColor.colorParagraphGrey,
                fontWeight: FontWeight.normal),
          ),
        ),
        SizedBox(
          height: 16.0,
        ),
        Container(
            child: Card(
                elevation: 5.0,
                color: AppColor.appBackground,
                child: Column(
                  children: List.generate(data.data.history.length, (index) {
                    return listItem(data.data.history[index]);
                  }),
                )))
      ],
    );
  }

  Widget listItem(History history) {
    // DateTime todayDate = DateTime.parse(history.timestamp);
    var formatted = formatDate(history.timestamp, [
      hh,
      ':',
      nn,
      ':',
      am,
    ]);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                alignment: Alignment.bottomRight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: Container(
                    padding: EdgeInsets.all(4.0),
                    color: AppColor.colorParagraphGrey2,
                    child: Wrap(
                      direction: Axis.vertical,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/cup${history.qty}.png',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Text("$formatted"),
              RichText(
                textAlign: TextAlign.end,
                text: TextSpan(
                  text: '${history.size}x',
                  style: TextStyle(
                      fontSize: 12.0,
                      color: AppColor.primaryColorFont,
                      fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' ${history.qty} ml',
                    ),
                  ],
                ),
              ),
              // Text("${history.qty} ml"),
              IconButton(
                  icon: Icon(Icons.delete, color: AppColor.colorParagraphGrey),
                  onPressed: () {
                    print(history.id);
                    _bloc
                        .deleteWater(history.id)
                        .then((value) => {_bloc.fetchWater()});
                  })
            ],
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            color: AppColor.colorParagraphGrey2,
            width: MediaQuery.of(context).size.width / 1,
            height: 1,
          )
        ],
      ),
    );
  }

  Widget addWater(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 280.0,
      child: Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: AppColor.blueSoft,
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Center(
            child: Wrap(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_cup > 1) {
                            _cup--;
                          }
                        });
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          padding: EdgeInsets.all(4.0),
                          color: AppColor.secondaryColor,
                          child: Icon(
                            Entypo.minus,
                            color: Colors.white,
                            size: 20.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        print("tapped");
                        dialogCup();
                      },
                      child: SizedBox(
                        child: Card(
                          color: Colors.white,
                          elevation: 10.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          child: Padding(
                              padding: EdgeInsets.all(30.0),
                              child: selectImage(0)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _cup++;
                        });
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          padding: EdgeInsets.all(4.0),
                          color: AppColor.secondaryColor,
                          child: Icon(
                            Entypo.plus,
                            color: Colors.white,
                            size: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: SizedBox(
                    height: 12.0,
                  ),
                ),
                Center(
                  child: RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      text: '${_cup}x',
                      style: TextStyle(
                          fontSize: 12.0,
                          color: AppColor.primaryColorFont,
                          fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                            text: ' gelas air $_size ml',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: AppColor.primaryColorFont)),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    height: 12.0,
                  ),
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
                      print("qty: " +
                          _cup.toString() +
                          " size: " +
                          _size.toString());
                      Center(child: CircularProgressIndicator());
                      _bloc
                          .postWater(_cup, _size)
                          .then((value) => {_bloc.fetchWater()});
                    },
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Tambahkan minum hari ini",
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void dialogCup() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 250,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Ubah Cangkir',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _select = 0;
                              _size = 100;
                            });
                            Navigator.pop(context);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15)),
                            child: Container(
                              color: AppColor.blueGrey,
                              padding: EdgeInsets.all(12.0),
                              child: Center(
                                child: Column(
                                  children: <Widget>[
                                    Image.asset('assets/images/cup100.png'),
                                    Text('100 ml')
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _select = 1;
                              _size = 150;
                            });
                            Navigator.pop(context);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15)),
                            child: Container(
                              color: AppColor.blueGrey,
                              padding: EdgeInsets.all(12.0),
                              child: Center(
                                child: Column(
                                  children: <Widget>[
                                    Image.asset('assets/images/cup150.png'),
                                    Text('150 ml')
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _select = 2;
                              _size = 200;
                            });
                            Navigator.pop(context);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15)),
                            child: Container(
                              color: AppColor.blueGrey,
                              padding: EdgeInsets.all(12.0),
                              child: Center(
                                child: Column(
                                  children: <Widget>[
                                    Image.asset('assets/images/cup200.png'),
                                    SizedBox(height: 5.0),
                                    Text('200 ml')
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _select = 3;
                              _size = 300;
                            });
                            Navigator.pop(context);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15)),
                            child: Container(
                              color: AppColor.blueGrey,
                              padding: EdgeInsets.all(12.0),
                              child: Center(
                                child: Column(
                                  children: <Widget>[
                                    Image.asset('assets/images/cup300.png'),
                                    Text('300 ml')
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _select = 4;
                              _size = 400;
                            });
                            Navigator.pop(context);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15)),
                            child: Container(
                              color: AppColor.blueGrey,
                              padding: EdgeInsets.all(12.0),
                              child: Center(
                                child: Column(
                                  children: <Widget>[
                                    Image.asset('assets/images/cup400.png'),
                                    Text('400 ml')
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _select = 5;
                              _size = 600;
                            });
                            Navigator.pop(context);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15)),
                            child: Container(
                              color: AppColor.blueGrey,
                              padding: EdgeInsets.all(12.0),
                              child: Center(
                                child: Column(
                                  children: <Widget>[
                                    Image.asset('assets/images/cup600.png'),
                                    Text('600 ml')
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8.0,
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget selectImage(int choose) {
    switch (choose) {
      case 0:
        return wrapImage("100");
        break;
      case 1:
        return wrapImage("150");
        break;
      case 2:
        return wrapImage("200");
        break;
      case 3:
        return wrapImage("300");
        break;
      case 4:
        return wrapImage("400");
        break;
      case 5:
        return wrapImage("600");
        break;
    }
    return Wrap(
      direction: Axis.vertical,
      children: <Widget>[
        Image.asset(
          'assets/images/cup200.png',
          scale: 0.5,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 8.0,
            ),
            Text(
              '200 ml',
              style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        )
      ],
    );
  }

  Widget wrapImage(String cup) {
    String select;
    switch (_select) {
      case 0:
        select = "100";
        break;
      case 1:
        select = "150";
        break;
      case 2:
        select = "200";
        break;
      case 3:
        select = "300";
        break;
      case 4:
        select = "400";
        break;
      case 5:
        select = "600";
        break;
    }

    return Wrap(
      direction: Axis.vertical,
      children: <Widget>[
        Image.asset(
          'assets/images/icup$select.png',
          scale: 1.1,
        ),
        Center(
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 15.0,
              ),
              Text(
                '$select ml',
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget cardPedometer(BuildContext context, WaterConsumeToday data) {
    int _mines = data.data.max - data.data.sum;
    int _percent = ((data.data.sum / data.data.max) * 100).round();
    double _water = _percent / 100;
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
              borderRadius: BorderRadius.circular(20.0),
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
                              Entypo.water,
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
                        text: _mines <= 0
                            ? "Yeay! Tubuh kamu sudah \n"
                            : "Hari ini kamu butuh konsumsi \n",
                        style: TextStyle(
                          color: AppColor.primaryColorFont,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: _mines <= 0 ? "terhidrasi  " : "$_mines ml",
                              style: TextStyle(
                                  color: AppColor.secondaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24.0)),
                          TextSpan(
                            text: _mines <= 0
                                ? "untuk jalani aktivitas hari ini"
                                : " air mineral",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                        _mines <= 0
                            ? "tetap penuhi kebutuhan cairan tubuhmu"
                            : "hampir sampai! jaga tubuh kamu terhidrasi",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColor.primaryColorFont,
                            fontSize: 10.0)),
                    SizedBox(height: 10.0),
                    Text('PERFECT',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColor.colorParagraphGrey2,
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
            padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 0.0),
            color: Colors.white,
            child: CircularPercentIndicator(
              radius: 130.0,
              footer: Text('GOOD',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColor.colorParagraphGrey2,
                      fontSize: 10.0)),
              animation: true,
              animationDuration: 1200,
              lineWidth: 20.0,
              percent: _mines <= 0 ? 1.0 : _water,
              center: Text(
                _percent >= 100 ? "100%" : "$_percent%",
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
      Positioned(
        left: 80.0,
        bottom: 70.0,
        child: Text('ALMOST',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColor.colorParagraphGrey2,
                fontSize: 10.0)),
      ),
      Positioned(
        right: 90.0,
        bottom: 70.0,
        child: Text('POOR',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColor.colorParagraphGrey2,
                fontSize: 10.0)),
      ),
      Positioned(
          right: 10.0,
          bottom: 0.0,
          child: RichText(
            textAlign: TextAlign.end,
            text: TextSpan(
              text: '${data.data.sum}/${data.data.max} ml',
              style: TextStyle(
                  fontSize: 16.0,
                  color: AppColor.blueHard,
                  fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                    text: '\nTarget Harian',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14.0,
                        color: AppColor.primaryColorFont)),
              ],
            ),
          ))
    ]);
  }
}
