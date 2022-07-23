import 'package:mobx/mobx.dart';
import 'package:mobx_imc/counter/counter_controller.dart';

part 'counter_codegen_controller.g.dart';

abstract class _CounterCodeGenControllerBase with Store {
  @observable
  int counter = 0;

  @observable
  var fullName = FullName(first: 'first', last: 'last');

  @computed
  String get saudacao => 'Olá ${fullName.first}';

  @action
  void increment() {
    counter++;
  }

  @action
  void changeName() {
    fullName.first = fullName.first == 'Durval' ? 'Uliane' : 'Durval';
    fullName = fullName.copyWith(first: fullName.first, last: 'Peripato');
  }
}

// ignore: library_private_types_in_public_api
class CounterCodeGenController = _CounterCodeGenControllerBase
    with _$CounterCodeGenController;
