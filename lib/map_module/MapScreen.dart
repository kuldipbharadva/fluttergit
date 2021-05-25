import 'dart:async';

import 'package:background_location/background_location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  Position _position = Position(longitude: 0, latitude: 0, timestamp: DateTime.now(), accuracy: 1, altitude: 1, heading: 1, speed: 1, speedAccuracy: 1);

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    startLocationService();
  }

  @override
  void dispose() {
    super.dispose();
    BackgroundLocation.stopLocationService();
  }

  getCurrentLocation() async {
    Position newPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    _position = newPosition;
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(_position.latitude, _position.longitude), zoom: 14)));
    setState(() {
      print("lat :: " + _position.latitude.toString());
      print("long :: " + _position.longitude.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map"),
        centerTitle: true,
        elevation: 0,
      ),
      resizeToAvoidBottomInset: true,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(target: LatLng(_position.latitude ?? 0, _position.longitude ?? 0), zoom: 16),
              onMapCreated: (GoogleMapController controller){
                _controller.complete(controller);
              },
            ),
          ),
        ],
      ),
    );
  }

  /* this is location service which get location even app in background */
  startLocationService() async {
    BackgroundLocation.setAndroidNotification(
      title: "Flutter Concept",
      message: "Notification message",
      // icon: "@mipmap/ic_launcher",
    );
    await BackgroundLocation.setAndroidConfiguration(1000);
    await BackgroundLocation.startLocationService();
    BackgroundLocation.startLocationService(distanceFilter : 100);
    BackgroundLocation.getLocationUpdates((location) {
      print("background location lat :: ${location.latitude}");
      print("background location long :: ${location.longitude}");
    });
  }
}
