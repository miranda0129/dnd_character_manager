import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:dnd_character_manager/models/spell.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class CurrentSpells extends StatefulWidget {
  const CurrentSpells({super.key});

  @override
  State<CurrentSpells> createState() => _CurrentSpellsState();
}

class _CurrentSpellsState extends State<CurrentSpells> {
    final searchField = TextEditingController();
  List spellIndexList = ['minor-illusion', 'fire-bolt', 'shocking-grasp', 'ray-of-frost', 'mending',
  'magic-missile', 'mage-armor', 'feather-fall', 'color-spray'];

  List spellList = ['fire bolt'];
  Map<String, Spell> realSpellList = HashMap();
  List spellSlots = [99, 2];
  int spellSaveDC = 14;
  int spellAttackBonus = 6;
  String spellcastingAbility = 'Rizz';

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Padding(
              padding: const EdgeInsets.all(8.0),

              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text("Spell attack bonus: $spellAttackBonus \n"),
                    Text("Spell save DC: $spellSaveDC \n"),
                    Text("Spellcasting ability: $spellcastingAbility \n"),
                  ].map((widget) => Padding(
                  padding: const EdgeInsets.all(16),
                  child: widget,
                  )).toList(),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('Spellslots: '),
                  Text('\tLevel 1: ${spellSlots[1].toString()}')
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: 
                      realSpellList.entries.map( (spell) => ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        title: Text(spell.value.name), 
                        subtitle: Text('Level: ${
                          spell.value.level == 0 ? 'cantrip' : spell.value.level
                        }'),
                        onTap: () {
                          getSpellDesc(context, spell.value);
                        },
                    )).toList(),
                    )
                ),
              ),
            ),
          ]
        ),
      );
  }

    @override
  void initState() {
    fetchSpells();
    super.initState();
  }

  void castSpell(int level) {
    if (level > 0 && level < spellSlots.length) {
      if (spellSlots[level] == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Not enough magic juice, sry :('))
        );
      } else {
        setState(() {
          spellSlots[level] = spellSlots[level] - 1;
        });
      }
    }
  }


  void getSpellDesc(context, Spell spell) {
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(spell.name),
          content: Text(spell.description),
          actions: [
            TextButton(
              onPressed: () {
                castSpell(spell.level);
                Navigator.of(context).pop();
              }, 
              child: Text('Cast')
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              }, 
              child: Text('Close')
            ),
          ],
        );
      },
    );
  }


  void fetchSpells() async {
    for (String spellIndex in spellIndexList) {
      final response = await http
        .get(Uri.parse('https://www.dnd5eapi.co/api/spells/$spellIndex'));

      final responseJson = jsonDecode(response.body);

      final spellMap = jsonDecode(response.body) as Map<String, dynamic>;
      final classSpell = Spell.fromJson(spellMap);

      if (response.statusCode == 200) {
          setState(() {
            realSpellList.addAll({spellIndex: classSpell});
          });
      } else {
        setState(() {
          print('error');
          realSpellList.addAll({'error getting spell': classSpell});
        });
      }
    }
  }
}