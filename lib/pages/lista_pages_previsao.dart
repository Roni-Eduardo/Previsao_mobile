
import 'package:flutter/material.dart';
import 'package:previsao_mobile/dao/previsao_dao.dart';
import 'package:previsao_mobile/model/previsao.dart';
import 'package:previsao_mobile/pages/detalhe_previsao_page.dart';
import 'package:previsao_mobile/pages/filtro_pages.dart';
import 'package:previsao_mobile/widgets/conteudo_form_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListaPrevisaoPage extends StatefulWidget{

  @override
  _ListaTarefaPageState createState() => _ListaTarefaPageState();
}

class _ListaTarefaPageState extends State<ListaPrevisaoPage>{

  final _tarefas = <Previsao> [];
  final _dao = PrevisaoDao();

  var _carregando = false;

  static const ACAO_EDITAR = 'Editar Cidade';
  static const ACAO_EXCLUIR = 'Excluir Cidade';
  static const ACAO_VISUALIZAR = 'Visualizar Previsão';

  @override
  void initState(){
    super.initState();
    _atualizarLista();
  }

  void _atualizarLista () async{
    setState(() {
      _carregando = true;
    });

    final prefs = await SharedPreferences.getInstance();
    final _campoOrdenacao = prefs.getString(FiltroPage.CHAVE_CAMPO_ORDENACAO) ?? Previsao.campo_id;
    final _usarOrdemDecrescente = prefs.getBool(FiltroPage.CHAVE_ORDENAR_DECRESCENTE) == true;
    final  _filtroDescricao = prefs.getString(FiltroPage.CHAVE_FILTRO_DESCRICAO) ?? '';

    final previsao = await _dao.Lista(
      filtro: _filtroDescricao,
      campoOrdenacao: _campoOrdenacao,
      usarOrdemDecrescente: _usarOrdemDecrescente,
    );
    setState(() {
      _tarefas.clear();
      //if(previsao.isNotEmpty){
        _carregando = false;
        _tarefas.addAll(previsao);
      //}
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: _criarAppBar(context),
      body: _criarBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _abrirForm,
        child: Icon(Icons.add),
        tooltip: 'Nova Localização',
      ),
    );
  }

  AppBar _criarAppBar(BuildContext context){
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      title: const Text('Previsões'),
      centerTitle: false,
      actions: [
        IconButton(
          onPressed: _abrirFiltro,
          icon: const Icon(Icons.filter_list),
        )
      ],
    );
  }

  Widget _criarBody(){
    if(_carregando){
      return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: AlignmentDirectional.center,
            child: CircularProgressIndicator(),
          ),
          Align(
            alignment: AlignmentDirectional.center,
            child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text('Carregando suas Previsões!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      );
    }

    if(_tarefas.isEmpty){
      return  const Center(
        child: Text('Tudo certo por aqui!!!',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );
    }

   return ListView.separated(
      itemBuilder: (BuildContext context, int index){
        final tarefa = _tarefas[index];

        return PopupMenuButton<String>(
          itemBuilder: (BuildContext context) => criarItensMenuPopUp(),
          onSelected: (String valorSelecionado){
            if (valorSelecionado == ACAO_EDITAR){
              _abrirForm(tarefaAtual: tarefa);
            }else if (valorSelecionado == ACAO_EXCLUIR){
              _excluir(tarefa);
            }else{
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => DetalhePrevisaoPage(previsao: tarefa)));
            }
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemCount: _tarefas.length,
    );
  }


  void _abrirFiltro(){
    final navigator = Navigator.of(context);
    navigator.pushNamed(FiltroPage.ROUTE_NAME).then((alterouValor) {
      if(alterouValor == true){
        _atualizarLista();
      }
    });
  }

  List<PopupMenuEntry<String>> criarItensMenuPopUp(){
    return [
      const PopupMenuItem(
          value: ACAO_VISUALIZAR,
          child: Row(
            children: [
              Icon(Icons.info, color: Colors.blue),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text('Visualizar'),
              )
            ],
          )
      ),
      const PopupMenuItem(
          value: ACAO_EDITAR,
          child: Row(
            children: [
              Icon(Icons.edit, color: Colors.black),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text('Editar'),
              )
            ],
          )
      ),
      const PopupMenuItem(
          value: ACAO_EXCLUIR,
          child: Row(
            children: [
              Icon(Icons.delete, color: Colors.red),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text('Excluir'),
              )
            ],
          )
      )
    ];
  }

  Future _excluir(Previsao tarefa){
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return  AlertDialog(
            title: const Row(
              children: [
                Icon(Icons.warning, color: Colors.red,),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text('Atenção', style: TextStyle(color: Colors.red),),
                )
              ],
            ),
            content: const Text('Essa localização será deletada definitivamente!'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancelar')
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (tarefa.id == null){
                      return;
                    }
                    _dao.remover(tarefa.id!).then((success) {
                      if(success){
                        _atualizarLista();
                      }
                    });
                  },
                  child: const Text('Ok')
              ),
            ],
          );
        }
    );

  }

  void _abrirForm({Previsao? tarefaAtual}){
    final key = GlobalKey<ConteudoFormDialogState>();
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text(tarefaAtual == null ? 'Nova Localização' :
            'Cidade ${tarefaAtual.id}'),
            content: ConteudoFormDialog(key: key, tarefaAtual: tarefaAtual),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  if (key.currentState!.dadosValidados() &&
                      key.currentState != null){
                    setState(() {
                      final novaTarefa = key.currentState!.novaTarefa;
                      _dao.salvar(novaTarefa).then((success) {
                        if(success){
                          _atualizarLista();
                        }
                      });
                    });
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Salvar'),
              )
            ],
          );
        }
    );
  }
}