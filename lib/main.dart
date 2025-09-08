import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'input_mahasiswa_page.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 45),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Map<String, dynamic>? mahasiswa;

  Future<void> _callMahasiswa() async {
    if (mahasiswa == null || mahasiswa!['kontak'].isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Nomor tidak tersedia')));
      return;
    }

    String nomor = mahasiswa!['kontak'];
    if (nomor.startsWith('0')) {
      nomor = '+62${nomor.substring(1)}';
    }

    final Uri url = Uri.parse('tel:$nomor');

    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak dapat membuka aplikasi telepon')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Main Page'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
              child: const Text("Ke Profile Page"),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InputMahasiswaPage()),
                );
                if (result != null) {
                  setState(() {
                    mahasiswa = result;
                  });
                }
              },
              child: const Text("Input Data Mahasiswa"),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: mahasiswa == null ? null : _callMahasiswa,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text("Call Mahasiswa"),
            ),
            const SizedBox(height: 24),

            // Card sederhana untuk data
            mahasiswa != null
                ? Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nama: ${mahasiswa!['nama']}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text("Umur: ${mahasiswa!['umur']}"),
                          Text("Alamat: ${mahasiswa!['alamat']}"),
                          Text("Kontak: ${mahasiswa!['kontak']}"),
                        ],
                      ),
                    ),
                  )
                : const Center(
                    child: Text(
                      "Belum ada data mahasiswa",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
