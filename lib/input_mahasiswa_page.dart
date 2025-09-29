import 'package:flutter/material.dart';

class InputMahasiswaPage extends StatefulWidget {
  @override
  State<InputMahasiswaPage> createState() => _InputMahasiswaPageState();
}

class _InputMahasiswaPageState extends State<InputMahasiswaPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _nimController = TextEditingController();
  final _emailController = TextEditingController();
  final _alamatController = TextEditingController();
  final _hpController = TextEditingController();

  String? _jenisKelamin; // untuk dropdown

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Input Mahasiswa")),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Nama
                TextFormField(
                  controller: _namaController,
                  decoration: const InputDecoration(
                    labelText: "Nama",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Nama tidak boleh kosong" : null,
                ),
                const SizedBox(height: 12),

                // NIM
                TextFormField(
                  controller: _nimController,
                  decoration: const InputDecoration(
                    labelText: "NIM",
                    prefixIcon: Icon(Icons.badge),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value!.isEmpty ? "NIM tidak boleh kosong" : null,
                ),
                const SizedBox(height: 12),

                // Email
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email wajib diisi";
                    } else if (!value.endsWith('@unsika.ac.id')) {
                      return "Gunakan email @unsika.ac.id";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // Alamat
                TextFormField(
                  controller: _alamatController,
                  decoration: const InputDecoration(
                    labelText: "Alamat",
                    prefixIcon: Icon(Icons.home),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Alamat tidak boleh kosong" : null,
                ),
                const SizedBox(height: 12),

                // Nomor HP
                TextFormField(
                  controller: _hpController,
                  decoration: const InputDecoration(
                    labelText: "Nomor HP",
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Nomor HP wajib diisi";
                    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return "Nomor HP hanya boleh angka";
                    } else if (value.length < 10) {
                      return "Nomor HP minimal 10 digit";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // Jenis Kelamin (Dropdown)
                DropdownButtonFormField<String>(
                  value: _jenisKelamin,
                  decoration: const InputDecoration(
                    labelText: "Jenis Kelamin",
                    prefixIcon: Icon(Icons.wc),
                    border: OutlineInputBorder(),
                  ),
                  items: ["Laki-laki", "Perempuan"]
                      .map((jk) => DropdownMenuItem(value: jk, child: Text(jk)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _jenisKelamin = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? "Pilih jenis kelamin" : null,
                ),
                const SizedBox(height: 20),

                // Tombol Simpan pakai ElevatedButton.icon
                ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text("Simpan"),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final mahasiswa = {
                        'nama': _namaController.text,
                        'nim': _nimController.text,
                        'email': _emailController.text,
                        'alamat': _alamatController.text,
                        'hp': _hpController.text,
                        'jenisKelamin': _jenisKelamin,
                      };
                      Navigator.pop(context, mahasiswa);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
