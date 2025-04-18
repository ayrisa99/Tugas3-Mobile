import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class TrackingLBSSimplePage extends StatefulWidget {
  @override
  _TrackingLBSSimplePageState createState() => _TrackingLBSSimplePageState();
}

class _TrackingLBSSimplePageState extends State<TrackingLBSSimplePage> {
  String _locationMessage = 'Belum ada lokasi';

  // 🟠 TARUH FUNGSI INI DI SINI
  Future<void> _getLocation() async {
    try {
      print("Memeriksa layanan lokasi...");
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _locationMessage = 'GPS belum diaktifkan.';
        });
        return;
      }

      print("Memeriksa izin lokasi...");
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        setState(() {
          _locationMessage = 'Izin lokasi ditolak.';
        });
        return;
      }

      print("Mengambil lokasi...");
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 5),
      );

      setState(() {
        _locationMessage =
            'Lokasi Anda:\nLat: ${position.latitude}, Lng: ${position.longitude}';
      });

      print("Lokasi berhasil: $_locationMessage");
    } catch (e) {
      setState(() {
        _locationMessage = 'Gagal mengambil lokasi: $e';
      });
      print("Error lokasi: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tracking Lokasi'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _getLocation, // ⬅️ TOMBOL MANGGIL FUNGSINYA
              child: Text('Lihat Lokasi Saya'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF7F50),
                foregroundColor: Colors.white,
                minimumSize: Size.fromHeight(50),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              _locationMessage,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
