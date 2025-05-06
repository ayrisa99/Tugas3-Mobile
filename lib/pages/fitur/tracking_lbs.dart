import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class TrackingLBSSimplePage extends StatefulWidget {
  const TrackingLBSSimplePage({super.key});

  @override
  State<TrackingLBSSimplePage> createState() => _TrackingLBSSimplePageState();
}

class _TrackingLBSSimplePageState extends State<TrackingLBSSimplePage> {
  LatLng? _currentPosition;
  bool _isTracking = false;

  Future<void> _getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("GPS belum diaktifkan")));
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Izin lokasi ditolak")));
      return;
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });
  }

  void _startTracking() {
    setState(() => _isTracking = true);
    _getLocation();
  }

  void _stopTracking() {
    setState(() {
      _isTracking = false;
      _currentPosition = null; // Hapus posisi agar map tidak tampil
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tracking Lokasi'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Tombol Start dan Stop
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _isTracking ? null : _startTracking,
                  icon: Icon(Icons.play_arrow),
                  label: Text("Start"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _isTracking ? _stopTracking : null,
                  icon: Icon(Icons.stop),
                  label: Text("Stop"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Peta
            Container(
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child:
                  _currentPosition == null
                      ? Center(child: Text('Belum ada lokasi'))
                      : FlutterMap(
                        options: MapOptions(
                          center: _currentPosition,
                          zoom: 16.0,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                            subdomains: ['a', 'b', 'c'],
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                point: _currentPosition!,
                                width: 60,
                                height: 60,
                                builder:
                                    (ctx) => Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                      size: 40,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
            ),

            SizedBox(height: 20),

            // Informasi koordinat
            if (_currentPosition != null)
              Column(
                children: [
                  Text("Latitude: ${_currentPosition!.latitude}"),
                  Text("Longitude: ${_currentPosition!.longitude}"),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
