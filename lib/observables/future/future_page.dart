import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_imc/observables/future/future_controller.dart';

class FuturePage extends StatefulWidget {
  const FuturePage({Key? key}) : super(key: key);

  @override
  State<FuturePage> createState() => _FuturePageState();
}

class _FuturePageState extends State<FuturePage> {
  final controller = FutureController();

  @override
  void initState() {
    controller.buscarNome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Observable Future Page'),
      ),
      body: Observer(
        builder: (_) => FutureBuilder<String>(
          future: controller.nomeFuture,
          builder: (_, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const SizedBox.shrink();
              case ConnectionState.waiting:
              case ConnectionState.active:
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              case ConnectionState.done:
                if (snapshot.hasData) {
                  return Center(
                    child: Text(snapshot.data!),
                  );
                }
                return const Center(
                  child: Text('Nenhum nome encontrado'),
                );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.buscarNome(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
