import 'package:mobx/mobx.dart';

part 'future_controller.g.dart';

class FutureController = FutureControllerBase with _$FutureController;

abstract class FutureControllerBase with Store {
  @observable
  //Opção 1
  // ObservableFuture<String> nomeFuture = Future.value('').asObservable();

  //Opção 2
  // var nomeFuture = Future.value('').asObservable();

  // Opção 3
  var nomeFuture = ObservableFuture.value('');

  @action
  Future<void> buscarNome() async {
    // Opção 1
    // nomeFuture = Future.delayed(const Duration(seconds: 2), () => 'Durval')
    //     .asObservable();

    // Opção 2
    // var buscarNomeFuture =
    //     Future.delayed(const Duration(seconds: 2), () => 'Durval');

    // nomeFuture = buscarNomeFuture.asObservable();

    // Opção 3
    var buscaNomeFuture =
        Future.delayed(const Duration(seconds: 2), () => 'Durval');
    nomeFuture = ObservableFuture(buscaNomeFuture);
  }
}
