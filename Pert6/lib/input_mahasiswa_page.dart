import 'package:flutter/material.dart';

class InputMahasiswaPage extends StatefulWidget {
  const InputMahasiswaPage({super.key});

  @override
  State<InputMahasiswaPage> createState() => _InputMahasiswaPageState();
}

class _InputMahasiswaPageState extends State<InputMahasiswaPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _nimController = TextEditingController();
  final _emailController = TextEditingController();
  final _noHpController = TextEditingController();
  String? _jenisKelamin;

  void _simpanData() {
    if (_formKey.currentState!.validate()) {
      final dataMahasiswa = {
        'nama': _namaController.text,
        'nim': _nimController.text,
        'email': _emailController.text,
        'noHp': _noHpController.text,
        'jenisKelamin': _jenisKelamin,
      };

      Navigator.pop(context, dataMahasiswa);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Data Mahasiswa'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigo, Colors.blueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        controller: _namaController,
                        decoration: const InputDecoration(
                          labelText: 'Nama Lengkap',
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (v) =>
                            v!.isEmpty ? 'Nama tidak boleh kosong' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _nimController,
                        decoration: const InputDecoration(
                          labelText: 'NIM',
                          prefixIcon: Icon(Icons.badge),
                        ),
                        validator: (v) =>
                            v!.isEmpty ? 'NIM tidak boleh kosong' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email (@unsika.ac.id)',
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: (v) {
                          if (v!.isEmpty) return 'Email tidak boleh kosong';
                          if (!v.endsWith('@unsika.ac.id')) {
                            return 'Gunakan email @unsika.ac.id';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _noHpController,
                        decoration: const InputDecoration(
                          labelText: 'Nomor HP',
                          prefixIcon: Icon(Icons.phone),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (v) {
                          if (v!.isEmpty) return 'Nomor HP tidak boleh kosong';
                          if (!RegExp(r'^[0-9]+$').hasMatch(v)) {
                            return 'Nomor HP hanya angka';
                          }
                          if (v.length < 10) {
                            return 'Nomor HP minimal 10 digit';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: _jenisKelamin,
                        decoration: const InputDecoration(
                          labelText: 'Jenis Kelamin',
                          prefixIcon: Icon(Icons.people),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'Laki-laki',
                            child: Text('Laki-laki'),
                          ),
                          DropdownMenuItem(
                            value: 'Perempuan',
                            child: Text('Perempuan'),
                          ),
                        ],
                        onChanged: (v) => setState(() => _jenisKelamin = v),
                        validator: (v) =>
                            v == null ? 'Pilih jenis kelamin' : null,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: _simpanData,
                        icon: const Icon(Icons.save),
                        label: const Text('Simpan Data'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
