import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:risknt/api/problem_api.dart';
import 'package:risknt/models/problem.dart';
import 'package:risknt/notifier/problemNotifier.dart';
import 'package:risknt/screens/list_forms/problem_form.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class ProblemaDetail extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {


    

    ProblemNotifier problemNotifier = Provider.of<ProblemNotifier>(context,listen: false);
      _onProblemDelete(Problem problem){
    
    problemNotifier.deleteProblem(problem);
    Navigator.of(context).pop();
  }
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
              floatingActionButton: SpeedDial(
                animatedIcon: AnimatedIcons.view_list,
                overlayColor: Colors.black87,
                backgroundColor: Colors.orange,
                animatedIconTheme: IconThemeData.fallback(),
                shape: CircleBorder(),
                children: [
                  SpeedDialChild(
                  child: Icon(Icons.delete),
                  backgroundColor: Colors.red,
                  label: 'Delete',
                  onTap:() {
                    deleteProblem(problemNotifier.currentProblem, _onProblemDelete);
                    Navigator.pop(context);
                  } 
                ),
                SpeedDialChild(
                  child: Icon(Icons.edit),
                  backgroundColor: Colors.green,
                  label: 'Edit',
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context){
                        return ProblemForm(isUpdating: true,);
                        })
                      );
                  }
                ),
                ],
      ),
    );
  }
}