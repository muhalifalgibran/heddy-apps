import 'package:fit_app/core/res/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/maki_icons.dart';
import 'package:native_color/native_color.dart';

class SportTrackerScreen extends StatefulWidget {
  @override
  _SportTrackerScreenState createState() => _SportTrackerScreenState();
}

class _SportTrackerScreenState extends State<SportTrackerScreen> {
  String _timeSleep;
  String _timeWakeUp;
  int _select = 0;
  int _size = 100;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Olahraga"),
      ),
      body: Container(
          padding: EdgeInsets.all(12.0),
          child: ListView(
            children: <Widget>[
              topCard(),
              SizedBox(height: 20.0),
              secondCard(),
              SizedBox(height: 20.0),
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
                    // Center(child: CircularProgressIndicator());
                  },
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Tambahkan aktifitas hari ini",
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: 20.0),
              thirdCard()
            ],
          )),
    ));
  }

  Widget topCard() {
    return Container(
      height: 280.0,
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: AppColor.yellowSoft,
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Center(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        padding: EdgeInsets.all(4.0),
                        color: Colors.white,
                        child: Icon(
                          Maki.basketball,
                          color: AppColor.yellowHard,
                          size: 10.0,
                        ),
                      ),
                    ),
                    SizedBox(width: 5.0),
                    Text(
                      "Air Mineral",
                      style:
                          TextStyle(fontSize: 10.0, color: AppColor.yellowHard),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "Yok Catat Aktifitas kamu hari ini \n",
                    style: TextStyle(
                      color: AppColor.primaryColorFont,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: "tetap jaga kondisi konsentrasimu",
                          style: TextStyle(
                              color: AppColor.primaryColorFont,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                GestureDetector(
                  onTap: () => dialogCup(),
                  child: Container(
                      width: 150.0,
                      height: 150.0,
                      child: Card(
                        color: Colors.white,
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Image.asset("assets/images/basket.png"),
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget secondCard() {
    return Container(
      height: 200.0,
      width: MediaQuery.of(context).size.width,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: AppColor.yellowSoft,
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Atur Waktu Aktivitas",
                style: TextStyle(
                    color: AppColor.primaryColorFont,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        hourMinute15Interval(),
                      ],
                    ),
                  ),
                  Icon(
                    Entypo.minus,
                    color: AppColor.primaryColor,
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        hourMinute15IntervalWake(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget thirdCard() {
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
            "Rekapan harian aktifitas olahraga kamu.",
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
                    // children: List.generate(data.data.history.length, (index) {
                    //   // return listItem(data.data.history[index]);
                    // }),
                    )))
      ],
    );
  }

  Widget hourMinute15Interval() {
    return Center(
      child: Container(
        child: Card(
          elevation: 5.0,
          child: Column(
            children: <Widget>[
              Text(
                "Berhenti Olahraga",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColorFont),
              ),
              Padding(
                padding: EdgeInsets.only(right: 30.0, top: 12.0, bottom: 12.0),
                child: TimePickerSpinner(
                  itemHeight: 30.0,
                  itemWidth: 50.0,
                  spacing: 5,
                  highlightedTextStyle:
                      TextStyle(fontSize: 24.0, color: AppColor.primaryColor),
                  normalTextStyle: TextStyle(fontSize: 18.0),
                  minutesInterval: 5,
                  onTimeChange: (time) {
                    setState(() {
                      _timeSleep = time.hour.toString().padLeft(2, '0') +
                          '.' +
                          time.minute.toString().padLeft(2, '0');
                    });
                  },
                ),
              ),
            ],
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
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Pilih jenis olahraga',
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
                                    Image.asset(
                                      'assets/images/basket.png',
                                      height: 60,
                                      width: 60,
                                    ),
                                    Text('Basket')
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
                                    Image.asset(
                                      'assets/images/volley.png',
                                      height: 60,
                                      width: 60,
                                    ),
                                    Text('volley ml')
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
                                    Image.asset(
                                      'assets/images/cycling.png',
                                      height: 60,
                                      width: 60,
                                    ),
                                    SizedBox(height: 5.0),
                                    Text('Bersepeda')
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
                                    Image.asset(
                                      'assets/images/senam.png',
                                      height: 60,
                                      width: 60,
                                    ),
                                    Text('senam')
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
                                    Image.asset(
                                      'assets/images/jalan-santai.png',
                                      height: 60,
                                      width: 60,
                                    ),
                                    Text('Jalan santai')
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
                                    Image.asset(
                                      'assets/images/jogging.png',
                                      height: 60,
                                      width: 60,
                                    ),
                                    Text('Jogging')
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _select = 4;
                          _size = 400;
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 100,
                        width: 80,
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
                                  Image.asset(
                                    'assets/images/futsal.png',
                                    height: 60,
                                    width: 60,
                                  ),
                                  Text('Futsal')
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
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

  Widget hourMinute15IntervalWake() {
    return Center(
      child: Container(
        child: Card(
          elevation: 5.0,
          child: Column(
            children: <Widget>[
              Text(
                "Mulai Olahraga",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColorFont),
              ),
              Padding(
                padding: EdgeInsets.only(right: 30.0, top: 12.0, bottom: 12.0),
                child: TimePickerSpinner(
                  itemHeight: 30.0,
                  itemWidth: 50.0,
                  spacing: 5,
                  highlightedTextStyle:
                      TextStyle(fontSize: 24.0, color: AppColor.primaryColor),
                  normalTextStyle: TextStyle(fontSize: 18.0),
                  minutesInterval: 5,
                  onTimeChange: (time) {
                    setState(() {
                      _timeWakeUp = time.hour.toString().padLeft(2, '0') +
                          '.' +
                          time.minute.toString().padLeft(2, '0');
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
