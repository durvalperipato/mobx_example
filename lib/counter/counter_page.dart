import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_imc/counter/counter_controller.dart';

class CounterPage extends StatelessWidget {
  final controller = CounterController();
  CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Mobx'),
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.increment();
          controller.changeName();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
