import 'package:fit_app/core/res/app_color.dart';
import 'package:fit_app/models/food_history.dart';
import 'package:fit_app/network/Response.dart';
import 'package:fit_app/view/profile/foodComsumtion/foodHistory/food_history_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FoodHistoryScreen extends StatefulWidget {
  @override
  _FoodHistoryScreenState createState() => _FoodHistoryScreenState();
}

class _FoodHistoryScreenState extends State<FoodHistoryScreen> {
  final _bloc = FoodHistoryBloc();

  @override
  void initState() {
    super.initState();
    _bloc.getTodayHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Konsumsi Makan"),
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: ListView(
          children: <Widget>[
            Text(
              "Catatan hari ini",
              style: TextStyle(
                  color: AppColor.primaryColorFont,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Rekapan harian konsumsi makanan kamu",
              style:
                  TextStyle(color: AppColor.primaryColorFont, fontSize: 12.0),
            ),
            SizedBox(
              height: 30.0,
            ),
            StreamBuilder<Response<FoodHistory>>(
              stream: _bloc.streamFoodHistory,
              initialData: null,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data.status) {
                    case Status.LOADING:
                      // CircularProgressIndicator();
                      break;
                    case Status.SUCCESS:
                      var widgets = List<Widget>();
                      if (snapshot.data.data.data.pagi != null) {
                        widgets.add(
                            cardPagi(snapshot.data.data.data.pagi, "PAGI"));
                        widgets.add(SizedBox(height: 10.0));
                      }
                      if (snapshot.data.data.data.siang != null) {
                        widgets.add(
                            cardPagi(snapshot.data.data.data.siang, "SIANG"));
                        widgets.add(SizedBox(height: 10.0));
                      }
                      if (snapshot.data.data.data.malam != null) {
                        widgets.add(
                            cardPagi(snapshot.data.data.data.malam, "MALAM"));
                        widgets.add(SizedBox(height: 10.0));
                      } else
                        return Container();
                      return Column(
                        children: widgets,
                      );
                      break;
                    case Status.ERROR:
                      return Center(
                        child: Text("Pastikan internetmu stabil"),
                      );
                      break;
                  }
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget cardPagi(List<Malam> morning, String time) {
    return Card(
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "MAKAN $time",
                style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    color: AppColor.pinkHard),
              ),
            ),
            Column(
              children: List.generate(morning.length, (index) {
                return Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10.0,
                    ),
                    content(morning[index]),
                  ],
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  Widget content(Malam items) {
    String formattedDate = DateFormat('kk:mm').format(items.timestamp);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
                height: 50.0,
                width: 50.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    items.img,
                    fit: BoxFit.cover,
                  ),
                )),
            SizedBox(
              width: 40.0,
            ),
            Text(
              "${items.name}",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Spacer(),
        Row(
          children: <Widget>[
            Text("$formattedDate"),
            SizedBox(
              width: 60.0,
            ),
            IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.grey,
                ),
                onPressed: () {
                  _bloc
                      .deleteFood(items.id.toString())
                      .then((value) => _bloc.getTodayHistory());
                })
          ],
        ),
      ],
    );
  }
}
