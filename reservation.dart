import 'package:Mas/providers/models/ReservationModel.dart';
import 'package:Mas/providers/service/ChambreService.dart';
import 'package:Mas/providers/service/residenceService.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:provider/provider.dart';

import '../shared/customColor.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class Reservation extends StatefulWidget {
  @override
  _ReservationState createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  Stopwatch stopwatch = new Stopwatch();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _prenomFocus = FocusNode();
  final _nomFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _numeroFocus = FocusNode();
  final _prenomController = TextEditingController();
  final _nomController = TextEditingController();
  final _emailController = TextEditingController();
  final _numeroController = TextEditingController();

  void dispose() {
    _prenomFocus.dispose();
    _nomFocus.dispose();
    _emailFocus.dispose();
    _numeroFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.close,
                        color: CustomColors.grey,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Chambre de Luxe",
                    style: TextStyle(
                        color: CustomColors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            "Attention ! Nous ne pouvons réserver votre chambre que pour",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: CustomColors.red),
                          ),
                        ),
                        Container(height: 80, child: MyCountDown()),
                      ],
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      focusNode: _prenomFocus,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_nomFocus);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Ajoutez un Prénom';
                        }
                        return null;
                      },
                      controller: _prenomController,
                      onSaved: (value) {
                        // _editedRev = ReservationModel(
                        //   email: _editedRev.email,
                        //   nom: _editedRev.nom,
                        //   prenom: value,
                        //   numero: _editedRev.numero,
                        // );
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Prénom",
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white))),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      focusNode: _nomFocus,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_emailFocus);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Ajoutez un nom';
                        }
                        return null;
                      },
                      controller: _nomController,
                      onSaved: (value) {
                        // _editedRev = ReservationModel(
                        //     email: _editedRev.email,
                        //     nom: value,
                        //     prenom: _editedRev.prenom,
                        //     numero: _editedRev.numero,
                        //    );
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Nom",
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white))),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 15,
              ),
              //
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      focusNode: _emailFocus,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_numeroFocus);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Ajoutez un Email';
                        }
                        return null;
                      },
                      controller: _emailController,
                      onSaved: (value) {
                        // _editedRev = ReservationModel(
                        //     email: value,
                        //     nom: _editedRev.nom,
                        //     prenom: _editedRev.prenom,
                        //     numero: _editedRev.numero,
                        //   );
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white))),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      focusNode: _numeroFocus,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Ajoutez un numéro';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        // Provider.of<ChambreService>(context, listen: false)
                        //     .setReservation(
                        //         email: _editedRev.email,
                        //         nom: _editedRev.nom,
                        //         prenom: _editedRev.prenom,
                        //         numero: value);
                        //        _editedRev = ReservationModel(
                        //   email: value,
                        //   nom: _editedRev.nom,
                        //   prenom: _editedRev.prenom,
                        //   numero: _editedRev.numero,
                        // );
                      },
                      controller: _numeroController,
                      onFieldSubmitted: (_) {
                        //_saveForm();
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Numéro",
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white))),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 30,
              ),
              if (_isLoading && (_emailController.text.isNotEmpty &&
                    _prenomController.text.isNotEmpty &&
                    _numeroController.text.isNotEmpty &&
                    _nomController.text.isNotEmpty))
                  Center(
                    child: SpinKitFadingCircle(
                      color: CustomColors.skyBlue,
                    ),
                  )
                else
                  InkWell(
                    onTap: () async {
                      try {
                        setState(() {
                          _isLoading = true;
                        });
                        int id = await Provider.of<ChambreService>(context,
                                listen: false)
                            .setReservation(
                                email: _emailController.text,
                                nom: _nomController.text,
                                prenom: _prenomController.text,
                                numero: _numeroController.text);
                        if (id == -1) {
                          return showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  AssetGiffyDialog(
                                    image: Image.asset(
                                      "images/triste.gif",
                                      fit: BoxFit.cover,
                                    ),
                                    title: Text('Attention Attention!!!',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.w600)),
                                    description: Text(
                                      "Vous ne pouvez plus réservez cette chambre",
                                      textAlign: TextAlign.center,
                                    ),
                                    entryAnimation: EntryAnimation.BOTTOM_RIGHT,
                                    onOkButtonPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    onlyOkButton: true,
                                    buttonOkText: Text(
                                      "Recommencer",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    buttonOkColor:
                                        CustomColors.skyBlue.withOpacity(0.7),
                                  ));
                        }
                        if (id == 0) {
                          return showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  AssetGiffyDialog(
                                    image: Image.asset(
                                      "images/triste.gif",
                                      fit: BoxFit.cover,
                                    ),
                                    title: Text('Attention Attention!!!',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.w600)),
                                    description: Text(
                                      "Une erreur c'est produite pendant la réservation",
                                      textAlign: TextAlign.center,
                                    ),
                                    entryAnimation: EntryAnimation.BOTTOM_RIGHT,
                                    onOkButtonPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    onlyOkButton: true,
                                    buttonOkText: Text(
                                      "Recommencer",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    buttonOkColor:
                                        CustomColors.skyBlue.withOpacity(0.7),
                                  ));
                        }

                        Navigator.pushNamed(context, 'payement', arguments: id);
                      } catch (error) {
                        await showDialog(
                            context: context,
                            builder: (BuildContext context) => AssetGiffyDialog(
                                  image: Image.asset(
                                    "images/triste.gif",
                                    fit: BoxFit.cover,
                                  ),
                                  title: Text('Attention Attention!!!',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.w600)),
                                  description: Text(
                                    "Une erreur c'est produite pendant la réservation",
                                    textAlign: TextAlign.center,
                                  ),
                                  entryAnimation: EntryAnimation.BOTTOM_RIGHT,
                                  onOkButtonPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  onlyOkButton: true,
                                  buttonOkText: Text(
                                    "Recommencer",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  buttonOkColor:
                                      CustomColors.skyBlue.withOpacity(0.7),
                                ));
                      }
                      // _saveForm();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      width: MediaQuery.of(context).size.width,
                      height: 56,
                      child: Text(
                        "Confirmez votre réservation",
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
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyCountDown extends StatefulWidget {
  @override
  MyCountDownState createState() => MyCountDownState();
}

class MyCountDownState extends State<MyCountDown>
    with TickerProviderStateMixin {
  AnimationController controller;

  // bool isPlaying = false;

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(minutes: 10),
    );
    if (controller.isAnimating) {
      controller.stop(canceled: true);
    } else {
      controller.reverse(
          from: controller.value == 0.0 ? 1.0 : controller.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: AnimatedBuilder(
                animation: controller,
                builder: (BuildContext context, Widget child) {
                  return CustomPaint(
                      painter: TimerPainter(
                    animation: controller,
                    backgroundColor: Colors.grey.withOpacity(.3),
                    color: CustomColors.skyBlue,
                  ));
                },
              ),
            ),
            Align(
              alignment: FractionalOffset.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  AnimatedBuilder(
                      animation: controller,
                      builder: (BuildContext context, Widget child) {
                        return Text(
                          timerString,
                          style: TextStyle(fontSize: 15),
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimerPainter extends CustomPainter {
  TimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
