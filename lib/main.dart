import 'package:fic_flutter_model_shared_pref/counter_shared_pref.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FIC Flutter Shared Pref',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'FIC Flutter Shared Pref'),
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
  int _counter = 0;

  void _getDataCounter() async {
    _counter = await CounterSharedPref().getData();
    setState(() {});
  }

  void _incrementCounter() async {
    await CounterSharedPref().saveData(++_counter);
    _getDataCounter();
  }

  void _decrementCounter() async {
    if (_counter > 0) {
      await CounterSharedPref().saveData(--_counter);
    } else {
      showSnackbar(context, 'Sudah nol gan');
    }
    _getDataCounter();
  }

  void _resetCounter() async {
    await CounterSharedPref().removeData();
    showSnackbar(context, 'Counter di Reset');
    _getDataCounter();
  }

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getDataCounter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[400],
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Counter Value',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 36.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '${_counter}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _decrementCounter();
                  },
                  onLongPress: () {
                    showSnackbar(context, 'tombol untuk mengurangi counter');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    child: Icon(
                      Icons.remove,
                      size: 36,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    _resetCounter();
                  },
                  onLongPress: () {
                    showSnackbar(context, 'tombol untuk mereset counter');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    child: Icon(
                      Icons.settings_backup_restore_rounded,
                      size: 36,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    _incrementCounter();
                  },
                  onLongPress: () {
                    showSnackbar(context, 'tombol untuk menambahkan counter');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    child: Icon(
                      Icons.add,
                      size: 36,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSnackbar(context, 'Tekan lama untuk mengetahui fungsi tombol');
        },
        child: Text(
          '?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 36.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
