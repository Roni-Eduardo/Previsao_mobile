
import 'package:flutter/material.dart';

import '../model/previsao.dart';

class ConteudoFormDialog extends StatefulWidget{
  final Previsao? tarefaAtual;

  const ConteudoFormDialog({ Key? key, this.tarefaAtual}) : super(key: key);

  @override
  ConteudoFormDialogState createState() => ConteudoFormDialogState();
}

class ConteudoFormDialogState extends State<ConteudoFormDialog>{

  final formKey = GlobalKey<FormState>();
  final descricaoController = TextEditingController();

  @override
  void initState(){
    super.initState();
    if (widget.tarefaAtual != null){
        descricaoController.text = widget.tarefaAtual!.descricao;
      //prazoController.text = widget.tarefaAtual!.prazoFormatado;
    }
  }

  @override
  Widget build(BuildContext context){
    return Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: descricaoController,
              decoration: const InputDecoration(labelText: 'Qual Cidade?'),
              validator: (String? valor){
                if (valor == null || valor.isEmpty){
                  return 'Informe a descrição!';
                }
                return null;
              },
            ),
          ],

        )
    );
  }

  bool dadosValidados() => formKey.currentState?.validate() == true;

  Previsao get novaTarefa => Previsao(
    id: widget.tarefaAtual?.id ?? null,
    descricao: descricaoController.text,
  );
}