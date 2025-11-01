import 'package:flutter/material.dart';
import 'input_mahasiswa_page.dart';
import 'detail_mahasiswa_page.dart';

class DaftarMahasiswaPage extends StatefulWidget {
  const DaftarMahasiswaPage({super.key});

  @override
  State<DaftarMahasiswaPage> createState() => _DaftarMahasiswaPageState();
}

class _DaftarMahasiswaPageState extends State<DaftarMahasiswaPage> {
  List<Map<String, dynamic>> dataMahasiswa = [];

  void _tambahMahasiswa() async {
    final hasil = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const InputMahasiswaPage()),
    );

    if (hasil != null && hasil is Map<String, dynamic>) {
      setState(() {
        dataMahasiswa.add(hasil);
      });
    }
  }

  void _lihatDetail(Map<String, dynamic> data) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailMahasiswaPage(data: data)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      appBar: AppBar(title: const Text('Daftar Mahasiswa'), centerTitle: true),
      body: dataMahasiswa.isEmpty
          ? const Center(
              child: Text(
                'Belum ada data mahasiswa.\nTekan tombol + untuk menambah.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: dataMahasiswa.length,
              itemBuilder: (context, index) {
                final mhs = dataMahasiswa[index];
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.indigo.shade100,
                      child: const Icon(Icons.person, color: Colors.indigo),
                    ),
                    title: Text(mhs['nama'] ?? 'Tanpa Nama'),
                    subtitle: Text(mhs['nim'] ?? '-'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                    onTap: () => _lihatDetail(mhs),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _tambahMahasiswa,
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add),
      ),
    );
  }
}
