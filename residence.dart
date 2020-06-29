import 'dart:async';

import 'package:Mas/providers/models/localResidence.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

import '../main.dart';
import '../providers/service/residenceService.dart';
import 'package:provider/provider.dart';

import '../providers/models/residenceModel.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../widget/residenceItem.dart';

import '../widget/mainDrawer.dart';

import '../shared/customColor.dart';
import 'package:flutter/material.dart';

class Residence extends StatefulWidget {
  @override
  _ResidenceState createState() => _ResidenceState();
}

class _ResidenceState extends State<Residence> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool _isInit = true;
  bool _isLoaded = false;
  // You can put any thing you like, like refetching posts or data from internet
  Future<void> _handleRefresh() {
    final Completer<void> completer = Completer<void>();

    Timer(const Duration(seconds: 3), () {
      completer.complete();
    });

    return completer.future.then<void>((_) {
      scaffoldKey.currentState?.showSnackBar(SnackBar(
          content: const Text('Refresh complete'),
          action: SnackBarAction(
              label: 'RETRY',
              onPressed: () {
                _refreshIndicatorKey.currentState.show();
              })));
    });
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoaded = true;
      });
      Provider.of<ResidenceProv>(context, listen: false)
          .getResidence()
          .then((_) {
        setState(() {
          _isLoaded = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

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

  @override
  Widget build(BuildContext context) {
    final loadedRes = Provider.of<ResidenceProv>(context, listen: false);
    var height = MediaQuery.of(context).size.height - AppBar().preferredSize.height;
    //print(isOffline);
    print(height);
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CustomColors.skyBlue,
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
            icon: Icon(
              Icons.sort,
              color: Colors.white,
            ),
            onPressed: () {
              scaffoldKey.currentState.openDrawer();
            }),
        title: Text(
          "Les Résidences Mas",
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: mDrawer(context),
      body: isOffline
          ? afficheInfo()
          : _isLoaded
              ? Center(
                  child: SpinKitChasingDots(
                    color: CustomColors.skyBlue,
                  ),
                )
              : loadedRes.loadResidence.length == 0
                  ? errorList()
                  : Container(
                    height: height,
                    child: ListView.builder(
                      itemCount: loadedRes.loadResidence.length,
                      itemBuilder: (context, i) {
                        print(
                            loadedRes.loadResidence[i].position.runtimeType);
                        return ResidenceItem(
                          residence: loadedRes.loadResidence[i],
                          localResidence: localResidence[i],
                          height: height,
                        );
                      },
                    ),
                  ),
    );
  }

  errorList() {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(
            child: Image.asset("images/triste.gif"),
          ),
          GestureDetector(
            onTap: () {},
            child: Text(
                "Un problème est survenu",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                )),
          ),
        ],
      ),
    );
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
}
