import 'package:flutter/material.dart';
import 'package:tugas3_tpm/pages/fitur/detailRekomendasi.dart';

class RekomendasiPage extends StatelessWidget {
  final List<Map<String, String>> rekomendasiList = [
    {
      'title': 'Flutter',
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/1/17/Google-flutter-logo.png',
      'url': 'https://flutter.dev',
      'description':
          'Framework UI buatan Google untuk membangun aplikasi mobile, web, dan desktop dengan satu basis kode.',
    },
    {
      'title': 'Tutorial Flutter Lengkap',
      'image': 'https://i.ytimg.com/vi/1ukSR1GRtMU/maxresdefault.jpg',
      'url': 'https://www.youtube.com/watch?v=1ukSR1GRtMU',
      'description':
          'Tutorial lengkap untuk mempelajari dasar-dasar Flutter lewat video YouTube.',
    },
    {
      'title': 'Kursus Online Gratis',
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/9/97/Coursera-Logo_600x600.svg/1200px-Coursera-Logo_600x600.svg.png',
      'url': 'https://www.coursera.org',
      'description':
          'Platform pembelajaran online dengan banyak kursus gratis dan berbayar dari universitas ternama.',
    },
    {
      'title': 'GitHub',
      'image':
          'https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png',
      'url': 'https://github.com',
      'description':
          'Platform hosting untuk version control dan kolaborasi dalam pengembangan perangkat lunak.',
    },
    {
      'title': 'W3Schools',
      'image': 'https://www.w3schools.com/images/w3schools_logo_436_2.png',
      'url': 'https://www.w3schools.com',
      'description':
          'Website pembelajaran pemrograman HTML, CSS, JavaScript, dan lainnya.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Situs Rekomendasi'),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: rekomendasiList.length,
        itemBuilder: (context, index) {
          final item = rekomendasiList[index];
          return Card(
            //color: Color(0xFFFF7F50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            margin: EdgeInsets.only(bottom: 16),
            elevation: 4,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => DetailPage(
                          title: item['title']!,
                          image: item['image']!,
                          url: item['url']!,
                          description:
                              item['description'] ?? 'Tidak ada deskripsi',
                        ),
                  ),
                );
              },

              borderRadius: BorderRadius.circular(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (item['image']!.isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: Image.network(
                        item['image']!,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) => Container(
                              height: 180,
                              color: Colors.grey[200],
                              child: Center(child: Icon(Icons.broken_image)),
                            ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title']!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          item['url']!,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
