import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MagicalItemsPage extends StatefulWidget {
  const MagicalItemsPage({super.key});

  @override
  State<MagicalItemsPage> createState() => _MagicalItemsPageState();
}

class _MagicalItemsPageState extends State<MagicalItemsPage> {
  final searchField = TextEditingController();
  String name = '';
  String index = '';
  String url = '';
  String errorMessage = '';
  List description = [];
  List itemList = [];

  String parseInput() {
    return searchField.text.toLowerCase().replaceAll(" ", "-");
  }

  void fetchMagicItem() async {
    String item = parseInput();
    final response = await http
      .get(Uri.parse('https://www.dnd5eapi.co/api/magic-items/$item'));
    final responseJson = jsonDecode(response.body);


      if (item != "" && response.statusCode == 200) {
        setState(() {
          name = responseJson['name'];
          index = responseJson['index'];
          url = responseJson['url'];
          description = responseJson['desc'];
        });
      } else if (item == "" && response.statusCode == 200) {
        setState(() {
          itemList = responseJson['results'];
        });
      } else {
        setState(() {
          errorMessage = 'Error getting item';
        });
      }

  }

  @override
  void dispose() {
    searchField.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Widget getMagicItemWidget() {
    // if (errorMessage.isNotEmpty) {
    //   return Column(
    //     children: [
    //       Text(errorMessage),
    //     ],
    //   );
    // } else if (itemList.isNotEmpty) {
    //   return Column(
    //     children: [
    //       ListView.builder(
    //       padding: const EdgeInsets.all(8),
    //       itemCount: itemList.length,
    //       itemBuilder: (BuildContext context, int index) {
    //         return Container(
    //           height: 50,
    //           color: Colors.amber,
    //           child: Center(child: Text('Entry ${itemList[index].toString()}')),
    //         );
    //           }
    //         ),
    //     ],
    //   );
    // } else {
      return Column(
        children: [
          Text(name),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(description.toString().replaceAll("[", "").replaceAll("]", "")),
          ),
        ],
      );
    //}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Magical Items Page'),
        backgroundColor:Color.fromARGB(77, 14, 199, 51),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Magical Items Page',
            ),
            SizedBox(
              width: 400,
              child: TextField(
                controller: searchField,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Search for magical item',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                fetchMagicItem();
              },
              child: const Text('Seach')
            ),
            getMagicItemWidget(),
          ].map((widget) => Padding(
            padding: const EdgeInsets.all(8),
            child: widget,
            )).toList(),
        ),
      ),
    );
  }
}