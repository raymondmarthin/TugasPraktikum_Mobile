import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add_item_page.dart';
import 'edit_item_page.dart';
import 'history_page.dart';

void main() {
  runApp(ShoppingListApp());
}

class ShoppingItem {
  String id;
  String name;
  String note;
  String category; // groceries, drinks, snacks, household, other
  bool bought;
  DateTime createdAt;

  ShoppingItem({
    required this.id,
    required this.name,
    required this.note,
    required this.category,
    required this.bought,
    required this.createdAt,
  });

  factory ShoppingItem.fromJson(Map<String, dynamic> j) => ShoppingItem(
        id: j['id'],
        name: j['name'],
        note: j['note'],
        category: j['category'],
        bought: j['bought'],
        createdAt: DateTime.parse(j['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'note': note,
        'category': category,
        'bought': bought,
        'createdAt': createdAt.toIso8601String(),
      };
}

class ShoppingListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Playful Shopping List',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.orange.shade50,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.orange.shade300,
          foregroundColor: Colors.white,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.orange.shade400,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: ShoppingHomePage(),
    );
  }
}

enum FilterOption { all, bought, unbought }

enum SortOption { newest, oldest }

class ShoppingHomePage extends StatefulWidget {
  @override
  _ShoppingHomePageState createState() => _ShoppingHomePageState();
}

class _ShoppingHomePageState extends State<ShoppingHomePage> {
  List<ShoppingItem> items = [];
  String search = '';
  FilterOption filter = FilterOption.all;
  SortOption sort = SortOption.newest;

  final String storageKey = 'shopping_items_v2';

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(storageKey);
    if (raw != null) {
      final List decoded = jsonDecode(raw);
      setState(() {
        items = decoded.map((e) => ShoppingItem.fromJson(e)).toList();
      });
    }
  }

  Future<void> _saveItems() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(items.map((e) => e.toJson()).toList());
    await prefs.setString(storageKey, encoded);
  }

  void _addItem(ShoppingItem item) {
    setState(() {
      items.add(item);
    });
    _saveItems();
  }

  void _updateItem(ShoppingItem updated) {
    final idx = items.indexWhere((i) => i.id == updated.id);
    if (idx != -1) {
      setState(() {
        items[idx] = updated;
      });
      _saveItems();
    }
  }

  void _removeItem(String id) {
    setState(() {
      items.removeWhere((i) => i.id == id);
    });
    _saveItems();
  }

  void _toggleBought(String id) {
    final idx = items.indexWhere((i) => i.id == id);
    if (idx != -1) {
      setState(() {
        items[idx].bought = !items[idx].bought;
      });
      _saveItems();
    }
  }

  List<ShoppingItem> get filteredItems {
    List<ShoppingItem> result = items.where((i) {
      final q = search.trim().toLowerCase();
      final matchesSearch = q.isEmpty ||
          i.name.toLowerCase().contains(q) ||
          i.note.toLowerCase().contains(q);
      if (!matchesSearch) return false;

      if (filter == FilterOption.all) return true;
      if (filter == FilterOption.bought) return i.bought;
      return !i.bought;
    }).toList();

    result.sort((a, b) {
      if (sort == SortOption.newest) {
        return b.createdAt.compareTo(a.createdAt);
      } else {
        return a.createdAt.compareTo(b.createdAt);
      }
    });

    return result;
  }

  double get progress {
    if (items.isEmpty) return 0;
    final done = items.where((i) => i.bought).length;
    return done / items.length;
  }

  IconData iconForCategory(String cat) {
    switch (cat) {
      case 'groceries':
        return FontAwesomeIcons.appleWhole;
      case 'drinks':
        return FontAwesomeIcons.wineBottle;
      case 'snacks':
        return FontAwesomeIcons.cookie;
      case 'household':
        return FontAwesomeIcons.broom;
      default:
        return FontAwesomeIcons.box;
    }
  }

  Color colorForCategory(String cat) {
    switch (cat) {
      case 'groceries':
        return Colors.green.shade300;
      case 'drinks':
        return Colors.blue.shade300;
      case 'snacks':
        return Colors.brown.shade200;
      case 'household':
        return Colors.purple.shade200;
      default:
        return Colors.grey.shade300;
    }
  }

  @override
  Widget build(BuildContext context) {
    final shown = filteredItems;
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping List — Playful'),
        actions: [
          IconButton(
            tooltip: 'Riwayat Pembelian',
            icon: Icon(FontAwesomeIcons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => HistoryPage(
                    historyItems: items.where((i) => i.bought).toList(),
                  ),
                ),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(96),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Column(
              children: [
                // search field
                TextField(
                  onChanged: (v) => setState(() => search = v),
                  decoration: InputDecoration(
                    hintText: 'Cari barang atau catatan...',
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.orange.shade50,
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                // filter chips + sort + progress
                Row(
                  children: [
                    Expanded(
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: [
                          ChoiceChip(
                            label: Text('Semua'),
                            selected: filter == FilterOption.all,
                            onSelected: (_) =>
                                setState(() => filter = FilterOption.all),
                            selectedColor: Colors.orange.shade200,
                          ),
                          ChoiceChip(
                            label: Text('Belum dibeli'),
                            selected: filter == FilterOption.unbought,
                            onSelected: (_) =>
                                setState(() => filter = FilterOption.unbought),
                            selectedColor: Colors.orange.shade200,
                          ),
                          ChoiceChip(
                            label: Text('Selesai'),
                            selected: filter == FilterOption.bought,
                            onSelected: (_) =>
                                setState(() => filter = FilterOption.bought),
                            selectedColor: Colors.orange.shade200,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8),
                    DropdownButton<SortOption>(
                      value: sort,
                      underline: SizedBox(),
                      items: [
                        DropdownMenuItem(
                          value: SortOption.newest,
                          child: Text('Terbaru'),
                        ),
                        DropdownMenuItem(
                          value: SortOption.oldest,
                          child: Text('Terlama'),
                        ),
                      ],
                      onChanged: (v) {
                        if (v != null) setState(() => sort = v);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // progress
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 10,
                    backgroundColor: Colors.orange.shade100,
                    valueColor: AlwaysStoppedAnimation(Colors.orange.shade400),
                  ),
                ),
                SizedBox(width: 12),
                Text('${(progress * 100).round()}%'),
              ],
            ),
          ),

          // list
          Expanded(
            child: shown.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(FontAwesomeIcons.boxOpen,
                            size: 64, color: Colors.orange.shade200),
                        SizedBox(height: 8),
                        Text(
                          'Tidak ada item',
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                        SizedBox(height: 8),
                        Text('Tekan + untuk menambahkan item belanja'),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    itemCount: shown.length,
                    itemBuilder: (context, index) {
                      final item = shown[index];
                      return Card(
                        margin:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        elevation: 2,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: colorForCategory(item.category),
                            child: Icon(
                              iconForCategory(item.category),
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            item.name,
                            style: TextStyle(
                              decoration: item.bought
                                  ? TextDecoration.lineThrough
                                  : null,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: item.note.isEmpty ? null : Text(item.note),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                tooltip: 'Edit',
                                icon: Icon(FontAwesomeIcons.pen, size: 18),
                                onPressed: () async {
                                  final updated =
                                      await Navigator.push<ShoppingItem>(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => EditItemPage(item: item),
                                    ),
                                  );
                                  if (updated != null) _updateItem(updated);
                                },
                              ),
                              IconButton(
                                tooltip: 'Hapus',
                                icon:
                                    Icon(Icons.delete, color: Colors.redAccent),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: Text('Hapus item?'),
                                      content: Text(
                                          'Yakin ingin menghapus "${item.name}"?'),
                                      actions: [
                                        TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: Text('Batal')),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            _removeItem(item.id);
                                          },
                                          child: Text('Hapus',
                                              style:
                                                  TextStyle(color: Colors.red)),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                tooltip: item.bought
                                    ? 'Tandai belum dibeli'
                                    : 'Tandai sudah dibeli',
                                icon: Icon(
                                  item.bought
                                      ? FontAwesomeIcons.checkCircle
                                      : FontAwesomeIcons.circle,
                                  color: item.bought
                                      ? Colors.green
                                      : Colors.orange.shade400,
                                ),
                                onPressed: () => _toggleBought(item.id),
                              ),
                            ],
                          ),
                          onTap: () => _toggleBought(item.id),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Tambah item belanja',
        child: Icon(FontAwesomeIcons.plus),
        onPressed: () async {
          final newItem = await Navigator.push<ShoppingItem>(
            context,
            MaterialPageRoute(builder: (_) => AddItemPage()),
          );
          if (newItem != null) {
            _addItem(newItem);
          }
        },
      ),
    );
  }
}
