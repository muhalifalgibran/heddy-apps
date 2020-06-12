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
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:line_icons/line_icons.dart';

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
  final _bloc = CommunityBloc();

  @override
  void initState() {
    super.initState();
    _bloc.getProfile();
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
                  Icon(Icons.share),
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
            Icon(
              Typicons.pencil,
              size: 16.0,
              color: Colors.white,
            )
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
                  Container(
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
                                    borderRadius: BorderRadius.circular(30.0)),
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
                                  "22 Sept 1990",
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
                  //sleep
                  Container(
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
                                    borderRadius: BorderRadius.circular(30.0)),
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
                      ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  //height
                  Container(
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
                                    borderRadius: BorderRadius.circular(30.0)),
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
                                  "${data.height} kg",
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
                  //berat badan
                  Container(
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
                                    borderRadius: BorderRadius.circular(30.0)),
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
                      ))
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
              Container(
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
              )
            ],
          ),
        )
      ]),
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
