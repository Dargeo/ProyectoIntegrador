import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:risknt/api/problem_api.dart';
import 'package:risknt/models/problem.dart';
import 'package:risknt/models/user.dart';
import 'package:risknt/notifier/problemNotifier.dart';
import 'package:risknt/screens/list_forms/detail.dart';
import 'package:risknt/screens/list_forms/problem_form.dart';
import 'package:risknt/services/database.dart';

class ProblemList extends StatefulWidget {
  @override
  _ProblemListState createState() => _ProblemListState();
}

class _ProblemListState extends State<ProblemList> {

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
    Future<Null> refreshList() async {
        await Future.delayed(Duration(seconds: 1));
        ProblemNotifier problemNotifier = Provider.of<ProblemNotifier>(context, listen: false);
        getProblem(problemNotifier);
        return null;

    }
    final user = Provider.of<Usuarios>(context);
    problemLists = problemNotifier.problemList;
    return StreamBuilder<Object>(
      stream: DatabaseService(uid: user.uid).userData,
        builder: (context,snapshot){
          if(snapshot.hasData){
          UserData userData = snapshot.data;
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
                    title: Text(problemNotifier.problemList[index].userN,
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
                
                itemCount: problemLists == null ? 0 :problemLists.length ,
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
                    return ProblemForm(isUpdating: false,userN: userData.nombre,userId: userData.placa,problema: problemNotifier.currentProblem,);
                  }),
                );
              },
              child: Icon(Icons.add),
              foregroundColor: Colors.white,
            ),
          ),
        ],
      );
          }else{return Container();
          }

            }

    );
  }
}