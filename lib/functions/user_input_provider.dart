import 'package:flutter/material.dart';

class UserInputProvider with ChangeNotifier {
  String? _userInput;

  String? get userInput => _userInput;

  void setUserInput(String? userInput) {
    _userInput = userInput;
    notifyListeners();
  }
}
