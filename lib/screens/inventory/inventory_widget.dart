import 'package:dnd_character_manager/screens/inventory/gold_widget.dart';
import 'package:dnd_character_manager/service/firestore_service.dart';
import 'package:dnd_character_manager/service/inventory_service.dart';
import 'package:flutter/material.dart';
import '../../app_drawer.dart';
import 'items_widget.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  int currentPageIndex = 0;
  TextEditingController addItemName = TextEditingController();
  TextEditingController addItemQuantity = TextEditingController();
  TextEditingController editItemQuantity = TextEditingController();
  final InventoryService _inventoryService = InventoryService();
  Map<String, dynamic> inventory = {};
  List<String> keys = [];

   @override
   void initState() {
     getInventory();
     super.initState();
    }

  Future<void> getInventory() async {
    //keys = inventory.keys.toList();
    print('here is your inventory');
    return await _inventoryService.readInventory().then( (response) {
      setState(() {
        inventory = response;
        keys = inventory.keys.toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Inventory'),
        backgroundColor:Color.fromARGB(77, 14, 199, 51),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //GoldWidget(),
          
          Expanded(
            child: ListView.builder(
              itemCount: inventory.length,
              itemBuilder: (context, index) {
                String key = keys[index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    color: Colors.red,                    
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(
                        Icons.delete_forever,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onDismissed: (_) {
                    setState(() {
                      _inventoryService.delete(keys[index]);
                      inventory.remove(keys[index]);
                      keys = inventory.keys.toList();
                    });
                  },
                  child: ListTile(
                    title: Text(key),
                    subtitle: Text('Quantity: ${inventory[key].toString()}'),
                    onTap: () => _editItemDialog(context, key, inventory[key].toString()),
                  ),
                ); 
              },
            ),
          ),
          //ItemsWidget(),
        ],
      ),
      floatingActionButton: 
        FloatingActionButton(
          onPressed: () {
            print ("Add item");
            _addItemDialog(context);
          },
          child: Icon(Icons.add),
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

  void _addItemDialog(context) {
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextField(
                controller: addItemName,
                decoration: InputDecoration(
                  labelText: 'Name'
                ),
              ),
              TextField(
                controller: addItemQuantity,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Quantity'
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                    inventory[addItemName.text] = addItemQuantity.text;
                    keys = inventory.keys.toList();
                  });
                _inventoryService.update(addItemName.text, int.parse(addItemQuantity.text));
                Navigator.of(context).pop();
              }, 
              child: Text('Save')
            ),
          ],
        );
      },
    );
  }

  void _editItemDialog(context, String currentName, String currentQuantity) {
    editItemQuantity.text = currentQuantity.toString();
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                currentName
              ),
              TextField(
                controller: editItemQuantity,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Quantity'
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                    inventory[currentName] = editItemQuantity.text;
                  });
                _inventoryService.update(currentName, int.parse(editItemQuantity.text));
                Navigator.of(context).pop();
              }, 
              child: Text('Save')
            ),
          ],
        );
      },
    );
  }
}