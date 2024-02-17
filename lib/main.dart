import 'package:dnd_character_manager/screens/inventory_widget.dart';
import 'package:dnd_character_manager/screens/spellbook_widget.dart';
import 'package:flutter/material.dart';
import './screens/health_widget.dart';
import './screens/ki_widget.dart';
import './screens/magical_items_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 101, 114, 105)),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blueGrey),
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
        return DefaultTabController(
          length: 5,
          child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.favorite)),
                Tab(icon: Icon(Icons.circle)),
                Tab(icon: Icon(Icons.backpack)),
                Tab(icon:Icon(Icons.book)),
                Tab(icon: Icon(Icons.info),)
              ]),
              title: const Text('Orion Nells'),
            ),
            body: const TabBarView(
              children: [
                HealthPage(),
                KiPage(),
                InventoryPage(),
                SpellbookWidget(),
                MagicalItemsPage(),
              ],
            )
          ),
        );
      }
    );
  }
}
