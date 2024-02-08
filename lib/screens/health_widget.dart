import 'package:flutter/material.dart';

class HealthPage extends StatefulWidget {
  const HealthPage({super.key});

  @override
  State<HealthPage> createState() => _HealthPageState();
}

class _HealthPageState extends State<HealthPage> with AutomaticKeepAliveClientMixin<HealthPage>{
  int health = 114;
  final healthTextField = TextEditingController();
  int healthDelta = 0;

  @override
  void dispose() {
    healthTextField.dispose();
    super.dispose();
  }

  void _increaseHealth() {
    setState(() {
      health += healthDelta;
    });
  }

  void _decreaseHealth() {
    setState(() {
      health -= healthDelta;
    });
  }

  void _parseNumInput() {
    setState(() {
      healthDelta = int.parse(healthTextField.text);
      healthTextField.clear();
    });
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Your health is: ',
              ),
              Text(
                '$health',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _parseNumInput();
                      _increaseHealth();
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
                        hintText: 'Enter health modification',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed:()
                     {
                      _parseNumInput();
                      _decreaseHealth();
                     },
                    child: const Text('-')
                  ),
                ].map((widget) => Padding(
              padding: const EdgeInsets.all(16),
              child: widget,
              )).toList(),
              ),
            ]
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
