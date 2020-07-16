import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:fit_app/view/bodycheck/bodyCheckScreen.dart';
import 'package:fit_app/view/community/communityScreen.dart';
import 'package:fit_app/view/home/bloc.dart';
import 'package:fit_app/view/home/fragment.dart';
import 'package:fit_app/view/profile/new_home_screen.dart';
import 'package:fit_app/view/profile/profileScreen.dart';
import 'package:fit_app/view/sporttracker/sportScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:native_color/native_color.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<BaseHomeFragment> fragments = <BaseHomeFragment>[
    // NewHomeScreenFragment(0),
    // BodyCheckFragment(1),
    // SportTrackerFragment(2),
    CommunityFragment(1)
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeScreenBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        endDrawer: Drawer(),
        body: SafeArea(child: createBody()),
        bottomNavigationBar: createBottomBar(),
      ),
    );
  }

  Widget createBody() {
    return BlocBuilder<HomeScreenBloc, int>(
      builder: (context, index) => fragments[index].view,
    );
  }

  BlocBuilder<HomeScreenBloc, int> createBottomBar() {
    return BlocBuilder<HomeScreenBloc, int>(builder: (context, index) {
      return BottomNavyBar(
        selectedIndex: index,
        backgroundColor: HexColor('283761'),
        showElevation: true, // use this to remove appBar's elevation
        onItemSelected: (index) => fragments[index].onTabSelected(context),
        items: fragments.map((f) => f.bottomNavyBarItem).toList(),
      );
    });
  }
}
