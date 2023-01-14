import 'package:flutter/material.dart';
import 'package:trucomkkkk/tela.dart';
import 'package:trucomkkkk/tema.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _AppState();
}

class _AppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    Tema.setTema();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    Tema.setTema();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Tema.tema,
      builder: (BuildContext context, Brightness tema, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Trucomkkkk',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          brightness: tema,
          useMaterial3: true,
          primarySwatch: Colors.indigo,
        ),
        home: const MyHomePage(title: 'Trucomkkkk'),
      ),
    );
  }
}
