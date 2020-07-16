import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:fit_app/core/res/app_color.dart';
import 'package:fit_app/core/tools/constants.dart';
import 'package:fit_app/models/user_attribute.dart';
import 'package:fit_app/network/Response.dart';
import 'package:fit_app/view/community/community_bloc.dart';
import 'package:fit_app/view/home/bloc.dart';
import 'package:fit_app/view/home/fragment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/maki_icons.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:fit_app/core/tools/constants.dart' as Constants;
import 'package:intl/intl.dart';

import 'package:line_icons/line_icons.dart';
import 'package:numberpicker/numberpicker.dart';

class CommunityFragment implements BaseHomeFragment {
  CommunityFragment(this.position);

  @override
  BottomNavyBarItem bottomNavyBarItem = BottomNavyBarItem(
    icon: Icon(Octicons.person),
    title: Text('Profil'),
    activeColor: Colors.green,
    inactiveColor: Colors.white,
  );

  @override
  int position;

  @override
  Widget view = CommunityScreen();

  @override
  void onTabSelected(BuildContext mContext) {
    BlocProvider.of<HomeScreenBloc>(mContext).add(this);
  }
}

void choiceAction(String items) {
  if (items == MenuLogout.logout) {}
}

class CommunityScreen extends StatefulWidget {
  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  CommunityBloc _bloc;
  final url = Constants.API_URL;
  DateTime _date = DateTime.now();
  String _timeSleep;
  String _timeWakeUp;
  int _height = 150;
  int _weight = 50;
  int _heightInit = 150;
  int _weightInit = 50;

  @override
  void initState() {
    super.initState();
    _bloc = CommunityBloc();
    _bloc.getProfile();
  }

  Future selectedDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(1970),
        lastDate: DateTime(2021));

    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
      });
      print(_date);
      String birth = DateFormat('yyyy-MM-dd').format(_date);
      _bloc.setProfil(0, birth);
      _bloc.getProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SafeArea(
            child: Stack(
          children: <Widget>[
            background(),
            Positioned(
              child: AppBar(
                leading: null,
                title: Text("Profil"),
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: <Widget>[
                  // Icon(Icons.share),
                  // PopupMenuButton<String>(
                  //   onSelected: choiceAction,
                  //   itemBuilder: (BuildContext context) {
                  //     return MenuLogout.pilihan.map((String e) {
                  //       return PopupMenuItem<String>(
                  //         value: e,
                  //         child: Text(e),
                  //       );
                  //     }).toList();
                  //   },
                  // )
                ],
              ),
            ),
            RefreshIndicator(
                onRefresh: () => _bloc.getProfile(),
                child: StreamBuilder<Response<UserAttribut>>(
                  stream: _bloc.postSleepStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      switch (snapshot.data.status) {
                        case Status.LOADING:
                          return Center(child: CircularProgressIndicator());
                          break;
                        case Status.SUCCESS:
                          print("success");
                          return content(context, snapshot.data.data.data);
                          break;
                        case Status.ERROR:
                          print(snapshot.data.data.toString());
                          return Center(child: Text("Periksa koneksi kamu :)"));
                          break;
                      }
                    }
                    return Container();
                  },
                )),
          ],
        )),
      ),
    );
  }

  Widget content(BuildContext context, Data data) {
    _heightInit = data.height;
    _weightInit = data.weight;
    String dateOfBirth = DateFormat('dd MMM yyyy').format(data.dateOfBirth);
    return Container(
      padding: EdgeInsets.only(top: 60.0),
      child: ListView(children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 12.0, right: 12.0),
          child: Row(children: <Widget>[
            CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(data.utility.faceUrl),
            ),
            SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Halo ${data.name}",
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  "Keep Healthy :)",
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.white60),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "${data.utility.email}",
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.white60),
                ),
              ],
            ),
            Spacer(),
            // Icon(
            //   Typicons.pencil,
            //   size: 16.0,
            //   color: Colors.white,
            // )
          ]),
        ),
        SizedBox(
          height: 30.0,
        ),
        // informasi profil
        Container(
          padding: EdgeInsets.all(12.0),
          height: 490,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Informasi Profil",
                style: TextStyle(
                    color: AppColor.primaryColorFont,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Kamu bisa edit data dirimu untuk mengubahnya",
                style: TextStyle(
                    color: AppColor.colorParagraphGrey,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  //calendar
                  GestureDetector(
                    onTap: () => selectedDate(context),
                    child: Container(
                        height: 100,
                        width: 170,
                        child: Card(
                          elevation: 3.0,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      color: AppColor.blueHard,
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    FontAwesome.calendar,
                                    size: 18.0,
                                    color: Colors.white,
                                  ),
                                ),
                                Spacer(),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "Tanggal Lahir",
                                    style: TextStyle(
                                        color: AppColor.colorParagraphGrey,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    dateOfBirth,
                                    style: TextStyle(
                                        color: AppColor.blueHard,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
                  //sleep
                  GestureDetector(
                    onTap: () => dialogSleepTime(),
                    child: Container(
                        height: 100,
                        width: 170,
                        child: Card(
                          elevation: 3.0,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      color: AppColor.blueCyan,
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    FontAwesome.bed,
                                    size: 18.0,
                                    color: Colors.white,
                                  ),
                                ),
                                Spacer(),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "Waktu tidur",
                                    style: TextStyle(
                                        color: AppColor.colorParagraphGrey,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "${data.sleepTime}",
                                    style: TextStyle(
                                        color: AppColor.blueCyan,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  //height
                  GestureDetector(
                    onTap: () => dialogHeight(),
                    child: Container(
                        height: 100,
                        width: 170,
                        child: Card(
                          elevation: 3.0,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      color: AppColor.pinkHard,
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    FontAwesome5.arrows_alt_v,
                                    size: 18.0,
                                    color: Colors.white,
                                  ),
                                ),
                                Spacer(),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "Tinggi",
                                    style: TextStyle(
                                        color: AppColor.colorParagraphGrey,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "${data.height} cm",
                                    style: TextStyle(
                                        color: AppColor.pinkHard,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
                  //berat badan
                  GestureDetector(
                    onTap: () => dialogWeight(),
                    child: Container(
                        height: 100,
                        width: 170,
                        child: Card(
                          elevation: 3.0,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      color: AppColor.yellowHard,
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    FontAwesome5.arrows_alt_h,
                                    size: 18.0,
                                    color: Colors.white,
                                  ),
                                ),
                                Spacer(),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "Berat badan",
                                    style: TextStyle(
                                        color: AppColor.colorParagraphGrey,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "${data.weight} kg",
                                    style: TextStyle(
                                        color: AppColor.yellowHard,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              //level aktifirtas
              Text(
                "Level Aktifitas",
                style: TextStyle(
                    color: AppColor.primaryColorFont,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Optimalkan level aktifitasmu",
                style: TextStyle(
                    color: AppColor.colorParagraphGrey,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: () => dialogLevelActivity(),
                child: Container(
                  height: 120.0,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Card(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: AppColor.primaryColor,
                                borderRadius: BorderRadius.circular(30.0)),
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Elusive.person,
                              size: 36.0,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 30.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 180,
                                child: Text(
                                  "Level Aktifitas kamu",
                                  style: TextStyle(
                                      color: AppColor.primaryColorFont,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                height: 50.0,
                                width: 250.0,
                                child: Text(
                                  (() {
                                    if (data.activityLevel == 0) {
                                      return "Aktivitas harian dilaksanakan di dalam ruangan tertutup";
                                    } else if (data.activityLevel == 1) {
                                      return "Aktivitas harian dilaksanakan terbagi di dalam ruangan dan kadang turun melaksanakan aktivitas di lapangan";
                                    } else if (data.activityLevel == 2) {
                                      return "Aktivitas harian yang selalu dilaksanakan di lapangan terbuka terpapar sinar matahari";
                                    } else {
                                      return "Ayo tingkatkan produktifitas keseharianmu lagi";
                                    }
                                  }()),
                                  style: TextStyle(
                                      color: AppColor.colorParagraphGrey,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )),
                  ),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }

  void dialogSleepTime() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 260,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Waktu tidur',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      height: 145.0,
                      width: 400.0,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    hourMinute15IntervalWake(),
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
                                    hourMinute15Interval(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    FlatButton(
                        color: AppColor.primaryColor,
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
                          var sleep = _timeWakeUp + "-" + _timeSleep;
                          print(_timeWakeUp + " sd " + _timeSleep);
                          _bloc.setProfil(1, sleep);
                          _bloc.getProfile();
                          Navigator.of(context).pop();
                        },
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Simpan",
                                  style: TextStyle(fontSize: 14.0),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void dialogHeight() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 260,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Tinggi Badan',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        NumberPicker.integer(
                          initialValue: _heightInit,
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
                    FlatButton(
                        color: AppColor.primaryColor,
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

                          _bloc.setProfil(2, _height.toString());
                          _bloc.getProfile();
                          Navigator.of(context).pop();
                        },
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Simpan",
                                  style: TextStyle(fontSize: 14.0),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void dialogLevelActivity() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return MyDialog();
        });
  }

  void dialogWeight() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 260,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Berat Badan',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        NumberPicker.integer(
                          initialValue: _weightInit,
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
                    FlatButton(
                        color: AppColor.primaryColor,
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
                          _bloc.setProfil(3, _weight.toString());
                          _bloc.getProfile();
                          Navigator.of(context).pop();
                        },
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Simpan",
                                  style: TextStyle(fontSize: 14.0),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          );
        });
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
                  height: 5.0,
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

class MyDialog extends StatefulWidget {
  @override
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
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

  Color _c = Colors.redAccent;

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

  CommunityBloc _bloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = CommunityBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)), //this right here
      child: Container(
        height: 260,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Level Aktifitas',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Column(
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
              FlatButton(
                  color: AppColor.primaryColor,
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

                    _bloc.setProfil(4, _selectedIndex.toString());
                    _bloc.getProfile();
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Simpan",
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
