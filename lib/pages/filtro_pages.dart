import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:previsao_mobile/model/previsao.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FiltroPage extends StatefulWidget {
  static const ROUTE_NAME = '/filtro';
  static const CHAVE_CAMPO_ORDENACAO = 'campoOrdenacao';
  static const CHAVE_ORDENAR_DECRESCENTE = 'usarOrdemDecrescente';
  static const CHAVE_FILTRO_DESCRICAO = 'filtroDescricao';

  @override
  _FiltroPageState createState() => _FiltroPageState();
}

class _FiltroPageState extends State<FiltroPage> {
  final camposParaOrdenacao = {
    Previsao.campo_id: 'Cidade',
    Previsao.campo_descricao: 'Estado'
  };

  late SharedPreferences prefs;
  final _descricaoController = TextEditingController();
  String _campoOrdenacao = Previsao.campo_id;
  bool _usarOrdemDecrescente = false;
  bool _alterouValores = false;

  @override
  void initState() {
    super.initState();
    _carregarSharedPreferences();
  }

  void _carregarSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _campoOrdenacao =
          prefs.getString(FiltroPage.CHAVE_CAMPO_ORDENACAO) ?? Previsao.campo_id;
      _usarOrdemDecrescente =
          prefs.getBool(FiltroPage.CHAVE_ORDENAR_DECRESCENTE) ?? false;
      _descricaoController.text =
          prefs.getString(FiltroPage.CHAVE_FILTRO_DESCRICAO) ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onVoltarClick,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          title: const Text('Filtro das Localizações'),
        ),
        body: _criaBody(),
      ),
    );
  }

  Widget _criaBody() {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Campos para Localização',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        for (final campo in camposParaOrdenacao.keys)
          ListTile(
            title: Text(camposParaOrdenacao[campo] ?? ''),
            leading: Radio(
              value: campo,
              groupValue: _campoOrdenacao,
              onChanged: _onCampoOrdenacaoChanged,
            ),
          ),
        const Divider(),
        ListTile(
          title: const Text('Usar ordem decrescente'),
          trailing: Checkbox(
            value: _usarOrdemDecrescente,
            onChanged: _onUsarOrdemDecrescenteChange,
          ),
        ),
        const Divider(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            controller: _descricaoController,
            decoration: InputDecoration(
              labelText: 'Filtrar por descrição',
              border: OutlineInputBorder(),
            ),
            onChanged: _onDescricaoChange,
          ),
        ),
      ],
    );
  }

  Future<bool> _onVoltarClick() async {
    Navigator.of(context).pop(_alterouValores);
    return true;
  }

  void _onCampoOrdenacaoChanged(String? valor) {
    prefs.setString(FiltroPage.CHAVE_CAMPO_ORDENACAO, valor ?? '');
    _alterouValores = true;
    setState(() {
      _campoOrdenacao = valor ?? '';
    });
  }

  void _onUsarOrdemDecrescenteChange(bool? valor) {
    prefs.setBool(FiltroPage.CHAVE_ORDENAR_DECRESCENTE, valor == true);
    _alterouValores = true;
    setState(() {
      _usarOrdemDecrescente = valor == true;
    });
  }

  void _onDescricaoChange(String valor) {
    prefs.setString(FiltroPage.CHAVE_FILTRO_DESCRICAO, valor);
    _alterouValores = true;
  }
}
