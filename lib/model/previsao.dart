import 'package:intl/intl.dart';

class Previsao {
  static const String nome_tabela = 'tarefas';
  static const campo_id = '_id';
  static const String campo_descricao = 'descricao';
  static const String campo_latitude = 'latitude';
  static const String campo_longitude = 'longitude';

  int? id;
  String descricao;
  double? latitude;
  double? longitude;

  Previsao({required this.id, required this.descricao, this.latitude, this.longitude});

  Map<String, dynamic> toMap() => <String, dynamic>{
    campo_id: id,
    campo_descricao: descricao,
    campo_latitude: latitude,
    campo_longitude: longitude,
  };

  factory Previsao.fromMap(Map<String, dynamic> map) => Previsao(
    id: map[campo_id] is int ? map[campo_id] : null,
    descricao: map[campo_descricao] is String ? map[campo_descricao] : '',
    latitude: map[campo_latitude] is double ? map[campo_latitude] : null,
    longitude: map[campo_longitude] is double ? map[campo_longitude] : null,
  );
}