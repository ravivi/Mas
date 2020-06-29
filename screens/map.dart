import 'package:Mas/providers/models/localResidence.dart';
import 'package:Mas/shared/customColor.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapLocation extends StatefulWidget {
  @override
  _MapLocationState createState() => _MapLocationState();
}

class _MapLocationState extends State<MapLocation> {
  GoogleMapController mapController;

  final LatLng _center = const LatLng(5.3972043, -3.9879177);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  MapType _defaultMapType = MapType.terrain;
  Set<Marker> markers = Set();

// Create a new marker

// Add it to Set
  void _changeMapType() {
    setState(() {
      _defaultMapType = _defaultMapType == MapType.terrain
          ? MapType.hybrid
          : MapType.terrain;
    });
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context).settings.arguments as LocalResidence;
    print(arg.lat);
    final LatLng _center = LatLng(arg.lat, arg.lng);
    Marker resultMarker = Marker(
        markerId: MarkerId(arg.nom),
        infoWindow: InfoWindow(title: arg.nom, snippet: arg.nom),
        position: LatLng(arg.lat, arg.lng));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: CustomColors.skyBlue,
          iconTheme: IconThemeData(color: Colors.white),
          leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Row(
            children: <Widget>[
              Text(
                "Localisez-nous",
                style: TextStyle(color: Colors.white),
              ),
              Icon(Icons.location_on, color: Colors.white),
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              markers: {resultMarker},
              onMapCreated: _onMapCreated,
              zoomControlsEnabled: true,
              mapType: _defaultMapType,
              initialCameraPosition: CameraPosition(
                target: _center,
                bearing: 270,
                tilt: 59.440,
                zoom: 14.0,
              ),
            ),
            Container(
              
              alignment: Alignment.topRight,
              child: Column(
                children: <Widget>[
                  FloatingActionButton(
                    mini: true,
                      child: Icon(Icons.layers),
                      elevation: 5,
                      backgroundColor: CustomColors.skyBlue,
                      onPressed: () {
                        _changeMapType();
                        print('Changing the Map Type');
                      }),
                ],
              ),
            ),
          ],
        ),
        //    floatingActionButton: FloatingActionButton.extended(
        //   onPressed: _goToTheLake,
        //   label: Text('To the lake!'),
        //   icon: Icon(Icons.directions_boat),
        // ),
      ),
    );
  }
}
