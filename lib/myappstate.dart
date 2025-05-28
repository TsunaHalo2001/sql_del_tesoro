part of 'main.dart';

class MyAppState extends ChangeNotifier {
  void mainPlay() {
    state = 1; // Change to the state for the main play
    notifyListeners();
  }
  void mapTurtle() {
    state = 2; // Change to the state for the turtle selector map
    notifyListeners();
  }
  void turtlePlay() {
    state = 3; // Change to the state for the turtle intro
    notifyListeners();
  }

  var state = 0;
}