import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'main.dart';

class EditItemPage extends StatefulWidget {
  final ShoppingItem item;
  const EditItemPage({required this.item});

  @override
  _EditItemPageState createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameCtrl;
  late TextEditingController _noteCtrl;
  late String category;
  late bool bought;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.item.name);
    _noteCtrl = TextEditingController(text: widget.item.note);
    category = widget.item.category;
    bought = widget.item.bought;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Item'),
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
                  Spacer(),
                  Row(
                    children: [
                      Text('Sudah dibeli'),
                      Switch(
                          value: bought,
                          onChanged: (v) => setState(() => bought = v)),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(FontAwesomeIcons.save),
                      label: Text('Simpan Perubahan'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange.shade400,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final updated = ShoppingItem(
                            id: widget.item.id,
                            name: _nameCtrl.text.trim(),
                            note: _noteCtrl.text.trim(),
                            category: category,
                            bought: bought,
                            createdAt: widget.item.createdAt,
                          );
                          Navigator.pop(context, updated);
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
