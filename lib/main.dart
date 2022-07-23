import 'package:flutter/material.dart';
import 'package:mobx_imc/observables/future/future_page.dart';
import 'package:mobx_imc/observables/modelo_observado/modelo_observado_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const CounterCodeGenPage(),
      // home: const ImcPage(),
      // home: const ObservableListPage(),
      // home: const ModeloObservadoPage(),
      home: const FuturePage(),
    );
  }
}
