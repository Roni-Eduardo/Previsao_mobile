
import 'package:previsao_mobile/database/database_provider.dart';
import 'package:previsao_mobile/model/previsao.dart';

class PrevisaoDao{
  final dbProvider = DatabaseProvider.instance;

  Future<bool> salvar(Previsao previsao) async{
    final db = await dbProvider.database;
    final valores = previsao.toMap();
    if(previsao.id == null){
      previsao.id = await db.insert(Previsao.nome_tabela, valores);
      return true;
    }else {
      final registrosAtualizados = await db.update(
          Previsao.nome_tabela, valores,
          where: '${Previsao.campo_id} = ?',
          whereArgs: [previsao.id]);

      return registrosAtualizados > 0;
    }
  }

  Future<bool> remover(int id) async{
    final db = await dbProvider.database;
    final removerRegistro = await db.delete(Previsao.nome_tabela,
        where: '${Previsao.campo_id} = ?', whereArgs: [id]);

    return removerRegistro > 0;
  }

  Future<List<Previsao>> Lista({
    String filtro = '',
    String campoOrdenacao = Previsao.campo_id,
    bool usarOrdemDecrescente = false,
  }) async{
    final db = await dbProvider.database;

    String? where;
    if(filtro.isNotEmpty){
      where = "UPPER(${Previsao.campo_descricao}) LIKE '${filtro.toUpperCase()}%'";
    }

    var orderBy= campoOrdenacao;
    if (usarOrdemDecrescente){
      orderBy += ' DESC';
    }

    final resultado = await db.query(Previsao.nome_tabela,
      columns: [Previsao.campo_id, Previsao.campo_descricao],
      where: where,
      orderBy: orderBy,
    );
    return resultado.map((m) => Previsao.fromMap(m)).toList();
  }
}