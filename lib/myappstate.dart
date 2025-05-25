part of 'main.dart';

class MyAppState extends ChangeNotifier {
  void getNext() {
    notifyListeners();
  }

  var favorites = <WordPair>[];
}