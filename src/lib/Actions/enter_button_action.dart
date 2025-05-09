import 'package:flutter/material.dart';
import 'package:muslim_life_mosque_edition/Intents/enter_button_intent.dart';

class EnterButtonAction extends Action<EnterButtonIntent> {
  final Function func;

  EnterButtonAction(this.func);

  @override
  Future<int> invoke(covariant EnterButtonIntent intent) async {
    func();

    return 0;
  }
}
