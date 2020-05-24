import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:risknt/notifier/problemNotifier.dart';
import 'package:risknt/screens/list_forms/problem_form.dart';

class ProblemDetail extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {
    ProblemNotifier problemNotifier = Provider.of<ProblemNotifier>(context,listen: false);
    
    return Scaffold(
              
        appBar: AppBar(title: Text(
          problemNotifier.currentProblem.userN,
          )
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              child: Column(
                children: <Widget>[
                  Image.network(problemNotifier.currentProblem.image== null ? 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg' :problemNotifier.currentProblem.image ,
                  ),
                  SizedBox(height: 32,),
                  Center(
                  child: Text(problemNotifier.currentProblem.userN,
                  style:TextStyle(fontSize:40,) ,)
                  ),
                  Text(problemNotifier.currentProblem.category,
                  style: TextStyle(
                    fontSize:18,
                    fontStyle: FontStyle.italic,
                  ),
                  ),
                  
                ]
              )
            ),
          ),
        ),
              floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context){
              return ProblemForm(isUpdating: true,);
            })
          );
        },
        child: Icon(Icons.edit),
        foregroundColor: Colors.white,
      ),
    );
  }
}