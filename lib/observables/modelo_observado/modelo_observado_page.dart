import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_imc/observables/modelo_observado/modelo_observado_controller.dart';

class ModeloObservadoPage extends StatefulWidget {
  const ModeloObservadoPage({Key? key}) : super(key: key);

  @override
  State<ModeloObservadoPage> createState() => _ObservableListPageState();
}

class _ObservableListPageState extends State<ModeloObservadoPage> {
  final controller = ModeloObservadoController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modelo Observado Page'),
      ),
      body: Column(
        children: [
          Expanded(child: Observer(
            builder: (_) {
              return ListView.builder(
                itemCount: controller.products.length,
                itemBuilder: (_, index) {
                  final productStore = controller.products[index];
                  return Observer(
                    builder: (_) => CheckboxListTile(
                      value: productStore.selected,
                      onChanged: (_) => controller.selectedProduct(index),
                      title: Text(productStore.product.name),
                    ),
                  );
                },
              );
            },
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () => controller.addProduct(),
                  child: const Text('Adicionar')),
              TextButton(
                  onPressed: () => controller.removeProduct(),
                  child: const Text('Remover')),
              TextButton(
                  onPressed: () => controller.loadProducts(),
                  child: const Text('Carregar')),
            ],
          )
        ],
      ),
    );
  }
}
