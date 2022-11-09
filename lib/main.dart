import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bluetooth Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String bluetoothState = 'ligado';
  static const platform = MethodChannel('bluetooth.channel.com/status');

  _androidComunication() async {
    try {
      bluetoothState =
          await platform.invokeMethod('isBluetoothSuported').then((value) {
        setState(() {
          bluetoothState = value;
        });
      });
    } catch (e) {
      return Exception('Não foi possível se conectar');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth $bluetoothState'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _androidComunication(),
        tooltip: 'Increment',
        child: const Icon(Icons.bluetooth),
      ),
      body: Center(
        child: Column(),
      ),
    );
  }
}
