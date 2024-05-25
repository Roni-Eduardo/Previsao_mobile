import 'package:flutter/material.dart';
import 'package:previsao_mobile/pages/filtro_pages.dart';
import 'package:previsao_mobile/pages/lista_pages_previsao.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Previsão do Tempo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: ListaPrevisaoPage(),
      routes: {
        FiltroPage.ROUTE_NAME: (BuildContext context) => FiltroPage(),
      },
    );
  }
}