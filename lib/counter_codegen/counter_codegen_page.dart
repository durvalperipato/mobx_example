import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_imc/counter_codegen/counter_codegen_controller.dart';

class CounterCodeGenPage extends StatefulWidget {
  const CounterCodeGenPage({Key? key}) : super(key: key);

  @override
  State<CounterCodeGenPage> createState() => _CounterCodeGenPageState();
}

class _CounterCodeGenPageState extends State<CounterCodeGenPage> {
  final controller = CounterCodeGenController();
  final reactionDisposers = <ReactionDisposer>[];

  @override
  void initState() {
    super.initState();
    //Reações

    // autorun fica escutando as variáveis que estão sendo usadas dentro dele
    // e também roda logo quando criado!!!!
    final autorunDisposer = autorun((_) {
      print('---------------------auto run--------------------');
      print(controller.fullName.first);
    });

    // reaction nós falamos para o mobx qual o atributo obersável que queremos observar!!!
    final reactionDisposer = reaction((_) => controller.counter, (counter) {
      print('------------------------ reaction ------------------');
      print(counter);
    });

    // when é disparado apenas e somente uma única vez quando a condição for verdadeira,
    // mesmo se a condição for verdadeira uma segunda vez o when não é mais disparado
    final whenDisposer = when((_) => controller.fullName.first == 'Durval', () {
      print('------------------------ when ------------------');
      print(controller.fullName.first);
    });
    reactionDisposers.add(autorunDisposer);
    reactionDisposers.add(reactionDisposer);
    reactionDisposers.add(whenDisposer);
  }

  @override
  void dispose() {
    for (var reaction in reactionDisposers) {
      // faz o dispose
      reaction();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Code Gen Mobx'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Observer(
              builder: (_) => Text(
                '${controller.counter}',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            Observer(
              builder: (_) => Text(
                controller.fullName.first,
              ),
            ),
            Observer(
              builder: (_) => Text(
                controller.fullName.last,
              ),
            ),
            Observer(
              builder: (_) => Text(
                controller.saudacao,
              ),
            ),
            TextButton(
              onPressed: () => controller.changeName(),
              child: const Text('Mudar Nome'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.increment();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
