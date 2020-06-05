import 'package:fit_app/core/res/app_color.dart';
import 'package:fit_app/models/food_consumtion.dart';
import 'package:fit_app/network/Response.dart';
import 'package:fit_app/view/profile/foodComsumtion/food_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FoodConsumtion extends StatefulWidget {
  @override
  _FoodConsumtionState createState() => _FoodConsumtionState();
}

class Item {
  String imageUrl;
  int rank;
  Item(this.imageUrl, this.rank);
}

class _FoodConsumtionState extends State<FoodConsumtion> {
  List<Item> itemList;
  List<Item> selectedList;
  bool _isDisabled = true;
  var _onPressed;
  DateTime _dateTime = DateTime.now();
  final textEdit = TextEditingController();
  int _selectedIndex;

  FoodBloc _bloc;

  @override
  void initState() {
    loadList();
    super.initState();
    _bloc = FoodBloc();
    textEdit.addListener(_printLatestValue);
  }

  _printLatestValue() {
    // print("Second text field: ${textEdit.text}");
    String _search;
    textEdit.text.isEmpty ? _search = "" : _search = textEdit.text.toString();
    _bloc.postWater(_selectedIndex + 1, _search);
  }

  @override
  void dispose() {
    _bloc.dispose();
    textEdit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isDisabled) {
      _onPressed = () {
        print("tap");
        datePickerDialog();
      };
    }
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
              SizedBox(height: 16.0),
              SizedBox(
                height: 240,
                child: StreamBuilder<Response<FoodConsumtionModel>>(
                    stream: _bloc.foodDataStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        switch (snapshot.data.status) {
                          case Status.LOADING:
                            return Container();
                            break;
                          case Status.SUCCESS:
                            // setState(() {
                            _isDisabled = false;
                            // });
                            return gridList(snapshot.data.data.foods);
                            break;
                          case Status.ERROR:
                            print(snapshot.data.message);
                            print("asdfsdf");
                            // return Center(child: Text("Periksa kembali jaringan anda"));
                            return Container();
                            break;
                        }
                      }
                      return Container();
                    }),
              ),
              RaisedButton(
                elevation: 5.0,
                color: AppColor.pinkHard,
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
                splashColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                onPressed: _onPressed,
                child: Text(
                  "Simpan",
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  loadList() {
    itemList = List();
    selectedList = List();

    List.generate(20, (index) {
      itemList.add(Item("assets/images/frame-ilustrasi1.png", index + 1));
    });
  }

  String _foodTime;

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
                print(_selectedIndex.toString());
                _bloc.postWater(_selectedIndex + 1, "");
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
                      elevation: 5.0,
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
                        controller: textEdit,
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.search,
                              color: AppColor.colorParagraphGrey,
                            ),
                            border: InputBorder.none,
                            hintText: 'Cari Makanan...'),
                      ),
                    ),
                    // gridList()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  Widget gridList1() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(20, (index) {
        return Center(
          child: Text(
            'Item $index',
            style: Theme.of(context).textTheme.headline5,
          ),
        );
      }),
    );
  }

  Widget gridList(List<Foods> data) {
    return GridView.builder(
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1,
            crossAxisSpacing: 20.0,
            mainAxisSpacing: 2),
        itemBuilder: (context, index) {
          return GridItem(
              item: data[index],
              isSelected: (bool value) {
                setState(() {
                  if (value) {
                    selectedList.add(itemList[index]);
                  } else {
                    selectedList.remove(itemList[index]);
                  }
                });
                print("$index : $value");
              },
              key: Key(itemList[index].rank.toString()));
        });
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

  void datePickerDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 300.0,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Atur Waktu',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    SizedBox(height: 20.0),
//            hourMinute12H(),
                    hourMinute15Interval(),
                    RaisedButton(
                      elevation: 5.0,
                      color: AppColor.pinkHard,
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      padding: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
                      splashColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () {},
                      child: Text(
                        "Atur",
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
//            hourMinuteSecond(),
//            hourMinute12HCustomStyle(),
                    // new Container(
                    //   margin: EdgeInsets.symmetric(vertical: 50),
                    //   child: new Text(
                    //     _dateTime.hour.toString().padLeft(2, '0') +
                    //         ':' +
                    //         _dateTime.minute.toString().padLeft(2, '0') +
                    //         ':' +
                    //         _dateTime.second.toString().padLeft(2, '0'),
                    //     style: TextStyle(
                    //         fontSize: 24, fontWeight: FontWeight.bold),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget hourMinute15Interval() {
    return Card(
      elevation: 2.0,
      child: TimePickerSpinner(
        spacing: 30,
        minutesInterval: 5,
        onTimeChange: (time) {
          setState(() {
            _dateTime = time;
          });
        },
      ),
    );
  }
}

class GridItem extends StatefulWidget {
  final Key key;
  final Foods item;
  final ValueChanged<bool> isSelected;

  GridItem({this.item, this.isSelected, this.key});

  @override
  _GridItemState createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          widget.isSelected(isSelected);
        });
      },
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: Image.network(
              widget.item.photoUrl,
              color: Colors.pink.withOpacity(isSelected ? 0.4 : 0),
              colorBlendMode: BlendMode.color,
            ),
          ),
          isSelected
              ? Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.blue,
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
