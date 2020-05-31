import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:fit_app/view/home/bloc.dart';
import 'package:fit_app/view/home/fragment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

class CommunityFragment implements BaseHomeFragment {
  CommunityFragment(this.position);

  @override
  BottomNavyBarItem bottomNavyBarItem = BottomNavyBarItem(
    icon: Icon(LineIcons.group),
    title: Text('Komunitas'),
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

class CommunityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
