import 'package:fit_app/core/res/app_color.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FoodConsumtion extends StatefulWidget {
  @override
  _FoodConsumtionState createState() => _FoodConsumtionState();
}

class _FoodConsumtionState extends State<FoodConsumtion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Konsumsi Makan"),
        backgroundColor: AppColor.secondaryColor,
        elevation: 0.0,
        actions: <Widget>[],
      ),
      body: RefreshIndicator(
        onRefresh: () {},
        child: Container(
          padding: EdgeInsets.all(12.0),
          child: ListView(
            children: <Widget>[
              topCard(),
            ],
          ),
        ),
      ),
    );
  }

  String _foodTime;
  int _selectedIndex;
  List<IconData> _icons = [
    FontAwesomeIcons.sadTear,
    FontAwesomeIcons.meh,
    FontAwesomeIcons.smile,
    FontAwesomeIcons.laughBeam,
  ];

  List<String> _desc = ["Sayur", "Lauk", "Buah", "Minuman"];

  Widget _buildIcon(int index) {
    return Row(
      children: <Widget>[
        GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Container(
              height: 30.0,
              width: 30.0,
              decoration: BoxDecoration(
                color: _selectedIndex == index
                    ? AppColor.pinkHard
                    : Color(0xFFE7EBEE),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Icon(
                _icons[index],
                size: 20.0,
                color:
                    _selectedIndex == index ? Colors.white : Color(0xFFB4C1C4),
              ),
            )),
        SizedBox(width: 6.0),
        Text(
          _desc[index],
          style: TextStyle(color: AppColor.primaryColorFont, fontSize: 12.0),
        )
      ],
    );
  }

  Widget topCard() {
    return Stack(alignment: Alignment.center, children: <Widget>[
      Container(
        alignment: Alignment.topCenter,
        height: 280.0,
        width: MediaQuery.of(context).size.width,
        child: SizedBox(
          width: double.infinity,
          height: 400.0,
          child: Card(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            color: AppColor.pinkSoft,
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            padding: EdgeInsets.all(4.0),
                            color: Colors.white,
                            child: Icon(
                              Linecons.food,
                              color: AppColor.pinkHard,
                              size: 10.0,
                            ),
                          ),
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          "Konsumsi Makan",
                          style: TextStyle(
                              fontSize: 10.0, color: AppColor.pinkHard),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Yok pilih menu makanan yang \n kamu konsumsi hari ini",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColor.primaryColorFont,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text("Tetap jaga komposisi makan kamu ya!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColor.primaryColorFont,
                            fontSize: 10.0)),
                    SizedBox(height: 10.0),
                    RaisedButton(
                      elevation: 10.0,
                      color: AppColor.pinkHard,
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      padding: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
                      splashColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () {
                        /*...*/
                        foodTime();
                      },
                      child: Text(
                        _foodTime == null
                            ? "Pilih menu makanmu  >"
                            : "Waktu makan $_foodTime",
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    Container(
                      padding: EdgeInsets.only(left: 12.0, right: 12.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: TextField(
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.search,
                              color: AppColor.colorParagraphGrey,
                            ),
                            border: InputBorder.none,
                            hintText: 'Cari Makanan...'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  void foodTime() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 110.0,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Waktu Makan',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FlatButton(
                          color: AppColor.pinkSoft,
                          textColor: AppColor.primaryColorFont,
                          disabledColor: Colors.grey,
                          disabledTextColor: Colors.black,
                          padding: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
                          splashColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          onPressed: () {
                            /*...*/
                            setState(() {
                              _foodTime = "Pagi";
                            });
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Pagi",
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                        FlatButton(
                          color: AppColor.pinkSoft,
                          textColor: AppColor.primaryColorFont,
                          disabledColor: Colors.grey,
                          disabledTextColor: Colors.black,
                          padding: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
                          splashColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          onPressed: () {
                            /*...*/
                            setState(() {
                              _foodTime = "Siang";
                            });
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Siang",
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                        FlatButton(
                          color: AppColor.pinkSoft,
                          textColor: AppColor.primaryColorFont,
                          disabledColor: Colors.grey,
                          disabledTextColor: Colors.black,
                          padding: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
                          splashColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          onPressed: () {
                            /*...*/
                            setState(() {
                              _foodTime = "Malam";
                            });
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Malam",
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.0,
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
