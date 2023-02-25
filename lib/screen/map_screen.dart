import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  late Position _currentPosition;
  List<Marker> allMarkers = [];

  _getAddress() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      print ("The address is ${place.street}");

      print("Vnatre vo _getAddress so place = ${p}");
    } catch (e) {
      print(e);
    }
  }

  _getCurrentLocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        _currentPosition = position;
      });
      await _getAddress();
    }).catchError((e) {
      print(e);
    });
    print("Vnatre vo _getCurrentLocation");
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    allMarkers.add(Marker(point: LatLng(42.004274, 21.408719), builder: (context) => const Icon(
      Icons.location_pin,
      color: Colors.blue,
      size: 12,
    ),));
    print("Vnatre vo init state");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OpenStreetMap Example',
      home: Scaffold(
        body: FlutterMap(
          options: MapOptions(
            center: LatLng(42.004274, 21.408719),
            zoom: 15.0,
          ),
          children: [
            TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayer(
                markers: allMarkers),
          ],
        ),
      ),
    );
  }
}
