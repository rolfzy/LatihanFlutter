import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageExample extends StatefulWidget {
  @override
  _LocalStorageExampleState createState() => _LocalStorageExampleState();
}

class _LocalStorageExampleState extends State<LocalStorageExample> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  Future<void> _loadCounter() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      _counter = pref.getInt('counter') ?? 0;
    });
  }

  Future<void> _inceremetCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter++;
      prefs.setInt('counter', _counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('contoh Lokal Storage')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Tombol ini telah ditekan sebanyak'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _inceremetCounter,
        tooltip: "Incerement",
        child: Icon(Icons.add),
      ),
    );
  }
}
