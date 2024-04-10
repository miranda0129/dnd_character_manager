import 'package:flutter/material.dart';
import '../../app_drawer.dart';
import 'gold_widget.dart';
import 'items_widget.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  int currentPageIndex = 0;
  final List<Widget> _children = [ItemsWidget(), ItemsWidget()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Inventory'),
        backgroundColor:Color.fromARGB(77, 14, 199, 51),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GoldWidget(),
            ItemsWidget(),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.bookmark),
            label: 'Inventory',
          ),
          NavigationDestination(
            icon: Icon(Icons.circle),
            label: 'Attunement',
          ),
        ],
      ),
    );
  }
}