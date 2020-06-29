import 'package:Mas/providers/models/AllModel.dart';
import 'package:Mas/providers/service/ChambreService.dart';
import 'package:Mas/screens/listTest.dart';
import 'package:Mas/screens/photoViewEx.dart';
import 'package:provider/provider.dart';
import '../shared/customColor.dart';
// import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class ResultItem extends StatefulWidget {
  final Chambres chambre;

  ResultItem({@required this.chambre});

  @override
  _ResultItemState createState() => _ResultItemState();
}

class _ResultItemState extends State<ResultItem> {
  bool isExpended = false;

  @override
  Widget build(BuildContext context) {
    Chambres chambre = widget.chambre;
  
    return Column(
      children: <Widget>[
        // Container(
        //   //Caroussel
        //   height: 200,
        //   alignment: Alignment.center,

        //   child: Carousel(
        //     images: myImages,
        //     animationCurve: Curves.decelerate,
        //     autoplay: false,
        //     autoplayDuration: const Duration(seconds: 4),
        //     animationDuration: const Duration(milliseconds: 3),
        //     dotPosition: DotPosition.bottomCenter,
        //     dotIncreasedColor: CustomColors.skyBlue,
        //     dotColor: Colors.white,
        //     dotVerticalPadding: 10.0,
        //     dotSize: 6.0,
        //     dotSpacing: 20.0,
        //     indicatorBgPadding: 5.0,
        //     dotBgColor: Colors.transparent,
        //     borderRadius: false,
        //   ),
        // ),

        Container(
          height: 170,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: chambre.images.length,
            itemBuilder: (context, i) {
              print(chambre.images[i].image);
              return Container(
                width: MediaQuery.of(context).size.width - 100,
                margin: EdgeInsets.symmetric(horizontal:10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  // child: FadeInImage.assetNetwork(
                  //   fadeInCurve: Curves.bounceInOut,
                  //   fadeInDuration: Duration(seconds: 3),
                  //   placeholder: 'images/maison.jpg',
                  //   width: 50,
                  //   image: "${chambre.images[i].image}",
                  //   fit: BoxFit.cover,
                  // ),
                  child: HeroExample(id: chambre.images[i].id,image: chambre.images[i].image,),
                ),
                // child: Image.network(chambre.images[i].image),
              );
            },
          ),
        ),

        SizedBox(
          height: 5,
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInCubic,
          padding: const EdgeInsets.all(8.0),
          constraints: BoxConstraints(minHeight: isExpended ? 320 : 110),
          height: isExpended ? 300 : 110,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        chambre.categorie.nom,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: '${chambre.prix} Fcfa',
                            style: TextStyle(
                                fontFamily: 'Pacifico',
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 15.0)),
                        TextSpan(
                            text: '/Nuit ',
                            style: TextStyle(
                                fontFamily: 'CenturyGhotic',
                                letterSpacing: 1.8,
                                color: CustomColors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0))
                      ])),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Provider.of<ChambreService>(context, listen: false)
                              .setChambre(chambre);
                          Navigator.pushNamed(context, 'reservation',
                              arguments: chambre);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 100,
                          height: 40,
                          child: Text(
                            "Réserver",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 16),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    CustomColors.skyBlue,
                                    CustomColors.skyBlue.withAlpha(200)
                                  ]),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isExpended = !isExpended;
                          });
                        },
                        child: Row(
                          children: <Widget>[
                            Text("Plus d'info"),
                            Icon(
                              isExpended
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              color: CustomColors.skyBlue,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              isExpended
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Description",
                            style: TextStyle(
                              color: CustomColors.skyBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Text(chambre.description,
                        textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: CustomColors.grey,
                              fontSize: 13,
                            )),
                      ],
                    )
                  : SizedBox()
            ],
          ),
        )
      ],
    );
  }
}
