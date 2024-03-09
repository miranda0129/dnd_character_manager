import 'package:dnd_character_manager/screens/magical_items_widget.dart';
import 'package:dnd_character_manager/screens/spellbook_widget.dart';
import 'package:flutter/material.dart';
import './screens/health_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'dnd',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Character Health Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                ListTile(title: Text('Inventory')),
                ListTile(
                  title: Text('Magic Item Lookup'),
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => MagicalItemsPage()));
                  },
                ),
              ]
            )
          ),
          appBar: AppBar(
            backgroundColor: Color.fromARGB(77, 14, 199, 51),
            title: const Text('Lilli Nim Warryn'),
          ),
          body: 
            SpellbookPage(),

          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, 
                MaterialPageRoute(builder: (context) => HealthPage())
              );
            },
            backgroundColor: Color.fromARGB(77, 14, 199, 51),
            child: const Icon(Icons.favorite),
          ),
        );
      }
    );
  }
}
