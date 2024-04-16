// Na tela SearchPage
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchPage extends StatefulWidget {
  static const String PESQUISA = '/search';
  static const String FILTROPESQUISA = 'filtroPesquisa';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SharedPreferences prefs;
  late TextEditingController _descricaoController;
  bool alterouValores = false;

  @override
  void initState() {
    super.initState();
    _descricaoController = TextEditingController();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    prefs = await SharedPreferences.getInstance();
    _descricaoController.text = prefs.getString(SearchPage.FILTROPESQUISA) ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filtro de Pesquisa'),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _descricaoController.clear();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Informe a localização:'),
              controller: _descricaoController,
              onChanged: _onFilterDescricaoChange,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, alterouValores); // Retorna o valor de _alterouValores
        },
        child: Icon(Icons.check),
      ),
    );
  }

  void _onFilterDescricaoChange(String valor) {
    prefs.setString(SearchPage.FILTROPESQUISA, valor);
    setState(() {
      alterouValores = true;
    });
  }
}
