import 'dart:developer' as message;
import 'dart:math';

import 'package:mobx/mobx.dart';
part 'imc_controller.g.dart';

// ignore: library_private_types_in_public_api
class ImcController = _ImcControllerBase with _$ImcController;

abstract class _ImcControllerBase with Store {
  @observable
  var imc = 0.0;

  @observable
  String? error;

  @computed
  bool get hasError => error != null;

  @action
  Future<void> calcularIMC(
      {required double peso, required double altura}) async {
    try {
      imc = 0;
      error = null;
      await Future.delayed(const Duration(seconds: 1));
      imc = peso / pow(altura, 2);
      if (imc > 30) {
        throw Exception();
      }
    } on Exception catch (e, s) {
      message.log('Teste de erro para IMC maior que 30',
          error: e, stackTrace: s);
      error = 'Teste de erro para IMC maior que 30';
    }
  }
}
