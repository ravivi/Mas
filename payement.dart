import 'package:Mas/providers/models/ReservationModel.dart';
import 'package:Mas/shared/customColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Payement extends StatefulWidget {
  @override
  _PayementState createState() => _PayementState();
}

class _PayementState extends State<Payement> {
  bool isLoading = true;
  final _key = UniqueKey();
  @override
  Widget build(BuildContext context) {
    int arg = ModalRoute.of(context).settings.arguments;
    print(arg);
    return WillPopScope(
      onWillPop: () => showDialog<bool>(
        context: context,
        builder: (c) => AlertDialog(
          title: Text('Attention'),
          content: Text(
              'Si vous sortez vous ne pourrez plus reserver cette chambre'),
          actions: [
            FlatButton(
              child: Text('Oui'),
              onPressed: () => Navigator.pushNamed(context, 'residence'),
            ),
            FlatButton(
              child: Text('Non'),
              onPressed: () => Navigator.pop(c, false),
            ),
          ],
        ),
      ),
      child: Scaffold(
        //withOverviewMode: false,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: CustomColors.skyBlue,
          leading: Container(),
          centerTitle: true,
          title: Text("Payement"),
        ),
        body: Stack(
          children: <Widget>[
            Positioned.fill(
              child: WebView(
                key: _key,
                initialUrl: 'https://mas.wmcci.com/check/$arg/payment',
                javascriptMode: JavascriptMode.unrestricted,
                onPageFinished: (finish) {
                  setState(() {
                    isLoading = false;
                  });
                },
              ),
            ),
            isLoading
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Center(
                      child: SpinKitFadingCircle(
                        color: CustomColors.skyBlue,
                      ),
                    ),
                  )
                : Container(color: Colors.transparent),
          ],
        ),
      ),
    );
  }
}
