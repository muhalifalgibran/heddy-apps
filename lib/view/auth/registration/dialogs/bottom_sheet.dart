import 'package:fit_app/core/res/app_color.dart';
import 'package:flutter/material.dart';

class ModalBS {
  static void bottomSheetBB(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
            ),
            height: MediaQuery.of(context).size.height * .3,
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Atur Berat Badan',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColor.primaryColor),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: <Widget>[],
                )
              ],
            ),
          );
        });
  }
}
