import 'package:mobx/mobx.dart';
import 'package:mobx_imc/model/product_model.dart';
import 'package:mobx_imc/observables/modelo_observado/model/product_store.dart';

part 'modelo_observado_controller.g.dart';

class ModeloObservadoController = ModeloObservadoControllerBase
    with _$ModeloObservadoController;

abstract class ModeloObservadoControllerBase with Store {
  @observable
  var products = <ProductStore>[].asObservable();

  @action
  void loadProducts() {
    products.addAll([
      ProductStore(product: ProductModel(name: 'Computador'), selected: false),
      ProductStore(product: ProductModel(name: 'Celular'), selected: false),
      ProductStore(product: ProductModel(name: 'Teclado'), selected: false),
    ]);
  }

  @action
  void addProduct() => products
      .add(ProductStore(product: ProductModel(name: 'Mouse'), selected: false));

  @action
  void removeProduct() {
    if (products.isNotEmpty) {
      products.removeAt(0);
    }
  }

  @action
  selectedProduct(int index) {
    var productSelected = products[index].selected;
    products[index].selected = !productSelected;
  }
}
