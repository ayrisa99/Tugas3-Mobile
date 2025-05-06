import 'package:flutter/material.dart';
import 'package:tugas3_tpm/pages/anggota.dart';
import 'package:tugas3_tpm/pages/bantuan.dart';
import 'package:tugas3_tpm/pages/fitur/bilangan.dart';
import 'package:tugas3_tpm/pages/fitur/konversi.dart';
import 'package:tugas3_tpm/pages/fitur/rekomendasi.dart';
import 'package:tugas3_tpm/pages/fitur/stopwatch.dart';
import 'package:tugas3_tpm/pages/fitur/tracking_lbs.dart';
import 'package:tugas3_tpm/pages/login.dart';
import 'package:tugas3_tpm/utils/session_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Fungsi untuk menangani perubahan halaman berdasarkan index
  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AnggotaPage()),
      );
    } else if (_selectedIndex == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BantuanPage()),
      );
    }
  }

  String _username = '';

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  void _loadUsername() async {
    final email =
        await SessionManager.getUsername(); // Ambil email dari session
    setState(() {
      _username = email ?? 'User'; // Jika tidak ada email, tampilkan 'User'
    });
  }

  Widget _buildContent() {
    switch (_selectedIndex) {
      case 0:
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Selamat datang, $_username!',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () async {
                      // Hapus session
                      await SessionManager.logout();

                      // Arahkan pengguna kembali ke halaman login
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ), // Ganti dengan halaman login
                      );
                    },
                    child: Image.asset(
                      'assets/icons/logout.png',
                      width: 40,
                      height: 40,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Column(
                children: [
                  // Stopwatch Item
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StopwatchPage(),
                        ),
                      );
                    },
                    child: SettingTile(
                      iconPath: 'assets/icons/stopwatch.png',
                      title: 'Stopwatch',
                      subtitle: 'Lacak waktu dengan akurat',
                    ),
                  ),
                  SizedBox(height: 10),
                  // Bilangan Item
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BilanganPage()),
                      );
                    },
                    child: SettingTile(
                      iconPath: 'assets/icons/bilangan.png',
                      title: 'Jenis Bilangan',
                      subtitle: 'Pelajari dan pahami jenis-jenis bilangan',
                    ),
                  ),
                  SizedBox(height: 10),
                  // Tracking LBS Item
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TrackingLBSSimplePage(),
                        ),
                      );
                    },
                    child: SettingTile(
                      iconPath: 'assets/icons/location.png',
                      title: 'Tracking LBS',
                      subtitle: 'Pantau lokasi secara real-time',
                    ),
                  ),
                  SizedBox(height: 10),
                  // Konversi Waktu Item
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => KonversiWaktuPage(),
                        ),
                      );
                    },
                    child: SettingTile(
                      iconPath: 'assets/icons/waktu.png',
                      title: 'Konversi Waktu',
                      subtitle: 'Ubah satuan waktu dengan mudah',
                    ),
                  ),
                  SizedBox(height: 10),
                  // Rekomendasi Item
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RekomendasiPage(),
                        ),
                      );
                    },
                    child: SettingTile(
                      iconPath: 'assets/icons/rekomendasi.png',
                      title: 'Rekomendasi',
                      subtitle: 'Dapatkan saran yang sesuai untukmu',
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      case 1:
        return Center(
          child: Text('Halaman Anggota', style: TextStyle(fontSize: 20)),
        );
      case 2:
        return Center(
          child: Text('Halaman Bantuan', style: TextStyle(fontSize: 20)),
        );
      default:
        return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _buildContent()),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        selectedItemColor: Color(0xFFFF7F50),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Anggota'),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline),
            label: 'Bantuan',
          ),
        ],
      ),
    );
  }
}

class SettingTile extends StatelessWidget {
  final String iconPath;
  final String title;
  final String subtitle;
  final VoidCallback? onLogout; // Menambahkan callback untuk logout

  const SettingTile({
    super.key,
    required this.iconPath,
    required this.title,
    required this.subtitle,
    this.onLogout, // Menambahkan parameter untuk logout
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Image.asset(iconPath, width: 56, height: 56),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
              ],
            ),
          ),
          Image.asset('assets/icons/back.png', width: 16, height: 16),
        ],
      ),
    );
  }
}
