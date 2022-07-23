import 'package:mobx/mobx.dart';
import 'package:mobx_imc/model/product_model.dart';

part 'observable_list_controller.g.dart';

class ObservableListController = ObservableListControllerBase
    with _$ObservableListController;

abstract class ObservableListControllerBase with Store {
  @observable
  // Verificar a instância da lista e não os itens dentro da mesma
  // var products = <ProductModel>[];
  // Opção 1
  // ObservableList products = ObservableList();
  // Opção 2
  var products = <ProductModel>[].asObservable();

  @action
  void loadProducts() {
    products.addAll([
      ProductModel(name: 'Computador'),
      ProductModel(name: 'Celular'),
      ProductModel(name: 'Teclado'),
    ]);
  }

  @action
  void addProduct() => products.add(ProductModel(name: 'Mouse'));

  @action
  void removeProduct() {
    if (products.isNotEmpty) {
      products.removeAt(0);
    }
  }
}
