
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:previsao_mobile/model/previsao.dart';

class DetalhePrevisaoPage extends StatefulWidget{
  final Previsao previsao;

  const DetalhePrevisaoPage({Key? key, required this.previsao }) : super(key: key);


  @override
  DetalhePrevisaoPageState createState() => DetalhePrevisaoPageState();

}

class DetalhePrevisaoPageState extends State<DetalhePrevisaoPage>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: const Text('Detalhes da Localização'),
        centerTitle: false,
      ),
      body: _criarBody(),
    );
  }

  Widget _criarBody() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: [
          Row(
            children: [
              const Campo(descricao: 'Código:'),
              Valor(valor: '${widget.previsao.id}'),
            ],
          ),
          Row(
            children: [
              const Campo(descricao: 'Cidade:'),
              Valor(valor: '${widget.previsao.descricao}'),
            ],
          ),
        ],
      ),
    );
  }

}

class Campo extends StatelessWidget{
  final String descricao;

  const Campo({Key? key, required this.descricao}): super(key: key);

  @override
  Widget build(BuildContext context){
    return Expanded(
      flex: 1,
      child: Text(descricao,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class Valor extends StatelessWidget{
  final String valor;

  const Valor({Key? key, required this.valor}): super(key: key);

  @override
  Widget build(BuildContext context){
    return Expanded(
      flex: 4,
      child: Text(valor == '' ? 'Sem valor' : valor),
    );
  }
}