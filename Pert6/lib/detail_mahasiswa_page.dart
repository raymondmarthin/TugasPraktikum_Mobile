import 'package:flutter/material.dart';

class DetailMahasiswaPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const DetailMahasiswaPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Mahasiswa'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.indigo.shade100,
                    child: const Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.indigo,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildItem('Nama', data['nama']),
                _buildItem('NIM', data['nim']),
                _buildItem('Email', data['email']),
                _buildItem('Nomor HP', data['noHp']),
                _buildItem('Jenis Kelamin', data['jenisKelamin']),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: Text(value ?? '-', style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
