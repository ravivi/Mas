

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/service/residenceService.dart';
import 'providers/service/ChambreService.dart';
import 'screens/testSearch.dart';
import 'screens/validate.dart';

import 'screens/splash.dart';
import 'screens/reservation.dart';
import 'screens/map.dart';
import 'screens/residence.dart';
import 'screens/resultPage.dart';
import 'screens/search.dart';
import 'screens/testRes.dart';
import 'shared/customColor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);
    SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white, // navigation bar color
    statusBarColor: CustomColors.skyBlue, // status bar color
  ));
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ResidenceProv()),
        ChangeNotifierProvider.value(value: ChambreService()),
      ],
          child: MaterialApp(
        title: 'Les Résidences Mas',
        debugShowCheckedModeBanner: false,
        
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
          
        ),
       home: Splash(),
      // home: TestSearch(),
      //home: Map(),
        routes: {
          'residence':(context)=>Residence(),
          'map':(context)=>Map(),
          'search':(context)=>SearchPage(),
          'resultPage':(context)=>ResultPage(),
          'reservation':(context)=>Reservation(),
          'validate':(context)=>Validate()
        },
      ),
    );
  }
}
