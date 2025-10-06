import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Berita Hari Ini',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blueAccent),
      home: const BeritaPage(),
    );
  }
}

class BeritaPage extends StatelessWidget {
  const BeritaPage({super.key});

  final List<Map<String, String>> beritaList = const [
    {
      'judul': 'Teknologi AI Semakin Berkembang',
      'deskripsi':
          'Kecerdasan buatan kini banyak digunakan di berbagai bidang industri, termasuk kesehatan dan pendidikan.',
      'gambar':
          'https://images.unsplash.com/photo-1677442136019-21780ecad995?auto=format&fit=crop&w=800&q=80',
      'isi':
          'Perkembangan teknologi AI (Artificial Intelligence) kini semakin pesat. Mulai dari otomasi industri, analisis data, hingga asisten digital di perangkat pribadi. Para ahli memperkirakan bahwa di masa depan, AI akan menjadi bagian penting dalam kehidupan sehari-hari.',
    },
    {
      'judul': 'Flutter 4.0 Resmi Dirilis',
      'deskripsi':
          'Framework populer ini kini hadir dengan performa lebih cepat dan dukungan multiplatform yang lebih stabil.',
      'gambar':
          'https://images.unsplash.com/photo-1633356122544-f134324a6cee?auto=format&fit=crop&w=800&q=80',
      'isi':
          'Flutter versi terbaru menghadirkan peningkatan performa dan kestabilan di berbagai platform. Kini pengembang dapat membuat aplikasi mobile, web, desktop, dan bahkan embedded dengan basis kode yang sama.',
    },
    {
      'judul': 'E-Sports Jadi Cabang Resmi SEA Games',
      'deskripsi':
          'Kompetisi gim kini diakui sebagai olahraga resmi di Asia Tenggara dan menarik perhatian kaum muda.',
      'gambar':
          'https://images.unsplash.com/photo-1606112219348-204d7d8b94ee?auto=format&fit=crop&w=800&q=80',
      'isi':
          'SEA Games kini telah menambahkan E-Sports sebagai cabang olahraga resmi. Hal ini menunjukkan pengakuan besar terhadap industri gim yang berkembang pesat di Asia Tenggara. Berbagai negara telah menyiapkan tim profesional untuk berkompetisi.',
    },
    {
      'judul': 'Inovasi Mobil Listrik Terbaru',
      'deskripsi':
          'Perusahaan otomotif berlomba-lomba menghadirkan model mobil listrik dengan daya tempuh lebih jauh.',
      'gambar':
          'https://images.unsplash.com/photo-1616486338812-3dadae4b4ace?auto=format&fit=crop&w=800&q=80',
      'isi':
          'Mobil listrik kini semakin diminati masyarakat dunia. Produsen otomotif berlomba-lomba menciptakan baterai dengan kapasitas besar dan efisiensi tinggi. Pemerintah juga mendukung dengan insentif untuk mempercepat transisi menuju kendaraan ramah lingkungan.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Berita Hari Ini 📰',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: beritaList.length,
        itemBuilder: (context, index) {
          final berita = beritaList[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Mengalihkan ke halaman berita...'),
                    duration: Duration(seconds: 1),
                  ),
                );
                Future.delayed(const Duration(seconds: 1), () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 500),
                      pageBuilder: (_, __, ___) =>
                          DetailBeritaPage(berita: berita),
                      transitionsBuilder: (_, animation, __, child) =>
                          FadeTransition(opacity: animation, child: child),
                    ),
                  );
                });
              },
              child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    berita['gambar']!,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[300],
                      width: 70,
                      height: 70,
                      child: const Icon(Icons.broken_image, color: Colors.grey),
                    ),
                  ),
                ),
                title: Text(
                  berita['judul']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    berita['deskripsi']!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ),
                trailing: const Icon(Icons.bookmark_border),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DetailBeritaPage extends StatelessWidget {
  final Map<String, String> berita;

  const DetailBeritaPage({super.key, required this.berita});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(berita['judul']!),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                berita['gambar']!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[300],
                  height: 200,
                  child: const Icon(Icons.broken_image, size: 80),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              berita['judul']!,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              berita['isi']!,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
