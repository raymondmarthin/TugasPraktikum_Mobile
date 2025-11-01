import 'package:flutter/material.dart';
import '../helpers/mahasiswa_helper.dart';
import '../models/mahasiswa.dart';
import 'input_mahasiswa_page.dart';
import 'edit_mahasiswa_page.dart';

class ListMahasiswaPage extends StatefulWidget {
  final MahasiswaHelper helper;

  const ListMahasiswaPage({super.key, required this.helper});

  @override
  State<ListMahasiswaPage> createState() => _ListMahasiswaPageState();
}

class _ListMahasiswaPageState extends State<ListMahasiswaPage> {
  @override
  Widget build(BuildContext context) {
    final data = widget.helper.getAll();

    return Scaffold(
      appBar: AppBar(title: const Text('Data Mahasiswa')),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final mhs = data[index];
          return ListTile(
            title: Text(mhs.nama),
            subtitle: Text("${mhs.nim} - ${mhs.jurusan}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditMahasiswaPage(
                          helper: widget.helper,
                          mahasiswa: mhs,
                        ),
                      ),
                    );
                    setState(() {});
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      widget.helper.delete(mhs.id);
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => InputMahasiswaPage(helper: widget.helper),
            ),
          );
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
