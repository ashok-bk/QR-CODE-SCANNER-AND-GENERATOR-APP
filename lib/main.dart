import 'package:barscan/Screens/create_qr.dart';
import 'package:barscan/Screens/scan_qr.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR-CODE',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'QR-CODE SCANNER'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                print("Tap on create QR button");
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => const CreateScreen(),
                ));
              },
              child: const Text("Create QR"),
            ),
            ElevatedButton(
              onPressed: () {
                print("Tap on scan QR button");
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => const ScanScreen(),
                ));
              },
              child: const Text("Scan QR"),
            ),
          ],
        ),
      ),
    );
  }
}
