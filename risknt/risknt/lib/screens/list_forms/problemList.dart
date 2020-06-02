import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:risknt/api/problem_api.dart';
import 'package:risknt/models/problem.dart';
import 'package:risknt/models/user.dart';
import 'package:risknt/notifier/problemNotifier.dart';
import 'package:risknt/screens/list_forms/detail.dart';
import 'package:risknt/screens/list_forms/detail_delete.dart';
import 'package:risknt/screens/list_forms/problem_form.dart';
import 'package:risknt/services/database.dart';

import '../../notifier/problemNotifier.dart';

class ProblemList extends StatefulWidget {
  final String completa;
  ProblemList({this.completa});
  @override
  _ProblemListState createState() => _ProblemListState(completa: completa);
}

class _ProblemListState extends State<ProblemList> {

    final String completa;
    _ProblemListState({this.completa});
    GlobalKey<RefreshIndicatorState> refreshKey;

  @override
  void initState() {
    refreshKey = GlobalKey<RefreshIndicatorState>();
    ProblemNotifier problemNotifier = Provider.of<ProblemNotifier>(context, listen: false);
    getProblem(problemNotifier);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    ProblemNotifier problemNotifier = Provider.of<ProblemNotifier>(context);
    List<Problem> problemLists = [];
    int lista ; 
    Future<Null> refreshList() async {
        await Future.delayed(Duration(seconds: 1));
        ProblemNotifier problemNotifier = Provider.of<ProblemNotifier>(context, listen: false);
        getProblem(problemNotifier);
        return null;
    }
    final user = Provider.of<Usuarios>(context);
    return StreamBuilder<Object>(
      stream: DatabaseService(uid: user.uid).userData,
        builder: (context,snapshot){
          if(snapshot.hasData){
            UserData userData = snapshot.data;

            if (completa == "no" && problemLists.length== 0 ){
            for(int a = 0; a<problemNotifier.problemList.length; a++){
            if(problemNotifier.problemList[a].userid == userData.placa || problemNotifier.problemList[a].userid == userData.placa2 || problemNotifier.problemList[a].userid == userData.placa3){
                problemLists.add(problemNotifier.problemList[a]);
                lista = (problemLists.length/2).round();
            }} 
              return Container(
                child: Text("No hay nada agregado a la lista"),
              );
            }
            if(completa == "no"){
            for(int a = 0; a<problemNotifier.problemList.length; a++){
            if(problemNotifier.problemList[a].userid == userData.placa || problemNotifier.problemList[a].userid == userData.placa2 || problemNotifier.problemList[a].userid == userData.placa3){
                problemLists.add(problemNotifier.problemList[a]);
                lista = (problemLists.length/2).round();
            }} 
                  return Stack(
                  children: <Widget>[
                    Scaffold(
                      backgroundColor: Colors.orange[100],
                      body: RefreshIndicator(
                        key: refreshKey,
                        child: ListView.separated(
                          itemBuilder: (BuildContext context, int index){
                            return ListTile(
                              leading : Image.network(
                                problemLists[index].image!= null ? problemLists[index].image : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                              width:120 ,
                              fit:  BoxFit.fitWidth,),
                              title: Text(problemLists[index].userid,
                              style: TextStyle(color: Colors.blue)),
                              subtitle: Text(problemLists[index].category,
                              style: TextStyle(color: Colors.blue)),
                              onTap: (){
                                problemNotifier.currentProblem = problemLists[index];
                                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context ){
                                  return ProblemaDetail();
                                }));
                              },
                            );
                          },
                          
                          itemCount: lista == null ? 1 : lista ,
                          separatorBuilder: (BuildContext context, int index){
                            return Divider(
                              color: Colors.white,
                            );
                          },
                        ), onRefresh: () async{
                          return refreshList();
                        },
                      ),
                      floatingActionButton: FloatingActionButton(
                        backgroundColor: Colors.orange,
                        onPressed: (){
                          
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context){
                              return ProblemForm(isUpdating: false,);
                            }),
                          );
                        },
                        child: Icon(Icons.add),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                );
            }
            else {
              return Stack(
        children: <Widget>[
          Scaffold(
            backgroundColor: Colors.orange[100],
            body: RefreshIndicator(
              key: refreshKey,
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index){
                  return ListTile(
                    leading : Image.network(
                      problemNotifier.problemList[index].image!= null ? problemNotifier.problemList[index].image : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                    width:120 ,
                    fit:  BoxFit.fitWidth,),
                    title: Text(problemNotifier.problemList[index].userid,
                    style: TextStyle(color: Colors.blue)),
                    subtitle: Text(problemNotifier.problemList[index].category,
                    style: TextStyle(color: Colors.blue)),
                    onTap: (){
                      problemNotifier.currentProblem = problemNotifier.problemList[index];
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context ){
                        return ProblemDetail();
                      }));
                    },
                  );
                },
                
                itemCount: problemNotifier.problemList.length ,
                separatorBuilder: (BuildContext context, int index){
                  return Divider(
                    color: Colors.white,
                  );
                },
              ), onRefresh: () async{
                return refreshList();
              },
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.green,
              onPressed: (){
                
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context){
                    return ProblemForm(isUpdating: false);
                  }),
                );
              },
              child: Icon(Icons.add),
              foregroundColor: Colors.white,
            ),
          ),
        ],
      );
            }
          }else{return Container();
          }

            }

    );
  }
}