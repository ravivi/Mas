import 'dart:async';

import 'package:Mas/providers/models/AllModel.dart';
import 'package:Mas/providers/service/ChambreService.dart';
import 'package:Mas/widget/resultItem.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../shared/customColor.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
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

  afficheInfo() {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(
              child: Image.asset(
            "images/wifi.gif",
            fit: BoxFit.cover,
          )),
          Text("Assurez vous d'avoir une connexion internet",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CustomColors.skyBlue,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Nos chambres disponibles",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: isOffline
          ? afficheInfo()
          : FutureBuilder<List<Chambres>>(
              future: Provider.of<ChambreService>(context).fetchAvailable(),
              builder: (context, snapshot) {
                ConnectionState state = snapshot.connectionState;

                if (snapshot.hasData) {
                  print(snapshot.data);
                  if (snapshot.data.length == 0) {
                    return Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset("images/triste.gif"),
                          Text(
                            "Aucune chambre n'est disponible dans ce intervalle de temps",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return ResultItem(chambre: snapshot.data[index]);
                      });
                }

                if (state == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitChasingDots(
                      color: CustomColors.skyBlue,
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset("images/triste.gif"),
                          Text(
                            "Une Erreur est survenue",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    );
                }
              }),
    );
  }
}
