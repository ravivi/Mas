import 'package:Mas/shared/customColor.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  GoogleMapController mapController;

  final LatLng _center = const LatLng(5.3972043, -3.9879177);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Set<Marker> markers = Set();

// Create a new marker

// Add it to Set

  @override
  Widget build(BuildContext context) {
    var arg= ModalRoute.of(context).settings.arguments as String;
      Marker resultMarker = Marker(
      markerId: MarkerId("Residence Mas"),
      infoWindow: InfoWindow(title: "Residence Mas", snippet: "Residence Mas"),
      position: LatLng(5.3972043, -3.9879177));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: CustomColors.skyBlue,
          iconTheme: IconThemeData(color: Colors.white),
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
        body: GoogleMap(
          markers: {resultMarker},
          onMapCreated: _onMapCreated,
          zoomControlsEnabled: true,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      ),
    );
  }
}
