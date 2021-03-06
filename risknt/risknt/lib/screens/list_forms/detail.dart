import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:risknt/notifier/problemNotifier.dart';
import 'package:risknt/screens/list_forms/problem_form.dart';

class ProblemDetail extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {
    ProblemNotifier problemNotifier = Provider.of<ProblemNotifier>(context,listen: false);
    
    return Scaffold(
        backgroundColor: Colors.orange[100],
        appBar: AppBar(title: Text(
          
          
          problemNotifier.currentProblem.userN,
          ),
          backgroundColor: Colors.orange,),
        
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              child: Column(
                children: <Widget>[
                  Image.network(problemNotifier.currentProblem.image== null ? 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg' :problemNotifier.currentProblem.image ,
                  ),
                  SizedBox(height: 32,),
Text("Descripcion",

                  style:TextStyle(fontSize:40,
                  color: Colors.green
                   ,),),
                  SizedBox(height: 10,),
                  Text(problemNotifier.currentProblem.description,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize:18,
                    fontStyle: FontStyle.italic,
                  ),
                  ),
                  SizedBox(height: 10,),
                  Text("Categoria",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize:40,
                    fontStyle: FontStyle.italic,
                  ),
                  ),
                  SizedBox(height: 10,),
                  Text(problemNotifier.currentProblem.category,
                  style: TextStyle(
                    fontSize:18,
                    fontStyle: FontStyle.italic,
                  ),
                  ),
                  SizedBox(height: 10,),
                  Text('Placa',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize:40,
                    fontStyle: FontStyle.italic,
                  ),
                  ),
                  SizedBox(height: 10,),
                  Text(problemNotifier.currentProblem.userid,
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

    );
  }
}