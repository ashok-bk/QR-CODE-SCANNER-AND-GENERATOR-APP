import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  late double height, width;
  String qr = "Click on below button ";
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text('Scanner')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            qr,
            style: const TextStyle(color: Colors.black, fontSize: 30),
          ),
          ElevatedButton(
            onPressed: scanQR, 
            child: const Text("Scan QR-Code")
            ),
            SizedBox(width: width,)
        ],
      ),
    );
  }

  Future<void> scanQR() async {
    try {
      FlutterBarcodeScanner.scanBarcode("#2A99CF", "cancel", true, ScanMode.QR)
          .then((value) {
        setState(() {
          qr = value;
        });
      });
    } 
    catch (e) {
      setState(() {
        qr = "Error Occured! Try Again.";
      });
    }
  }
}
