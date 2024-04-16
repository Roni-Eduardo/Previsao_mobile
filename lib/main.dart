import 'package:flutter/material.dart';
import 'package:previsao_mobile/controller/controller.dart';
import 'package:previsao_mobile/pages/search_page.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
          primarySwatch: Colors.cyan,
          useMaterial3: true,
        ),
        home: PrevisaoTempoApp(),
        routes: {
          SearchPage
              .PESQUISA: (BuildContext context) => SearchPage(),
        },
    );
  }
}