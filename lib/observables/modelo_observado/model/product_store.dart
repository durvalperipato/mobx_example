import 'package:mobx/mobx.dart';
import 'package:mobx_imc/model/product_model.dart';
part 'product_store.g.dart';

// É criado esta Store pois na page se fizer o debug nota-se que
// somente é observado alterações nos itens da lista e não faz o rebuild
// da lista como um todo, ganhando performance se fosse uma lista com
// milhares de dados.
class ProductStore = ProductStoreBase with _$ProductStore;

abstract class ProductStoreBase with Store {
  @observable
  ProductModel product;

  @observable
  bool selected;

  ProductStoreBase({required this.product, required this.selected});
}
