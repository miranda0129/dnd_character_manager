import 'package:dnd_character_manager/screens/spellbook/search_spells.dart';
import 'package:flutter/material.dart';
import '../../app_drawer.dart';

import 'current_spells.dart';

class SpellbookPage extends StatefulWidget {
  const SpellbookPage({super.key});

  @override
  State<SpellbookPage> createState() => _SpellbookPageState();
}

class _SpellbookPageState extends State<SpellbookPage> {
  int currentPageIndex = 0;
  final List<Widget> _children = [CurrentSpells(), CurrentSpells(), SearchSpells()];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Spellbook'),
      ),
      body: _children[currentPageIndex],
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
            label: 'List',
          ),
          NavigationDestination(
            icon: Icon(Icons.circle),
            label: 'Cast',
          ),
          NavigationDestination(
            icon: Icon(Icons.book_online),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}