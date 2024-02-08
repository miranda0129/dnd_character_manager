import 'package:flutter/material.dart';

class KiPage extends StatefulWidget {
  const KiPage({super.key});

  @override
  State<KiPage> createState() => _KiPageState();
}

class _KiPageState extends State<KiPage> with AutomaticKeepAliveClientMixin<KiPage>{
  int totalKi = 15;
  int currentKi = 15;


  void _spendKi() {
    setState(() {
      currentKi--;
    });
  }

  void _gainKi() {
    setState(() {
      currentKi = totalKi;
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
              'Ki Points: ',
            ),
            Text(
              '$currentKi / $totalKi',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
              ElevatedButton(
                onPressed: _spendKi, 
                child: const Text('Spend Ki')
              ),
              ElevatedButton(
                onPressed:_gainKi,
                child: const Text('Restore Ki')
              ),
            ].map((widget) => Padding(
          padding: const EdgeInsets.all(16),
          child: widget,
          )).toList(),
        ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
