import 'dart:convert';
import 'dart:math' as math;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:material_kit_flutter/widgets/navbar.dart';
import 'package:material_kit_flutter/widgets/drawer.dart';
import 'package:material_kit_flutter/constants/Theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<Home> {
  String user, imgUrl;
  bool darkmode = false;
  // ignore: non_constant_identifier_names
  int Count = 0;

  _getusername() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      Count += 1;
      user = preferences.getString("Display-Name") ?? "";
      imgUrl = preferences.getString("User-Image-URL") ?? "";
      darkmode = preferences.getBool("Theme-Mode") ?? false;
    });
  }

  _getcolor() {
    return (darkmode) ? Colors.black87 : MaterialColors.bgColorScreen;
  }

  Widget _addDocument(){
    return InkWell(
                        onTap: () => {
                              if (_isprocessing)
                                {}
                              else
                                {_showChoiceDialog(context)}
                            },
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                boxShadow: (darkmode != null)
                                    ? _getshadowcolor()
                                    : <BoxShadow>[
                                        BoxShadow(
                                            color: Colors.grey.shade200,
                                            offset: Offset(2, 4),
                                            blurRadius: 5,
                                            spreadRadius: 2)
                                      ],
                                color: Color.fromARGB(255, 15, 185, 130)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                Text(
                                  'Select Profile Picture',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ],
                            ))),
  }

  @override
  Widget build(BuildContext context) {
    (Count == 0) ? _getusername() : print("Welcome.");
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            appBar: Navbar(
              title: "Home",
              transparent: false,
            ),
            backgroundColor:
                (darkmode != null) ? _getcolor() : MaterialColors.bgColorScreen,
            drawer:
                MaterialDrawer(currentPage: "Home", user: user, imgUrl: imgUrl),
            body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/img/newspaper.png"),
                    fit: BoxFit.contain,
                  ),
                ),
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: Column(children: <Widget>[
                  Text("Hello"),
                  _addDocument(),
                  FlatButton(
                    child: Text(
                      'Generate PDF',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () => {},
                    color: Colors.blue,
                  )
                ]))));
  }
}
