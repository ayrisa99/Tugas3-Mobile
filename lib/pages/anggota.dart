import 'package:flutter/material.dart';
import 'package:tugas3_tpm/pages/bantuan.dart';
import 'package:tugas3_tpm/pages/home.dart';
import 'package:tugas3_tpm/pages/login.dart';
import 'package:tugas3_tpm/utils/session_manager.dart';

class AnggotaPage extends StatefulWidget {
  const AnggotaPage({super.key});

  @override
  _AnggotaPageState createState() => _AnggotaPageState();
}

class _AnggotaPageState extends State<AnggotaPage> {
  final int _selectedIndex = 1;

  void _onTabTapped(int index) {
    if (index == _selectedIndex) return;

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BantuanPage()),
      );
    }
  }

  void _logout() {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text("Logout"),
            content: Text("Apakah Anda yakin ingin keluar?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Logika keluar / arahkan ke login
                },
                child: Text("Ya"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Batal"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Text(
                    'Anggota ',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  // GestureDetector(
                  //   onTap: _logout,
                  //   child: Image.asset(
                  //     'assets/icons/logout.png',
                  //     width: 40,
                  //     height: 40,
                  //   ),
                  // ),
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

              // Grid Anggota
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 4,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio:
                        0.68, // Tambahkan ini supaya card tidak terlalu tinggi
                  ),
                  itemBuilder: (context, index) {
                    final anggota =
                        [
                          {
                            'photo': 'assets/images/anu.jpg',
                            'name': 'Anugraha Galih S',
                            'nim': '123220119',
                          },
                          {
                            'photo': 'assets/images/fadhil.jpg',
                            'name': 'Mohammad Fadhil D',
                            'nim': '123220137',
                          },
                          {
                            'photo': 'assets/images/risaa.jpg',
                            'name': 'Ayrisa Trianida',
                            'nim': '123220193',
                          },
                          {
                            'photo': 'assets/images/irishhhh.jpg',
                            'name': 'Gertrud Irish Jovincia',
                            'nim': '123220197',
                          },
                        ][index];

                    return AnggotaCard(
                      photoPath: anggota['photo']!,
                      name: anggota['name']!,
                      nim: anggota['nim']!,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
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

class AnggotaCard extends StatelessWidget {
  final String photoPath;
  final String name;
  final String nim;

  const AnggotaCard({super.key, 
    required this.photoPath,
    required this.name,
    required this.nim,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(radius: 60, backgroundImage: AssetImage(photoPath)),
            SizedBox(height: 12),
            Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              'NIM: $nim',
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
