import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:fit_app/view/bodycheck/checkBoxBC.dart';
import 'package:fit_app/view/home/bloc.dart';
import 'package:fit_app/view/home/fragment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:line_icons/line_icons.dart';

class BodyCheckFragment implements BaseHomeFragment {
  BodyCheckFragment(this.position);

  @override
  BottomNavyBarItem bottomNavyBarItem = BottomNavyBarItem(
    icon: Icon(FontAwesome5.people_carry),
    title: Text('Community'),
    activeColor: Colors.redAccent,
    inactiveColor: Colors.white,
  );

  @override
  int position;

  @override
  Widget view = BodyCheckScreen();

  @override
  void onTabSelected(BuildContext mContext) {
    BlocProvider.of<HomeScreenBloc>(mContext).add(this);
  }
}

class BodyCheckScreen extends StatelessWidget {
  const BodyCheckScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container());
  }

  Widget createAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.blue),
      titleSpacing: 0,
      backgroundColor: Colors.blue,
      title: Text(
        "Community",
        style: TextStyle(color: Colors.white),
      ),
      leading: Icon(
        Icons.dehaze,
        color: Colors.white,
      ),
      actions: <Widget>[
        Icon(
          Icons.search,
          color: Colors.white,
        ),
      ],
    );
  }
}
