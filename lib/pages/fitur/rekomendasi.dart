import 'package:flutter/material.dart';
import 'detailRekomendasi.dart'; // Pastikan path sesuai dengan lokasi file DetailPage kamu

class RekomendasiPage extends StatefulWidget {
  const RekomendasiPage({super.key});

  @override
  State<RekomendasiPage> createState() => _RekomendasiPageState();
}

class _RekomendasiPageState extends State<RekomendasiPage> {
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

  late List<bool> likedStatus;
  bool showOnlyFavorites = false;

  @override
  void initState() {
    super.initState();
    likedStatus = List.filled(rekomendasiList.length, false);
  }

  @override
  Widget build(BuildContext context) {
    final displayedIndexes =
        List.generate(
          rekomendasiList.length,
          (i) => i,
        ).where((i) => !showOnlyFavorites || likedStatus[i]).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(showOnlyFavorites ? 'Favorite' : 'Situs Rekomendasi'),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              showOnlyFavorites ? Icons.favorite : Icons.favorite_border,
              color: showOnlyFavorites ? Colors.red : Colors.grey,
            ),
            onPressed: () {
              setState(() {
                showOnlyFavorites = !showOnlyFavorites;
              });
            },
            tooltip: 'Tampilkan Favorite',
          ),
        ],
      ),
      body:
          displayedIndexes.isEmpty
              ? Center(
                child: Text(
                  showOnlyFavorites
                      ? 'Belum ada yang kamu like'
                      : 'Tidak ada data',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
              : ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: displayedIndexes.length,
                itemBuilder: (context, index) {
                  final realIndex = displayedIndexes[index];
                  final item = rekomendasiList[realIndex];
                  final isLiked = likedStatus[realIndex];

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    margin: EdgeInsets.only(bottom: 16),
                    elevation: 4,
                    child: InkWell(
                      onTap: () async {
                        final result = await Navigator.push<bool>(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => DetailPage(
                                  title: item['title']!,
                                  image: item['image']!,
                                  url: item['url']!,
                                  description: item['description']!,
                                  initialIsLiked: isLiked,
                                ),
                          ),
                        );

                        if (result != null) {
                          setState(() {
                            likedStatus[realIndex] = result;
                            // Jangan reset showOnlyFavorites supaya tetap di mode sebelumnya
                          });
                        }
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
                                      child: Center(
                                        child: Icon(Icons.broken_image),
                                      ),
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
