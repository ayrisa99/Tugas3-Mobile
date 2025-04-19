import 'package:flutter/material.dart';
import 'package:tugas3_tpm/pages/anggota.dart';
import 'package:tugas3_tpm/pages/home.dart';
import 'package:tugas3_tpm/pages/login.dart';
import 'package:tugas3_tpm/utils/session_manager.dart';

class BantuanPage extends StatefulWidget {
  const BantuanPage({super.key});

  @override
  _BantuanPageState createState() => _BantuanPageState();
}

class _BantuanPageState extends State<BantuanPage> {
  String _username = '';

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  void _loadUsername() async {
    final email = await SessionManager.getUsername();
    setState(() {
      _username = email ?? 'User';
    });
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
              Row(
                children: [
                  Text(
                    'Bantuan',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () async {
                      await SessionManager.logout();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
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
              Expanded(
                child: ListView(
                  children: [
                    Theme(
                      data: Theme.of(
                        context,
                      ).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        title: Text('Apa kegunaan aplikasi ini?'),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Aplikasi ini dibuat untuk membantu aktivitas seperti menghitung waktu, tracking lokasi, rekomendasi, konversi waktu dan lainnya.',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Theme(
                      data: Theme.of(
                        context,
                      ).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        title: Text(
                          'Bagaimana cara menggunakan fitur Stopwatch?',
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Untuk menggunakan fitur Stopwatch, masuk ke menu Stopwatch melalui beranda. Tekan tombol Start untuk mulai menghitung waktu. Jika ingin menghentikan perhitungan, tekan tombol Stop. Untuk mengulang perhitungan waktu dari awal, tekan tombol Restart. Apabila ingin merekam waktu yang sedang berjalan, tekan tombol berbentuk persegi.',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Theme(
                      data: Theme.of(
                        context,
                      ).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        title: Text(
                          'Bagaimana cara menggunakan fitur Jenis bilangan?',
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Masuk ke bagian jenis bilangan di halaman Home, lalu masukkan angka untuk menampilkan jenis bilangan (Prima, Desimal, Positif/Negatif, Cacah).',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Theme(
                      data: Theme.of(
                        context,
                      ).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        title: Text(
                          'Bagaimana cara menggunakan fitur tracking LBS?',
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Masuk ke bagian tracking LBS di halaman Home, lalu tekan tombol "Lihat Lokasi Saya". Tunggu sejenak, dan aplikasi akan menampilkan data lokasi Anda saat ini.',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Theme(
                      data: Theme.of(
                        context,
                      ).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        title: Text(
                          'Bagaimana cara menggunakan fitur konversi wwaktu?',
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Masuk ke bagian "Konversi Waktu" di halaman Home, lalu masukkan jumlah tahun yang akan dikonversi. Setelah itu, tekan tombol "Konversi", dan aplikasi akan menampilkan hasil konversi dalam satuan jam, menit, dan detik.',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Theme(
                      data: Theme.of(
                        context,
                      ).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        title: Text('Apa itu menu rekomendasi?'),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Menu rekomendasi adalah daftar situs rekomendasi yang dilengkapi gambar dan link.',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // posisi "Bantuan"
        selectedItemColor: Color(0xFFFF7F50),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AnggotaPage()),
            );
          }
        },
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
