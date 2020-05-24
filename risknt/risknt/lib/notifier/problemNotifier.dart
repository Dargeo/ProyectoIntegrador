import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:risknt/models/problem.dart';

class ProblemNotifier with ChangeNotifier {
List<Problem> _problemList = [];
Problem _currentProblem;

UnmodifiableListView<Problem> get problemList => UnmodifiableListView(_problemList);

Problem get currentProblem => _currentProblem;

set problemList(List<Problem> problemList){
  _problemList=problemList;
     notifyListeners();

}

set currentProblem(Problem problem){
  _currentProblem = problem;
  notifyListeners();
}

}