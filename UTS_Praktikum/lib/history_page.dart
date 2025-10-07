import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'main.dart';

class HistoryPage extends StatelessWidget {
  final List<ShoppingItem> historyItems;
  const HistoryPage({required this.historyItems});

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Pembelian'),
      ),
      body: historyItems.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(FontAwesomeIcons.clockRotateLeft,
                      size: 60, color: Colors.orange.shade200),
                  SizedBox(height: 8),
                  Text('Belum ada riwayat pembelian'),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 8),
              itemCount: historyItems.length,
              itemBuilder: (context, index) {
                final item = historyItems[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  color: Colors.orange.shade50,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: colorForCategory(item.category),
                      child: Icon(iconForCategory(item.category),
                          size: 18, color: Colors.white),
                    ),
                    title: Text(item.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (item.note.isNotEmpty) Text(item.note),
                        SizedBox(height: 4),
                        Text(
                            'Tanggal: ${item.createdAt.toLocal().toString().split('.').first}'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
