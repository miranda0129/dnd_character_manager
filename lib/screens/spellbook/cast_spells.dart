import 'package:dnd_character_manager/models/spell_slots.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SpellCasting extends StatefulWidget {
  const SpellCasting({super.key});

  @override
  State<SpellCasting> createState() => _SpellCastingState();
}

class _SpellCastingState extends State<SpellCasting> {

  void _castSpell(int level) {
    Provider.of<SpellSlots>(context, listen: false).castSpell(level);
  }

  @override
  Widget build(BuildContext context) {
    var _spellSlots = context.watch<SpellSlots>().currentSlots;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [ 
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: _spellSlots.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Divider();
                }             
                return ListTile(
                  title: index == 0 ? Text('Cantrip') : Text('Level $index Spell'),
                  subtitle: index == 0 ? Text(''): Text('remaining: ${_spellSlots[index]}'),
                  onTap: () {
                    if (index > 0 && _spellSlots[index] <= 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Not enough magic juice, sry :('))
                      );
                    } else {
                      _castSpell(index);
                    }
                  },      
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}