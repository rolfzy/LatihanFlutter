import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statemanajemen/counter_model.dart';
import 'package:statemanajemen/login_form.dart';
import 'package:statemanajemen/networking_example.dart';
import 'package:statemanajemen/todo_app.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Counter(), // Membuat instance dari Counter
      child: MaterialApp(
        title: 'Flutter Provider Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TodoApp()
        // NetworkingExample(),
        // MyHomePage(title: 'Flutter Provider Demo Home Page'),
      ),

    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(title),
      ),

      // body: LoginForm()
      // Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       Text('You have pushed the button this many times:'),
      //       CountDisplay(),
      //     ],
      //   ),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Provider.of<Counter>(context, listen: false).increment();
      //   },
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }
//
//
// }

class CountDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Counter>(
      builder: (context, counter, child) {
        return Text(
          '${counter.count}',
          style: Theme.of(context).textTheme.headlineMedium,
        );
      },
    );
  }
}
