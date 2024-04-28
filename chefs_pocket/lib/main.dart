import 'package:chefs_pocket/app_theme.dart';
import 'package:chefs_pocket/components/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chef's Recipe", //titolo della pagina
      theme: ChefsPocketTheme.light(), //tema della pagina
      home: const MyHomePage(title: "Chef's Pocket"), //pagina iniziale
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: Theme.of(context).textTheme.titleLarge,
          ), //titolo della pagina accessibile grazie a "widget" che permette di accedere ad altre classi
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'ciao',
              ),
            ],
          ),
          // This trailing comma makes auto-formatting nicer for build methods
        ),
        bottomNavigationBar: const CustomBottomNavigationBar(
          activeIconIndex: 0,
        ));

  }
}
