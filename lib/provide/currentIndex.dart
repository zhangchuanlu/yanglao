import 'package:flutter/material.dart';

class CurrentIndexProvide with ChangeNotifier{
  int cuttentIndex=0;

  changeIndex(int newIndex){
    cuttentIndex=newIndex;
    notifyListeners();
  }
}