import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/character.dart';
import '../app_drawer.dart';


class HealthPage extends StatefulWidget {
  const HealthPage({super.key});

  @override
  State<HealthPage> createState() => _HealthPageState();
}

class _HealthPageState extends State<HealthPage> {
  final healthTextField = TextEditingController();
  

  @override
  void dispose() {
    healthTextField.dispose();
    super.dispose();
  }

  int _parseNumInput() {
    healthTextField.clear();
    return int.parse(healthTextField.text);
  }


  @override
  Widget build(BuildContext context) {
    Character characterModel = context.watch<Character>();
    characterModel.getHealth();

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Health'),
        backgroundColor:Color.fromARGB(77, 14, 199, 51),
      ),
      body: 
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Your health is: ',
            ),
            Text(
              '${characterModel.getCurrentHealth()}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    characterModel.increaseHealth(_parseNumInput());
                  }, 
                  child: const Text('+')
                ),
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: healthTextField,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      hintText: 'damage/health',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed:()
                  {  
                    characterModel.decreaseHealth(_parseNumInput());
                  },
                  child: const Text('-')
                ),
              ].map((widget) => Padding(
            padding: const EdgeInsets.all(8),
            child: widget,
            )).toList(),
            ),
          ]
        ),
      ),
    );
  }
}
