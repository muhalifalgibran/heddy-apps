import 'package:fit_app/core/res/app_color.dart';
import 'package:fit_app/models/general_post.dart';
import 'package:fit_app/models/sleep_check.dart';
import 'package:fit_app/network/Response.dart';
import 'package:fit_app/view/home/homeScreen.dart';
import 'package:fit_app/view/profile/sleepTime/sleepBloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SleepScreen extends StatefulWidget {
  @override
  _SleepScreenState createState() => _SleepScreenState();
}

class _SleepScreenState extends State<SleepScreen> {
  String _timeSleep;
  String _timeWakeUp;
  bool _isSleep = true;
  bool isVisible = false;
  final _bloc = SleepBloc();
  int _sleepStep = 0;
  int _sleepStepButton = 0;
  String _buttonText = "Mulai Tidur";
  String formattedDate;
  String tanggal;
  String formattedSleep;
  bool isManuallyInput = false;
  bool readyToClick = false;
  bool buttonBack = false;

  @override
  void initState() {
    super.initState();
    var now = new DateTime.now();
    var dateFirstSleep = new DateTime.now();
    tanggal = DateFormat.yMMMMEEEEd().format(now);
    handleAppLifecycleState();
    formattedDate = DateFormat('kk:mm').format(now);
    initializeDateFormatting('id', null);
    Intl.defaultLocale = 'id';
    _bloc.checkSleep();
    formattedSleep = DateFormat('kk:mm').format(dateFirstSleep);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  _onpressed() {
    setState(() {
      if (_sleepStep == 0) {
        print(formattedSleep);
        _bloc.createStart(formattedSleep);
        _sleepStep = 1;
        _buttonText = "Siap Bangun!";
      } else if (_sleepStep == 1) {
        _sleepStep = 2;
        _sleepStepButton = 2;
        _bloc.sleepEventSink.add(IsWake());
        _buttonText = "Simpan";
        var now = new DateTime.now();
        formattedDate = DateFormat('kk:mm').format(now);
        isVisible = true;
      } else if (_sleepStep == 2) {
        print("ddd");
        _sleepStepButton = 3;
      }
      // if (buttonBack) {
      //   navigateToPage(context);
      // }
      if (readyToClick) {
        print("bloc");
        _bloc.createManual(formattedSleep, formattedDate);
        _bloc.checkSleep();

        // navigateToPage(context);
      }
      print("step:" + _sleepStepButton.toString());
    });
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Anda sudah tidur"),
          content: new Text("Anda telah melakukan tidur malam"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  handleAppLifecycleState() {
    AppLifecycleState _lastLifecyleState;
    SystemChannels.lifecycle.setMessageHandler((msg) {
      print('SystemChannels> $msg');

      switch (msg) {
        case "AppLifecycleState.paused":
          _lastLifecyleState = AppLifecycleState.paused;
          setState(() {
            var now = new DateTime.now();
            formattedDate = DateFormat('kk:mm').format(now);
          });
          break;
        case "AppLifecycleState.inactive":
          _lastLifecyleState = AppLifecycleState.inactive;
          break;
        case "AppLifecycleState.resumed":
          _lastLifecyleState = AppLifecycleState.resumed;
          setState(() {
            var now = new DateTime.now();
            formattedDate = DateFormat('kk:mm').format(now);
            tanggal = DateFormat.yMMMMEEEEd().format(now);
          });
          break;
        case "AppLifecycleState.suspending":
          // _lastLifecyleState = AppLifecycleState.suspending;
          break;
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<bool>(
          initialData: true,
          stream: _bloc.sleepStateStream,
          builder: (context, snapshot1) {
            return SafeArea(
              child: Stack(
                children: <Widget>[
                  background(snapshot1),
                  StreamBuilder(
                      stream: _bloc.checkStream,
                      builder: (context,
                          AsyncSnapshot<Response<SleepCheck>> snapshot) {
                        if (snapshot.hasData) {
                          switch (snapshot.data.status) {
                            case Status.LOADING:
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                              break;
                            case Status.SUCCESS:
                              switch (snapshot.data.data.data.code) {
                                case 0:
                                  return content(
                                      snapshot1, snapshot.data.data.data);
                                  break;
                                case 1:
                                  _sleepStep = 1;
                                  return content(
                                      snapshot1, snapshot.data.data.data);
                                  break;
                                case 2:
                                  // _showDialog();
                                  // navigateToPage(context);
                                  return backToDashboard();
                                  break;
                              }

                              break;
                            case Status.ERROR:
                              return Center(
                                  child: Text(
                                "Terjadi kesalahan, input lagi nanti",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                                textAlign: TextAlign.center,
                              ));
                              break;
                          }
                        }
                        return Container();
                      }),
                  StreamBuilder(
                      stream: _bloc.postSleepManualStream,
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
                              print("dsad");
                              _bloc.checkSleep();
                              // navigateToPage(context);
                              break;
                            case Status.ERROR:
                              return Center(
                                  child: Text(
                                "Terjadi kesalahan, input lagi nanti",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                                textAlign: TextAlign.center,
                              ));
                              break;
                          }
                        }
                        return Container();
                      }),
                ],
              ),
            );
          }),
    );
  }

  Widget content(AsyncSnapshot<bool> snapshot, Data data) {
    if (data.startSleep != null) {
      formattedSleep = data.startSleep;
    }

    return Center(
      child: Container(
        padding:
            EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0, top: 80.0),
        child: ListView(
          children: <Widget>[
            Center(
              child: Text(
                "$tanggal",
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: snapshot.data
                        ? Colors.white
                        : AppColor.primaryColorFont),
              ),
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
            ),
            SizedBox(
              height: 30.0,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            FontAwesome.moon,
                            color: AppColor.secondaryColor,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "TIDUR",
                            style: TextStyle(
                                fontSize: 12.0, color: AppColor.secondaryColor),
                          )
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        height: 40.0,
                        child: Align(
                          alignment: Alignment.center,
                          child: _sleepStep == 0
                              ? Icon(
                                  Typicons.minus,
                                  color: Colors.white,
                                )
                              : Text(
                                  "$formattedSleep",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 36.0,
                                      color: snapshot.data
                                          ? Colors.white
                                          : AppColor.primaryColor),
                                ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 80.0),
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            FontAwesome.sun,
                            color: AppColor.secondaryColor,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "BANGUN",
                            style: TextStyle(
                                fontSize: 12.0, color: AppColor.secondaryColor),
                          )
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        height: 40.0,
                        child: Align(
                          alignment: Alignment.center,
                          child: (() {
                            if (_sleepStepButton == 0)
                              return Icon(Typicons.minus, color: Colors.white);
                            else if (_sleepStepButton == 1) {
                              return Icon(Typicons.minus, color: Colors.white);
                            } else if (_sleepStepButton == 2) {
                              return Text(
                                "$formattedDate",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 36.0,
                                    color: snapshot.data
                                        ? Colors.white
                                        : AppColor.primaryColor),
                              );
                            }
                          }()),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            RaisedButton(
              elevation: 5.0,
              color: (() {
                // your code here
                if (_sleepStep == 0) {
                  return AppColor.secondaryColor;
                } else if (_sleepStep == 1) {
                  return AppColor.yellowHard;
                } else if (_sleepStep == 2) {
                  return AppColor.blueHard;
                }
              }()),
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
              splashColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              onPressed: _onpressed,
              child: Text(
                (() {
                  // your code here
                  if (_sleepStep == 0) {
                    return "Mulai tidur";
                  } else if (_sleepStep == 1) {
                    return "Siap bangun!";
                  } else if (_sleepStep == 2) {
                    return "Simpan";
                  }
                  if (_sleepStepButton == 2) {
                    buttonBack = true;
                    _sleepStepButton = 3;
                    return "Simpan";
                  }
                }()),
                style: TextStyle(fontSize: 14.0),
              ),
            ),
            Visibility(
              visible: isVisible,
              child: OutlineButton(
                color: Colors.black,
                borderSide: BorderSide(color: Colors.black),
                highlightColor: Colors.black,
                textColor: AppColor.primaryColorFont,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
                splashColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                onPressed: () {
                  isManuallyInput = true;
                  dialogCup();
                },
                child: Text(
                  "Atur waktu manual",
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget background(AsyncSnapshot<bool> snapshot) {
    if (!snapshot.data) {
      readyToClick = true;
      print("d");
    }
    print(snapshot.data);

    print(_sleepStepButton);
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
    ]);
  }

  void dialogCup() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 240,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      "Atur waktu tidur sendiri",
                      style: TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.bold),
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
                            mainAxisAlignment: MainAxisAlignment.center,
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              hourMinute15IntervalWake(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    RaisedButton(
                      elevation: 5.0,
                      color: AppColor.primaryColor,
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      padding: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
                      splashColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () {
                        _bloc.createManual(_timeSleep, _timeWakeUp);
                        _bloc.checkSleep();

                        Navigator.pop(context);
                        // navigateToPage(context);
                      },
                      child: Text(
                        "Simpan",
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future navigateToPage(BuildContext context) async {
    return Navigator.of(context).pop();
  }

  Widget hourMinute15IntervalWake() {
    return Center(
      child: Container(
        child: Card(
          elevation: 5.0,
          child: Column(
            children: <Widget>[
              Text(
                "Waktu bangun",
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
                          ':' +
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

  Widget backToDashboard() {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 300.0,
            ),
            Text("Kamu telah tidur malam ini",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18.0,
                )),
            SizedBox(
              height: 10.0,
            ),
            RaisedButton(
              textColor: Colors.black,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
              splashColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              child: Text("Kembali ke beranda"),
              onPressed: () => navigateToPage(context),
            )
          ],
        ),
      ),
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
                "Waktu tidur",
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
                          ':' +
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
