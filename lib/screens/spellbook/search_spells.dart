import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class SearchSpells extends StatefulWidget {
  SearchSpells({super.key});

  @override
  State<SearchSpells> createState() => _SearchSpellsState();
}

class _SearchSpellsState extends State<SearchSpells> {
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

    void fetchSpell() async {
    String item = parseInput();
    final response = await http
      .get(Uri.parse('https://www.dnd5eapi.co/api/spells/$item'));
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

  Widget getSpellCardWidget() {
    return Column(
      children: [
        Text(name),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(description.toString().replaceAll("[", "").replaceAll("]", "")),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(      
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: searchField,
          ),
          ElevatedButton(
            onPressed: () {
              fetchSpell();
              print('searching for spell...');
            },
            child: Text('Search'),
          ),
          getSpellCardWidget(),
        ],
      ),
    );
  }
}