import 'package:Mas/shared/customColor.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
Widget mDrawer(BuildContext context) {
  return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: Drawer(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              DrawerHeader(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/img3.jpg"),
                          fit: BoxFit.fill,
                          )),
                  child: Container(),),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    // ListTile(
                    //   onTap: () {
                    //     Navigator.pushNamed(context, "checkOut");
                    //   },
                    //   leading: Icon(
                    //     Icons.check_circle_outline,
                    //     color: CustomColors.skyBlue,
                    //     size: 23,
                    //   ),
                    //   title: Text(
                    //     "",
                    //     style: TextStyle(color: Colors.white, fontSize: 16),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // ListTile(
                    //   onTap: () {
                    //     Navigator.pop(context);
                    //     Navigator.pushNamed(context, "favoritePage");
                    //   },
                    //   leading: Icon(
                    //     Icons.shopping_basket,
                    //     color: CustomColors.skyBlue,
                    //     size: 23,
                    //   ),
                    //   title: Text("Articles sauvergadés",
                    //       style: TextStyle(color: Colors.white, fontSize: 16)),
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        launch("https://www.facebook.com/pages/category/Hotel---Lodging/LES-Residences-MAS-656539697845913/",forceSafariVC: false);
                      },
                      leading: CircleAvatar(
                        backgroundImage: AssetImage("images/f.jpg"),
                      ),
                      title: Text("Page Facebook",
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      onTap: () {
                       Navigator.pop(context);
                        launchUrl2(
                            'sales@wmcci.com',
                            "Besoin d'aide",
                            'Bonjour ');
                      },
                      leading: CircleAvatar(
                        backgroundImage: AssetImage("images/g.png"),
                      ),
                      title: Text("Contactez-nous",
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ));
}

void launchUrl2(String toMailId, String subject, String body) {
  var url = 'mailto:$toMailId?subject=$subject&body=$body';
  launch(url);
}
