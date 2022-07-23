import 'dart:math';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_imc/imc/imc_controller.dart';
import 'package:mobx_imc/widgets/imc_gauge.dart';

class ImcPage extends StatefulWidget {
  const ImcPage({Key? key}) : super(key: key);

  @override
  State<ImcPage> createState() => _ImcSetStatePageState();
}

class _ImcSetStatePageState extends State<ImcPage> {
  final controller = ImcController();
  final _pesoEC = TextEditingController();
  final _alturaEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final reactionsDisposer = <ReactionDisposer>[];

  @override
  void initState() {
    super.initState();
    final reactionErrorDisposer = reaction<bool>(
      (_) => controller.hasError,
      (hasError) {
        if (hasError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(controller.error ?? 'Erro interno'),
            ),
          );
        }
      },
    );

    reactionsDisposer.add(reactionErrorDisposer);
  }

  @override
  void dispose() {
    _pesoEC.dispose();
    _alturaEC.dispose();
    for (var reactionDisposer in reactionsDisposer) {
      reactionDisposer();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IMC MobX'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Observer(
                  builder: (_) => ImcGauge(imc: controller.imc),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _pesoEC,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Peso',
                  ),
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                      locale: 'pt_BR',
                      symbol: '',
                      decimalDigits: 2,
                      turnOffGrouping: true,
                    ),
                  ],
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "Campo obrigatório";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _alturaEC,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Altura',
                  ),
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                      locale: 'pt_BR',
                      symbol: '',
                      decimalDigits: 2,
                      turnOffGrouping: true,
                    ),
                  ],
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "Campo obrigatório";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final formValid =
                        _formKey.currentState?.validate() ?? false;
                    if (formValid) {
                      var formatter = NumberFormat.simpleCurrency(
                        locale: 'pt-BR',
                        decimalDigits: 2,
                      );
                      double peso = formatter.parse(_pesoEC.text) as double;
                      double altura = formatter.parse(_alturaEC.text) as double;
                      controller.calcularIMC(peso: peso, altura: altura);
                    }
                  },
                  child: const Text('Calcular IMC'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
