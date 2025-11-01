import 'package:flutter/material.dart';
import '../helpers/mahasiswa_helper.dart';
import '../models/mahasiswa.dart';

class InputMahasiswaPage extends StatefulWidget {
  final MahasiswaHelper helper;

  const InputMahasiswaPage({super.key, required this.helper});

  @override
  State<InputMahasiswaPage> createState() => _InputMahasiswaPageState();
}

class _InputMahasiswaPageState extends State<InputMahasiswaPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _nimController = TextEditingController();
  final _jurusanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Mahasiswa')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(labelText: 'Nama'),
                validator: (value) =>
                    value!.isEmpty ? 'Nama wajib diisi' : null,
              ),
              TextFormField(
                controller: _nimController,
                decoration: const InputDecoration(labelText: 'NIM'),
                validator: (value) => value!.isEmpty ? 'NIM wajib diisi' : null,
              ),
              TextFormField(
                controller: _jurusanController,
                decoration: const InputDecoration(labelText: 'Jurusan'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.helper.add(
                      Mahasiswa(
                        id: 0,
                        nama: _namaController.text,
                        nim: _nimController.text,
                        jurusan: _jurusanController.text,
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Simpan'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
