// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mobx/mobx.dart';

class CounterController {
  final _counter = Observable<int>(0);
  final _fullName =
      Observable<FullName>(FullName(first: 'first', last: 'last'));

  late Action increment;
  late Action changeName;
  late Computed _saudacaoComputed;

  CounterController() {
    increment = Action(_incrementCounter);
    changeName = Action(_changeName);
    _saudacaoComputed = Computed(() => 'Ola ${_fullName.value.first}');
  }

  int get counter => _counter.value;
  String get saudacao => _saudacaoComputed.value;
  FullName get fullName => _fullName.value;

  void _incrementCounter() => _counter.value++;

  void _changeName() {
    // ! Não pode fazer isso
    // _fullName.value.first = 'Durval';
    // _fullName.value.last = 'Neto';

    _fullName.value = _fullName.value.copyWith(first: 'Durval', last: 'Neto');
  }
}

class FullName {
  String first;
  String last;
  FullName({
    required this.first,
    required this.last,
  });

  FullName copyWith({
    String? first,
    String? last,
  }) {
    return FullName(
      first: first ?? this.first,
      last: last ?? this.last,
    );
  }
}
