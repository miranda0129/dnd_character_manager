import 'package:dnd_character_manager/screens/spellbook/spellbook_widget.dart';
import 'package:flutter/material.dart';
import 'package:dnd_character_manager/screens/magical_items_widget.dart';
import 'package:provider/provider.dart';
import './screens/health_widget.dart';
import 'screens/inventory/inventory_widget.dart';

import 'models/character.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Health'),
            onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => ChangeNotifierProvider(
                create: (BuildContext context) => Character(),
                child: HealthPage())));
            },
          ),
          ListTile(
            leading: Icon(Icons.circle),
            title: Text('Spellbook'),
            onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) =>  SpellbookPage()));
            },
          ),
          ListTile(
          leading: Icon(Icons.backpack),
          title: Text('Inventory'),
          onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => (InventoryPage())));
            },
          ),
          ListTile(
            leading: Icon(Icons.image_search),
            title: Text('Magic Item Lookup'),
            onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => MagicalItemsPage()));
            },
          ),
        ]
      )
    );
  }
}