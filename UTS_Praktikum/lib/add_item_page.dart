import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'main.dart';
import 'package:uuid/uuid.dart';

class AddItemPage extends StatefulWidget {
  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _noteCtrl = TextEditingController();
  String category = 'groceries';

  final uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Item Belanja'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: InputDecoration(
                  labelText: 'Nama Item',
                  prefixIcon: Icon(Icons.shopping_bag),
                  filled: true,
                  fillColor: Colors.orange.shade50,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Nama tidak boleh kosong'
                    : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _noteCtrl,
                decoration: InputDecoration(
                  labelText: 'Catatan (opsional)',
                  prefixIcon: Icon(Icons.note),
                  filled: true,
                  fillColor: Colors.orange.shade50,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Text('Kategori: ',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  SizedBox(width: 8),
                  DropdownButton<String>(
                    value: category,
                    items: [
                      DropdownMenuItem(
                          value: 'groceries',
                          child: _catRow(FontAwesomeIcons.appleWhole, 'Bahan')),
                      DropdownMenuItem(
                          value: 'drinks',
                          child:
                              _catRow(FontAwesomeIcons.wineBottle, 'Minuman')),
                      DropdownMenuItem(
                          value: 'snacks',
                          child: _catRow(FontAwesomeIcons.cookie, 'Camilan')),
                      DropdownMenuItem(
                          value: 'household',
                          child: _catRow(FontAwesomeIcons.broom, 'Rumah')),
                      DropdownMenuItem(
                          value: 'other',
                          child: _catRow(FontAwesomeIcons.box, 'Lainnya')),
                    ],
                    onChanged: (v) => setState(() => category = v ?? 'other'),
                  ),
                ],
              ),
              Spacer(),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(FontAwesomeIcons.plus),
                      label: Text('Tambah'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange.shade400,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final item = ShoppingItem(
                            id: uuid.v4(),
                            name: _nameCtrl.text.trim(),
                            note: _noteCtrl.text.trim(),
                            category: category,
                            bought: false,
                            createdAt: DateTime.now(),
                          );
                          Navigator.pop(context, item);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _catRow(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 16),
        SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}
