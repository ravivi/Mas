import 'package:Mas/shared/customColor.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Widget mDrawer(BuildContext context) {
  return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: Drawer(
        elevation: 0,
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("images/logoMas.png"),
                  fit: BoxFit.fill,
                )),
                child: Container(),
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[        
                    ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        launch(
                            "https://www.facebook.com/pages/category/Hotel---Lodging/LES-Residences-MAS-656539697845913/",
                            forceSafariVC: false);
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
                        launch('https://residencemas.wmcci.com/',
                            forceSafariVC: false);
                      },
                      leading: CircleAvatar(
                        backgroundImage: AssetImage("images/site.png"),
                      ),
                      title: Text("Site web",
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        launchUrl2(
                            'sales@wmcci.com', "Besoin d'aide", 'Bonjour ');
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
               ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        launch(
                          "https://www.wmcci.com/",
                            forceSafariVC: false);
                      },
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 15,
                        backgroundImage: AssetImage("images/loader.png"),
                      ),
                      title: Text("Une application réalisée par WMC",
                          style: TextStyle(color: Colors.black, fontSize: 10)),
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
