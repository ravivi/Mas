import 'package:Mas/providers/models/GrandResidence.dart';
import 'package:Mas/providers/models/localResidence.dart';
import 'package:url_launcher/url_launcher.dart';

import '../shared/customColor.dart';
import 'package:flutter/material.dart';

class ResidenceItem extends StatelessWidget {
  Residence residence;
  LocalResidence localResidence;
  double height;

  ResidenceItem({this.residence,this.localResidence,this.height});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8,left: 8,bottom: 10),
      child: Card(
        elevation: 4,
        child: Container(
          //height: height / 2,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'search',
                          arguments: residence);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: height / 4,
                      child: FadeInImage.assetNetwork(
                        fadeInCurve: Curves.bounceInOut,
                        fadeInDuration: Duration(seconds: 3),
                        placeholder: 'images/maison.jpg',
                        width: 50,
                        image: "${residence.image}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: -20,
                    child: GestureDetector(
                      onTap: () {
                        print(residence.position);
                        Navigator.pushNamed(context, 'map',
                            arguments: localResidence);
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Chip(
                          avatar: CircleAvatar(
                            backgroundImage: AssetImage('images/local.png'),
                            backgroundColor: Colors.white,
                          ),
                          label: Text(
                            'Voir Localication',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: Colors.white,
                          elevation: 4,
                          shadowColor: Colors.grey[40],
                          padding: EdgeInsets.all(4),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 20, top: 25),
                child: Text(residence.nom,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: CustomColors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      color: CustomColors.skyBlue,
                    ),
                    Text(residence.emplacement,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: CustomColors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        )),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 20, top: 10,bottom: 12),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.call,
                      color: CustomColors.skyBlue,
                    ),
                    GestureDetector(
                      onTap: () async {
                        String telephoneUrl = "tel:${residence.numero}";

                        if (await canLaunch(telephoneUrl)) {
                          await launch(telephoneUrl);
                        } else {
                          throw "Can't phone that number.";
                        }
                      },
                      child: Text(residence.numero,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: CustomColors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
