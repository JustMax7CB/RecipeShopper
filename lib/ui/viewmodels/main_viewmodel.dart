import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@injectable
class MainViewModel extends ChangeNotifier {
  int _selectedIndex = 0;
  String? _title;

  int get selectedIndex => _selectedIndex;
  String? get title => _title;

  void changeToIndex(int index) {
    _selectedIndex = index;
    setTitle();
    notifyListeners();
  }

  void setTitle() {
    switch (_selectedIndex) {
      case 0:
      case 1:
      case 2:
        _title = null;
      case 3:
        _title = "Settings";
      case 4:
        _title = "Profile";
    }
  }
}
