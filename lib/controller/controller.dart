import 'package:flutter/material.dart';
import 'package:previsao_mobile/pages/search_page.dart';

void main() {
  runApp(PrevisaoTempoApp());
}

class PrevisaoTempoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Previsão do Tempo',
      home: PrevisaoTempoPage(),
    );
  }
}

class PrevisaoTempoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[100],
        title: const Text(
          'Previsão do Tempo', //cabeçalho
          style: TextStyle(fontSize: 18), // Altere o tamanho do texto aqui
        ),
        leading: IconButton(
          icon: const Icon(Icons.filter_list),
          onPressed: () {
            _abrirSearch(context); // Chama a função _abrirSearch com o contexto
          },
        ),
      ),
      body: Align(
        alignment: Alignment.bottomRight,
        child: WeatherDataWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _abrirSearch(context); // Chama a função _abrirSearch com o contexto
        },
        backgroundColor: Colors.cyan[100],
        child: const Icon(Icons.search),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _abrirSearch(BuildContext context) {
    final navigator = Navigator.of(context);
    navigator.pushNamed(SearchPage.PESQUISA).then((alterouValor) {
      if (alterouValor == true) {
        //implementa pesquisa
        }
      }
    );
  }
}

class WeatherDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 30),
        Text('Coronel Vivida', style: TextStyle(fontSize: 24),),
        SizedBox(height: 5),
        Text('Paraná, Brasil', style: TextStyle(fontSize: 12),),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('24°', style: TextStyle(fontSize: 50),),
            SizedBox(width: 10),
            Icon(Icons.wb_sunny, size: 50, color: Colors.yellow,),
          ],
        ),
        SizedBox(height: 5),
        Text('Ensolarado', style: TextStyle(fontSize: 20),),
        SizedBox(height: 5),
        Text('Máx.: 28º Mín.: 19º', style: TextStyle(fontSize: 20),),
        SizedBox(height: 25),

        Padding(
          padding: EdgeInsets.only(left: 16.0), // Ajuste aqui
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('28° - 19º', style: TextStyle(fontSize: 20),),
              SizedBox(width: 15),
              Icon(Icons.wb_sunny, size: 18, color: Colors.yellow,),
              SizedBox(width: 15),
              SizedBox(height: 30),
              Text('Hoje', style: TextStyle(fontSize: 20),),
            ],
          ),
        ),

        Padding(
          padding: EdgeInsets.only(left: 16.0), // Ajuste aqui
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('14º - 10°', style: TextStyle(fontSize: 20),),
              SizedBox(width: 15),
              Icon(Icons.cloudy_snowing, size: 18,color: Colors.blue,),
              SizedBox(width: 15),
              SizedBox(height: 30),
              Text('Terça-feira', style: TextStyle(fontSize: 20),),
            ],
          ),
        ),


        Padding(
          padding: EdgeInsets.only(left: 16.0), // Ajuste aqui
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('18° - 10º', style: TextStyle(fontSize: 20),),
              SizedBox(width: 15),
              Icon(Icons.cloudy_snowing, size: 18, color: Colors.blue,),
              SizedBox(width: 15),
              SizedBox(height: 30),
              Text('Quarta-feira', style: TextStyle(fontSize: 20),),
            ],
          ),
        ),


        Padding(
          padding: EdgeInsets.only(left: 16.0), // Ajuste aqui
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('22° - 14º', style: TextStyle(fontSize: 20),),
              SizedBox(width: 15),
              Icon(Icons.cloud_queue_sharp, size: 18, color: Colors.blue,),
              SizedBox(width: 15),
              SizedBox(height: 30),
              Text('Quinta-feira', style: TextStyle(fontSize: 20),),
            ],
          ),
        ),


        Padding(
          padding: EdgeInsets.only(left: 16.0), // Ajuste aqui
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('26° - 14º', style: TextStyle(fontSize: 20),),
              SizedBox(width: 15),
              Icon(Icons.wb_sunny, size: 18, color: Colors.yellow,),
              SizedBox(width: 15),
              SizedBox(height: 30),
              Text('Sexta-feira', style: TextStyle(fontSize: 20),),
            ],
          ),
        ),
      ],
    );
  }
}