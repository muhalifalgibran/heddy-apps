import 'package:fit_app/core/res/app_color.dart';
import 'package:fit_app/models/general_post.dart';
import 'package:fit_app/network/Response.dart';
import 'package:fit_app/view/auth/registration/registration_bloc.dart';
import 'package:fit_app/view/home/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/maki_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  int _currentStep = 0;
  bool _atEnd = false;
  int _group;
  bool checkBoxValue = false;
  DateTime _dateTime = DateTime.now();
  String _timeSleep;
  String _timeWakeUp;
  int _height = 150;
  int _weight = 50;
  final _bloc = RegistrationBloc();

  int _selectedIndex = 1;

  List<IconData> _icons = [
    Maki.commerical_building,
    Maki.warehouse,
    FontAwesome5.door_open,
  ];

  List<String> _header = [
    'Aktifitas Indoor',
    'Aktifitas Semi-Indoor',
    'Aktifitas Outdoor',
  ];
  List<String> _captions = [
    'Aktivitas harian dilaksanakan di dalam ruangan tertutup',
    'Aktivitas harian dilaksanakan terbagi di dalam ruangan dan kadang turun melaksanakan aktivitas di lapangan',
    'Aktivitas harian yang selalu dilaksanakan di lapangan terbuka terpapar sinar matahari',
  ];

  setSelectedRadio(int val) {
    setState(() {
      _group = val;
    });
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
              title: Text("Edit Profil"),
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: <Widget>[],
            ),
          ),
          content()
        ],
      )),
    );
  }

  Widget _buildIcon(int index) {
    return GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        child: Container(
          height: 60.0,
          width: 60.0,
          decoration: BoxDecoration(
            color: _selectedIndex == index
                ? Theme.of(context).accentColor
                : Colors.grey[200],
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Icon(
            _icons[index],
            size: 25.0,
            color: _selectedIndex == index ? Colors.white : Color(0xFFB4C1C4),
          ),
        ));
  }

  Widget _buildCaption(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Column(
        children: <Widget>[
          Text(
            _header[index],
            style: TextStyle(
                color: AppColor.primaryColorFont,
                fontSize: 12.0,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 14.0,
          ),
          Text(
            _captions[index],
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColor.colorParagraphGrey,
                fontSize: 12.0,
                fontWeight: FontWeight.normal),
          )
        ],
      ),
    );
  }

  Widget hourMinute15Interval() {
    return Center(
      child: Container(
        child: Card(
          child: Column(
            children: <Widget>[
              Text(
                "Bangun Tidur",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColorFont),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TimePickerSpinner(
                  itemHeight: 30.0,
                  itemWidth: 50.0,
                  spacing: 10,
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

  Widget hourMinute15IntervalWake() {
    return Center(
      child: Container(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Mulai Tidur",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColor.primaryColorFont),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TimePickerSpinner(
                  itemHeight: 30.0,
                  itemWidth: 50.0,
                  spacing: 10,
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  setComplete() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('isComplete', 1);
  }

  Widget content() {
    return ListView(children: <Widget>[
      SizedBox(
        height: 100,
      ),
      Container(
        height: 700,
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Column(
          children: <Widget>[
            Text(
              "Isi data diri kamu",
              style: TextStyle(
                  color: AppColor.primaryColorFont,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Lengkapi data kamu, untuk mempermudah memantau kesehatan kamu.",
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: AppColor.colorParagraphGrey, fontSize: 12.0),
            ),
            StreamBuilder<Response<GeneralResponse>>(
                stream: _bloc.registerDataStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    switch (snapshot.data.status) {
                      case Status.LOADING:
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                        break;
                      case Status.SUCCESS:
                        setComplete();
                        navigateToPage(context);
                        break;
                      case Status.ERROR:
                        print(snapshot.data.message);
                        return Center(
                            child: Text(
                          "Periksa kembali inputan anda",
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
            Stepper(
              onStepTapped: (s) {
                setState(() {
                  _currentStep = s;
                });
              },
              steps: <Step>[
                Step(
                  title: Text("Jenis Kelamin"),
                  content: Row(
                    children: <Widget>[
                      Container(
                        width: 120.0,
                        height: 120.0,
                        child: Card(
                          child: Column(
                            children: <Widget>[
                              Radio(
                                  value: 1,
                                  groupValue: _group,
                                  onChanged: (t) {
                                    print(t);
                                    setSelectedRadio(t);
                                  }),
                              Image.asset("assets/images/lk1.png")
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 120.0,
                        height: 120.0,
                        child: Card(
                          child: Column(
                            children: <Widget>[
                              Radio(
                                  value: 2,
                                  groupValue: _group,
                                  onChanged: (t) {
                                    print(t);
                                    setSelectedRadio(t);
                                  }),
                              Image.asset("assets/images/pr1.png")
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Step(
                  title: Text("Jam Istirahat"),
                  content: Row(
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
                ),
                Step(
                  title: Text("Tinggi Badan"),
                  content: Row(
                    children: <Widget>[
                      NumberPicker.integer(
                        initialValue: _height,
                        minValue: 0,
                        maxValue: 250,
                        onChanged: (val) {
                          setState(() {
                            _height = val;
                          });
                          print(val);
                        },
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              style: BorderStyle.solid,
                              color: Colors.black26,
                            ),
                            bottom: BorderSide(
                              style: BorderStyle.solid,
                              color: Colors.black26,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "CM",
                        style: TextStyle(
                            color: AppColor.primaryColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Step(
                  title: Text("Berat Badan"),
                  content: Row(
                    children: <Widget>[
                      NumberPicker.integer(
                        initialValue: _weight,
                        minValue: 0,
                        maxValue: 250,
                        onChanged: (val) {
                          setState(() {
                            _weight = val;
                          });
                          print(val);
                        },
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              style: BorderStyle.solid,
                              color: Colors.black26,
                            ),
                            bottom: BorderSide(
                              style: BorderStyle.solid,
                              color: Colors.black26,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "Kg",
                        style: TextStyle(
                            color: AppColor.primaryColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Step(
                  title: Text("Level Aktifitas"),
                  content: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: _icons
                            .asMap()
                            .entries
                            .map(
                              (MapEntry map) => _buildIcon(map.key),
                            )
                            .toList(),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      _buildCaption(_selectedIndex),
                    ],
                  ),
                ),
              ],
              currentStep: _currentStep,
              onStepContinue: () {
                if (_currentStep < 4) {
                  setState(() {
                    _currentStep += 1;
                  });
                } else {
                  var sleepTime;
                  print("kirim");
                  setState(() {
                    sleepTime = "$_timeSleep-$_timeWakeUp";
                    print(sleepTime +
                        _height.toString() +
                        _weight.toString() +
                        " " +
                        _selectedIndex.toString());
                  });
                  print(_group - 1);
                  _bloc.updateUserProfile(
                      _group - 1, _height, _weight, sleepTime, _selectedIndex);
                }
              },
              onStepCancel: () {
                setState(() {
                  if (_currentStep > 0) {
                    _currentStep -= 1;
                  } else {
                    _currentStep = 0;
                  }
                });
              },
            ),
          ],
        ),
      ),
    ]);
  }

  Future navigateToPage(BuildContext context) async {
    Navigator.popAndPushNamed(context, '/home');
  }

  Widget background() {
    return Container(
      decoration: BoxDecoration(gradient: AppColor.blueGradient),
      padding: const EdgeInsets.only(bottom: 2.0),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 1,
            top: 1,
            child: Image.asset('assets/images/lingk-kiri2.png'),
          ),
          Positioned(
            right: 1,
            top: 1,
            child: Image.asset('assets/images/lingkarkanan1.png'),
          )
        ],
      ),
    );
  }
}
