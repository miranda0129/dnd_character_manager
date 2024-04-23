import 'package:dnd_character_manager/models/character.dart';
import 'package:dnd_character_manager/models/spell_slots.dart';
import 'package:dnd_character_manager/screens/spellbook/spellbook_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import '../firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider(
    create: (BuildContext context) => Character(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'dnd',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(255, 6, 131, 1)),
        //useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Character Health Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: 
            ChangeNotifierProvider(
              create: (BuildContext context) => SpellSlots(),
              child: SpellbookPage()
            ),
        );
      }
    );
  }
}
