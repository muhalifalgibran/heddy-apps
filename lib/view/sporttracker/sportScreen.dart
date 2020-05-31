import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:fit_app/view/home/bloc.dart';
import 'package:fit_app/view/home/fragment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

class SportTrackerFragment implements BaseHomeFragment {
  SportTrackerFragment(this.position);

  @override
  BottomNavyBarItem bottomNavyBarItem = BottomNavyBarItem(
    icon: Icon(LineIcons.road),
    title: Text('Sport Track'),
    activeColor: Colors.orangeAccent,
    inactiveColor: Colors.white,
  );

  @override
  int position;

  @override
  Widget view = SportTrackerScreen();

  @override
  void onTabSelected(BuildContext mContext) {
    BlocProvider.of<HomeScreenBloc>(mContext).add(this);
  }
}

class SportTrackerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
