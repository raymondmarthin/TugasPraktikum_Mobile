import 'package:flutter/material.dart';
import 'kucing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Kucing kucing1;
  String pesan = '';

  @override
  void initState() {
    super.initState();
    kucing1 = Kucing('Mimi', 4.5, 'Coklat');
    pesan = kucing1.makan(kucing1, 200);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Latihan')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(pesan, style: const TextStyle(fontSize: 20), textAlign: TextAlign.center),
              const SizedBox(height: 12),
              Text('Berat: ${kucing1.berat.toStringAsFixed(2)} kg', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 16),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        pesan = kucing1.makan(kucing1, 1000);
                      });
                    },
                    child: const Text('Makan'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        pesan = kucing1.lari(kucing1, 500);
                      });
                    },
                    child: const Text('Lari'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}