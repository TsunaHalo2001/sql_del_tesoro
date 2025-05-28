part of 'main.dart';

class MyAppState extends ChangeNotifier {
  void mainPlay() {
    state = 1; // Change to the state for the main play
    notifyListeners();
  }

  var state = 0;
}