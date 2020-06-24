import 'package:Mas/providers/models/ReservationModel.dart';
import 'package:Mas/providers/service/ChambreService.dart';
import 'package:Mas/providers/service/residenceService.dart';
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
  final _formKey = GlobalKey<FormState>();
  final _prenomFocus = FocusNode();
  final _nomFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _numeroFocus = FocusNode();
  final _numeroController = TextEditingController();

  var _isInit = true;
  var _initLoaded = false;
  var _editedRev = ReservationModel(
      email: '',
      nom: '',
      prenom: '',
      numero: '');

  void dispose() {
    _prenomFocus.dispose();
    _nomFocus.dispose();
    _emailFocus.dispose();
    _numeroFocus.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _initLoaded = true;
    });

    try {
      await Provider.of<ResidenceProv>(context, listen: false)
          .addReservation(_editedRev);
    } catch (error) {
      await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Une Erreur"),
              content: Text("Il s'est produit une erreur"),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Ok"),
                )
              ],
            );
          });
    } finally {
      setState(() {
        _initLoaded = true;
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CustomColors.skyBlue,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Reservation",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(.2), BlendMode.darken),
              image: AssetImage("images/img6.jpg"),
              fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Card(
                    elevation: 4,
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
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text("Utilisateur",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: CustomColors.skyBlue)),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          color: Colors.white54,
                          border:
                              Border.all(color: CustomColors.grey, width: .5)),
                      width: MediaQuery.of(context).size.width,
                      height: 50,
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
                        onSaved: (value) {
                          _editedRev = ReservationModel(
                              email: _editedRev.email,
                              nom: _editedRev.nom,
                              prenom: value,
                              numero: _editedRev.numero,
                              debut: DateTime.now(),
                              fin: DateTime.now());
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Prénom",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white))),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          color: Colors.white54,
                          border:
                              Border.all(color: CustomColors.grey, width: .5)),
                      width: MediaQuery.of(context).size.width,
                      height: 50,
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
                        onSaved: (value) {
                          _editedRev = ReservationModel(
                              email: _editedRev.email,
                              nom: value,
                              prenom: _editedRev.prenom,
                              numero: _editedRev.numero,
                              debut: DateTime.now(),
                              fin: DateTime.now());
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Nom",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white))),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text("Email",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: CustomColors.skyBlue)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          color: Colors.white54,
                          border:
                              Border.all(color: CustomColors.grey, width: .5)),
                      width: MediaQuery.of(context).size.width,
                      height: 50,
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
                        onSaved: (value) {
                          _editedRev = ReservationModel(
                              email: value,
                              nom: _editedRev.nom,
                              prenom: _editedRev.prenom,
                              numero: _editedRev.numero,
                              debut: DateTime.now(),
                              fin: DateTime.now());
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Email",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white))),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text("Numéro de Paiement",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: CustomColors.skyBlue)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          color: Colors.white54,
                          border:
                              Border.all(color: CustomColors.grey, width: .5)),
                      width: MediaQuery.of(context).size.width,
                      height: 50,
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
                          Provider.of<ChambreService>(context, listen: false).setReservation(
                            email: _editedRev.email,
                              nom: _editedRev.nom,
                              prenom: _editedRev.prenom,
                              numero: value
                          );
                        },
                            controller: _numeroController,

                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Numéro",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white))),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        // Navigator.pushNamed(context, 'validate');
                        _saveForm();
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
              ],
            ),
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
