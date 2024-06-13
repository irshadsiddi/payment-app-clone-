import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class QRCodeScannerApp extends StatefulWidget {
  @override
  _QRCodeScannerAppState createState() => _QRCodeScannerAppState();
}

class _QRCodeScannerAppState extends State<QRCodeScannerApp> {
  QRViewController? _controller;
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

  Future<void> _requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(), // Apply dark theme
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'QR Code Scanner',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              flex: 5,
              child: QRView(
                key: _qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: Color.fromARGB(255, 96, 0, 113),
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: 300,
                ),
              ),
            ),
            const Expanded(
              flex: 1,
              child: Center(
                child: Text('Scan a QR code'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      _controller = controller;
    });

    _controller?.scannedDataStream.listen((scanData) {
      print('Scanned data: ${scanData.code}');
    });
  }
}
