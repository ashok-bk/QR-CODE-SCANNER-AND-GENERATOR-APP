import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  String qr = "add data";
  final GlobalKey _qrkey = GlobalKey();
  bool dirExists = false;
  dynamic externalDir = '/Storage/emulated/0/Download';

  Future<void> _captureAndSavePng() async {
    try {
      RenderRepaintBoundary boundary =
          _qrkey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 3.0);

      final whitePaint = Paint()..color = Colors.white;
      final recorder = PictureRecorder();
      final canvas = Canvas(recorder,
          Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()));
      canvas.drawRect(
          Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
          whitePaint);
      canvas.drawImage(image, Offset.zero, Paint());
      final picture = recorder.endRecording();
      final img = await picture.toImage(image.width, image.height);
      ByteData? byteData = await img.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      //to check duplicate filename
      String filename = 'qr_code';
      int i = 1;
      while (await File('$externalDir/$filename').exists()) {
        filename = 'qr_code_$i';
        i++;
      }
      //to check if directory path exits or not
      dirExists = await File(externalDir).exists();
      //if not then create
      if (!dirExists) {
        await Directory(externalDir).create(recursive: true);
        dirExists = true;
      }

      final file = await File('$externalDir/$filename.png').create();
      await file.writeAsBytes(pngBytes);

      if (!mounted) return;
      const snackBar = SnackBar(content: Text('QR Code saved!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      if (!mounted) return;
      const snackBar = SnackBar(content: Text('Failed to save'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    var data;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create QR-Code'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BarcodeWidget(
            color: Colors.black,
            height: 250,
            width: 250,
            data: qr,
            barcode: Barcode.qrCode(),
          ),
          Container(
            width: MediaQuery.of(context).size.width * .8,
            child: TextField(
              onChanged: (val) {
                setState(() {
                  qr = val;
                });
              },
              decoration: const InputDecoration(
                  hintText: "Enter your data here",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  )),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
          ),
          // Center(
          //   child: RepaintBoundary(
          //     key: _qrkey,
          //     child: QrImageView(
          //       data: data,
          //       version: QrVersions.auto,
          //       size: 250,
          //       gapless: true,
          //       errorStateBuilder: (ctx,err){
          //         return const Center(
          //           child: Text("Something went wrong",
          //           textAlign: TextAlign.center
          //           ),

          //         );
          //       },

          //     ),
          //   ),
          // ),
          // SizedBox(
          //),
          ElevatedButton(onPressed: () {}, child: const Text("Export"))
        ],
      ),
    );
  }
}
