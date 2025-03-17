import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:track_my_staff/services/location_service.dart';
import 'package:track_my_staff/theme.dart';

class LocationAdmin extends StatefulWidget {
  const LocationAdmin({super.key});

  @override
  _LocationAdminState createState() => _LocationAdminState();
}

class _LocationAdminState extends State<LocationAdmin> {
  List<Marker> _markers = [];
  Position? position;
  LatLng _initialPosition = LatLng(22.43084210462857, 70.78524000774604);
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _fetchLocations();

    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      _fetchLocations();
    });
  }

  Future<void> _fetchLocations() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    if(position != null)
    _initialPosition = LatLng(position!.latitude, position!.longitude);

    List<Map<String, dynamic>>? locations =
    await LocationService.getLocations();

    if (locations != null) {
      setState(() {
        _markers = locations.map((loc) {
          return Marker(
            point: LatLng(loc['latitude'], loc['longitude']),
            width: 80,
            height: 55,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: kSecondaryColor,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 4),
                    ],
                  ),
                  child: Text(
                    loc['userName'] ?? 'Unknown',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Icon(Icons.location_history, color: kPrimaryColor, size: 30),
              ],
            ),
          );
        }).toList();
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: _initialPosition!,
        initialZoom: 12.90,
      ),
      children: [
        TileLayer(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayer(markers: _markers),
      ],
    );
  }
}
