import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EmergencyMap extends StatefulWidget {
  @override
  _EmergencyMapState createState() => _EmergencyMapState();
}

class _EmergencyMapState extends State<EmergencyMap> {
  Completer<GoogleMapController> _controller = Completer();

  Position _position;
  PolylinePoints polylinePoints;
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};
  bool done = false;

  _createPolylines(Position start, Position destination) async {
    // Initializing PolylinePoints
    polylinePoints = PolylinePoints();

    // Generating the list of coordinates to be used for
    // drawing the polylines
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyDMSXQmnfsN46zorGRNlb0HA89S5_jnRKg', // Google Maps API Key
      PointLatLng(start.latitude, start.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.transit,
    );

    // Adding the coordinates to the list
    if (result.points.isNotEmpty) {
      print('############Results: ${result.points}');
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    // Defining an ID
    PolylineId id = PolylineId('poly');

    // Initializing Polyline
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );

    // Adding the polyline to the map
    polylines[id] = polyline;
  }

  _getCurrentLocation() async {
    _position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final GoogleMapController controller = await _controller.future;
    startMarker = Marker(
      markerId: MarkerId('myLocation'),
      position: LatLng(_position.latitude, _position.longitude),
      infoWindow: InfoWindow(
        title: 'Aberle Abner',
        snippet: 'Female  |  5m 1s, 240 m | Black Hair, tall',
      ),
      icon: BitmapDescriptor.defaultMarker,
    );

    destinationMarker = Marker(
      markerId: MarkerId('destinationCoordinates'),
      position: LatLng(_position.latitude + 0.001, _position.longitude + 0.001),
      infoWindow: InfoWindow(
        title: 'Mason Garcia',
        snippet: 'Female  |  5m 1s, 240 m | View Details',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    );
    _createPolylines(
        _position,
        Position(
            latitude: _position.latitude + 0.001,
            longitude: _position.longitude + 0.001));

    setState(() {
      markers.addAll({startMarker, destinationMarker});
      done = true;
    });

    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(_position.latitude, _position.longitude),
      zoom: 19.151926040649414,
      // tilt: 59.440717697143555,
    )));
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Set<Marker> markers = {};

  Marker startMarker;
  Marker destinationMarker;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        markers: markers,
        polylines: Set<Polyline>.of(polylines.values),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(target: LatLng(0, 0)),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
