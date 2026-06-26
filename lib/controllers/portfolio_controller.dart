import 'package:flutter/material.dart';

class PortfolioController extends ChangeNotifier {
  Offset _mousePosition = Offset.zero;
  Offset get mousePosition => _mousePosition;

  void updateMousePosition(Offset position) {
    _mousePosition = position;
    notifyListeners();
  }

  int _currentSectionIndex = 0;
  int get currentSectionIndex => _currentSectionIndex;

  void setSectionIndex(int index) {
    if (_currentSectionIndex != index) {
      _currentSectionIndex = index;
      notifyListeners();
    }
  }
}
