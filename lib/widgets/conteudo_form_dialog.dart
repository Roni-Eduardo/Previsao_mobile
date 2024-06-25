import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../model/previsao.dart';

class ConteudoFormDialog extends StatefulWidget {
  final Previsao? tarefaAtual;

  ConteudoFormDialog({Key? key, this.tarefaAtual}) : super(key: key);

  @override
  ConteudoFormDialogState createState() => ConteudoFormDialogState();
}

class ConteudoFormDialogState extends State<ConteudoFormDialog> {
  final formKey = GlobalKey<FormState>();
  final descricaoController = TextEditingController();
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.tarefaAtual != null) {
      descricaoController.text = widget.tarefaAtual!.descricao;
      latitudeController.text = widget.tarefaAtual!.latitude?.toString() ?? '';
      longitudeController.text = widget.tarefaAtual!.longitude?.toString() ?? '';
    }
  }

  Future<void> _preencherLocalizacao() async {
    bool servicoHabilitado = await Geolocator.isLocationServiceEnabled();
    if (!servicoHabilitado) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Serviço de localização desabilitado.'),
      ));
      return;
    }

    LocationPermission permissoes = await Geolocator.checkPermission();
    if (permissoes == LocationPermission.denied) {
      permissoes = await Geolocator.requestPermission();
      if (permissoes == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Permissão de localização negada.'),
        ));
        return;
      }
    }

    if (permissoes == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Permissão de localização negada permanentemente.'),
      ));
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      latitudeController.text = position.latitude.toString();
      longitudeController.text = position.longitude.toString();
    });
  }

  bool dadosValidados() {
    return formKey.currentState?.validate() ?? false;
  }

  Previsao get novaTarefa => Previsao(
    id: widget.tarefaAtual?.id,
    descricao: descricaoController.text,
    latitude: double.tryParse(latitudeController.text),
    longitude: double.tryParse(longitudeController.text),
  );

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: descricaoController,
            decoration: const InputDecoration(labelText: 'Descrição'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Informe a descrição';
              }
              return null;
            },
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: latitudeController,
                  decoration: const InputDecoration(labelText: 'Latitude'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe a latitude';
                    }
                    return null;
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.location_on),
                onPressed: _preencherLocalizacao,
              ),
            ],
          ),
          TextFormField(
            controller: longitudeController,
            decoration: const InputDecoration(labelText: 'Longitude'),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Informe a longitude';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Previsao get previsaoAtual => Previsao(
    id: widget.tarefaAtual?.id ?? null,
    descricao: descricaoController.text,
    latitude: double.tryParse(latitudeController.text),
    longitude: double.tryParse(longitudeController.text),
      );
}