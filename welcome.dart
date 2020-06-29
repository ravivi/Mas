import '../shared/customColor.dart';
import 'package:flutter/material.dart';

import 'package:flutter_page_indicator/flutter_page_indicator.dart';

class Welcome extends StatefulWidget {
  Welcome({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Welcome createState() => new _Welcome();
}

class _Welcome extends State<Welcome> {
  double size = 10.0;
  double activeSize = 10.0;

  PageController controller;

  @override
  void initState() {
    controller = new PageController();
    super.initState();
  }

  @override
  void didUpdateWidget(Welcome oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[
      Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 300,
              height: 250,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                      image: AssetImage("images/img1.jpg"),
                      fit: BoxFit.fill)),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Faites vos Réservation",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Container(
                margin: EdgeInsets.only(top: 20),
                width: 280,
                height: 100,
                child: Text(
                  "Utilisez l'application Mas pour réserver une résidence.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ))
          ],
        ),
      ),
      new Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 300,
              height: 250,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                      image: AssetImage("images/img2.jpg"),
                      fit: BoxFit.fill)),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "De très belle résidence",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Container(
                margin: EdgeInsets.only(top: 20),
                width: 280,
                height: 60,
                child: Text(
                  "Les résidences Mas sont ouvertes 24h/24 et 7j/7 pour vous fait plaisir",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ))
          ],
        ),
      ),
      Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 300,
              height: 250,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                      image: AssetImage("images/img3.jpg"),
                      fit: BoxFit.fill)),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Résidence Meublée",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Container(
                margin: EdgeInsets.only(top: 20),
                width: 280,
                height: 110,
                
                child: Text(
                  "Decouvrez des résidences entièrement meublés, avec les équipements dernier cri",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ))
          ],
        ),
      ),
      Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 300,
              height: 250,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                      image: AssetImage("images/img4.jpg"),
                      fit: BoxFit.fill)),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Passer un sejour de rois",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Container(
                margin: EdgeInsets.only(top: 20),
                width: 280,
                height: 100,
                child: Text(
                  "A passer des moments inoubliables dans nos residences Mas",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ))
          ],
        ),
      )
    ];

    return new Scaffold(
        backgroundColor: Colors.white, body: viewPortrait(children));
  }

  Widget viewPortrait(List<Widget> children) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width,
              child: new Stack(
                children: <Widget>[
                  new PageView(
                    controller: controller,
                    children: children,
                  ),
                  new Align(
                    alignment: Alignment.bottomCenter,
                    child: new Padding(
                      padding: new EdgeInsets.only(bottom: 20.0),
                      child: new PageIndicator(
                        layout: PageIndicatorLayout.DROP,
                        size: size,
                        activeSize: activeSize,
                        controller: controller,
                        space: 5.0,
                        count: 4,
                        color: Colors.grey,
                        activeColor: CustomColors.skyBlue,
                      ),
                    ),
                  )
                ],
              )),
          InkWell(
            onTap: () {
              Navigator.popAndPushNamed(context, 'residence');
            },
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width/2,
              height: 56,
              child: Text(
                "Commencer",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 15),
              ),
              decoration: BoxDecoration(
                  color: Colors.red,
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [CustomColors.skyBlue, CustomColors.skyBlue.withAlpha(200)]),
                  borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ],
      ),
    );
  }
}
