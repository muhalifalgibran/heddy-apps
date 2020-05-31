import 'package:fit_app/core/res/app_color.dart';
import 'package:fit_app/core/utils/formUtils.dart';
import 'package:fit_app/view/auth/registration/dialogs/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:native_color/native_color.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  int _selectedIndex = 1;

  List<IconData> _icons = [
    FontAwesomeIcons.sadTear,
    FontAwesomeIcons.meh,
    FontAwesomeIcons.smile,
    FontAwesomeIcons.laughBeam,
  ];

  List<String> _header = [
    'Tidak Beraktifitas',
    'Lumayan Aktif',
    'Aktif',
    'Sangat Aktif'
  ];
  List<String> _captions = [
    'Aktivitas harian biasa',
    'Aktivitas harian biasa dan aktivitas sedang selama 30-60 menit (misalnya, berjalan dengan kecepatan 5-7km/jam)',
    'Aktivitas harian biasa plus paling sedikit 50 menit aktivitas sedang harian',
    'Aktivitas harian biasa plus paling sedikti 60 menit akitvitas sedang harian dan 60 menit aktivitas berat. Atau tambahkan 120 menit aktivitas sedang ke aktivitas harian Anda. '
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SafeArea(
          child: Stack(
        children: <Widget>[
          Container(color: HexColor('2E3D68'), child: background(context)),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(
              children: formRegist(),
            ),
          )
        ],
      )),
    );
  }

  Widget appBar() {
    return AppBar(
      title: Text(
        'Profil Saya',
        style: TextStyle(color: Colors.white),
      ),
      automaticallyImplyLeading: true,
    );
  }

  Widget nameSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Lengkapi data dirimu di bawah ini, ya",
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          "Jadilah lebih sehat dengan XXXX !",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 14.0, color: Colors.white),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          "Nama Lengkap",
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ],
    );
  }

  Widget background(context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: ClipPath(
        clipper: ClippingClass(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: AppColor.primaryColor),
        ),
      ),
    );
  }

  List<Widget> formRegist() {
    return [
      nameSection(),
      TextFormField(
        style: TextStyle(color: Colors.white, decorationColor: Colors.white),
        decoration: InputDecoration(
          hintText: 'Cth. Alif Gibran',
          hintStyle: TextStyle(color: Colors.white),
        ),
        validator: (String value) {
          return value.contains('@') ? 'Do not use the @ char.' : null;
        },
      ),
      SizedBox(
        height: 20.0,
      ),
      informasiPengguna(context),
      SizedBox(
        height: 20.0,
      ),
      Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FormUtils1.buildField(
                "Jenis Kelamin",
                onPressed: () {
                  ModalBS.bottomSheetBB(context);
                },
              ),
              FormUtils1.buildField(
                "Tanggal Lahir",
                onPressed: () {
                  ModalBS.bottomSheetBB(context);
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FormUtils1.buildField(
                "Tinggi Badan",
                onPressed: () {
                  ModalBS.bottomSheetBB(context);
                },
              ),
              FormUtils1.buildField(
                "Berat Badan",
                onPressed: () {
                  ModalBS.bottomSheetBB(context);
                },
              ),
            ],
          ),
        ],
      ),
      SizedBox(
        height: 20.0,
      ),
      levelAktifitas(context),
      SizedBox(
        height: 20.0,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _icons
            .asMap()
            .entries
            .map(
              (MapEntry map) => _buildIcon(map.key),
            )
            .toList(),
      ),
      SizedBox(
        height: 20.0,
      ),
      _buildCaption(_selectedIndex),
      SizedBox(
        height: 50.0,
      ),
      FlatButton(
        color: Colors.white,
        textColor: AppColor.primaryColor,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        padding: EdgeInsets.all(8.0),
        splashColor: Colors.blueAccent,
        onPressed: () {
          /*...*/
        },
        child: Text(
          "Simpan Profil",
          style: TextStyle(fontSize: 16.0),
        ),
      )
    ];
  }

  Widget _buildIcon(int index) {
    return GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        child: Container(
          height: 60.0,
          width: 60.0,
          decoration: BoxDecoration(
            color: _selectedIndex == index
                ? Theme.of(context).accentColor
                : Color(0xFFE7EBEE),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Icon(
            _icons[index],
            size: 25.0,
            color: _selectedIndex == index
                ? Theme.of(context).primaryColor
                : Color(0xFFB4C1C4),
          ),
        ));
  }

  Widget _buildCaption(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Column(
        children: <Widget>[
          Text(
            _header[index],
            style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 12.0,
          ),
          Text(
            _captions[index],
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.normal),
          )
        ],
      ),
    );
  }
}

Widget informasiPengguna(context) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    children: <Widget>[
      Text(
        'Informasi Pengguna',
        style: TextStyle(
            color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        width: 8.0,
      ),
      SizedBox(
        height: 1.0,
        width: 240.0,
        child: Container(
          width: double.infinity,
          color: Colors.white,
        ),
      )
    ],
  );
}

Widget levelAktifitas(context) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    children: <Widget>[
      Text(
        'Level Aktifitas',
        style: TextStyle(
            color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        width: 8.0,
      ),
      SizedBox(
        height: 1.0,
        width: 280.0,
        child: Container(
          width: double.infinity,
          color: Colors.white,
        ),
      )
    ],
  );
}

class ClippingClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, 120.0);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
