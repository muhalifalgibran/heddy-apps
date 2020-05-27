import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

/// an interface of landing page - fragments
abstract class BaseHomeFragment {
  // property
  int position;

  // view
  BottomNavyBarItem bottomNavyBarItem;
  Widget view;

  // method
  void onTabSelected(BuildContext mContext);
}
