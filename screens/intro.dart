import '../shared/customColor.dart';
import 'package:flutter/material.dart';

class IntroView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage("images/img1.jpg"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(.3), BlendMode.darken)
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Etes vous prêt?",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width/1.3,
              padding: EdgeInsets.all(8),
                child: Text(
              "A passer des moments inoubliables dans nos residences Mas",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 17),
            )),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.popAndPushNamed(context, 'residence');
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 30),
                width: MediaQuery.of(context).size.width,
                height: 56,
                child: Text(
                  "Commencer",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 20),
                ),
                decoration: BoxDecoration(
                    color: Colors.red,
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          CustomColors.skyBlue,
                          CustomColors.skyBlue.withAlpha(200)
                        ]),
                    borderRadius: BorderRadius.circular(30)),
              ),
            ),
            
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
