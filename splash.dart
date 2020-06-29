import 'dart:async';

import 'package:Mas/shared/customColor.dart';

import '../main.dart';
import '../screens/residence.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> {
    StreamSubscription _connectionChangeStream;

  bool isOffline = false;

  @override
  initState() {
    super.initState();

    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    _connectionChangeStream =
        connectionStatus.connectionChange.listen(connectionChanged);
  }

  void connectionChanged(dynamic hasConnection) {
    setState(() {
      isOffline = !hasConnection;
    });
  }

  Future checkFirstSeen() async {
    var result = await Connectivity().checkConnectivity();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (result != ConnectivityResult.none) {
      if (_seen) {
        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (context) => Residence()));
      } else {
        await prefs.setBool('seen', true);
        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (context) => Welcome()));
      }
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.wifi,
                    size: 200,
                  ),
                  Text("verifiez votre connexion"),
                ],
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    checkFirstSeen();
                  },
                  child: Text("Reessayer"),
                ),
              ],
            );
          });
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    Timer(Duration(seconds: 3), () {
      checkFirstSeen();
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image.asset(
                "images/logoMas.png",
                height: 150,
              ),
            ),
            Center(
              child: SpinKitFadingCircle(
                color: CustomColors.skyBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
