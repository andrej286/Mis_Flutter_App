import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../provider/exam_provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late Position _currentPosition;
  List<Marker> allMarkers = [];

  _getCurrentLocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void initState() {
    super.initState();
    final examProvider = Provider.of<ExamProvider>(context, listen: false);

    _getCurrentLocation();

    examProvider.exams.forEach((exam) {
      allMarkers.add(Marker(
        point: LatLng(exam.subjectLatitude!, exam.subjectLongitude!),
        builder: (context) => const Icon(
          Icons.location_pin,
          color: Colors.blue,
          size: 50,
        ),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OpenStreetMap Example',
      home: Scaffold(
        body: FlutterMap(
          options: MapOptions(
            // center: LatLng(_currentPosition.latitude, _currentPosition.longitude),
            center: LatLng(42.004274, 21.408719),
            zoom: 15.0,
          ),
          children: [
            TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayer(markers: allMarkers),
          ],
        ),
      ),
    );
  }
}
