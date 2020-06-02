import 'dart:collection';

import 'package:flutter/material.dart';

import '../models/problem.dart';

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
  deleteProblem(Problem problem){
    _problemList.removeWhere((_problem) => _problem.id == problem.id);
    notifyListeners();
  }
}