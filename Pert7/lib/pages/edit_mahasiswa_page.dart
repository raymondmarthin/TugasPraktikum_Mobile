import 'package:flutter/material.dart';
import '../helpers/mahasiswa_helper.dart';
import '../models/mahasiswa.dart';

class EditMahasiswaPage extends StatefulWidget {
  final MahasiswaHelper helper;
  final Mahasiswa mahasiswa;

  const EditMahasiswaPage({
    super.key,
    required this.helper,
    required this.mahasiswa,
  });

  @override
  State<EditMahasiswaPage> createState() => _EditMahasiswaPageState();
}

class _EditMahasiswaPageState extends State<EditMahasiswaPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _namaController;
  late TextEditingController _nimController;
  late TextEditingController _jurusanController;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.mahasiswa.nama);
    _nimController = TextEditingController(text: widget.mahasiswa.nim);
    _jurusanController = TextEditingController(text: widget.mahasiswa.jurusan);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Mahasiswa')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(labelText: 'Nama'),
              ),
              TextFormField(
                controller: _nimController,
                decoration: const InputDecoration(labelText: 'NIM'),
              ),
              TextFormField(
                controller: _jurusanController,
                decoration: const InputDecoration(labelText: 'Jurusan'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  widget.helper.update(
                    Mahasiswa(
                      id: widget.mahasiswa.id,
                      nama: _namaController.text,
                      nim: _nimController.text,
                      jurusan: _jurusanController.text,
                    ),
                  );
                  Navigator.pop(context);
                },
                child: const Text('Simpan Perubahan'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
