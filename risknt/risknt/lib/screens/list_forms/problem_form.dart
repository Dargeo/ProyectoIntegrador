import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:risknt/api/problem_api.dart';
import 'package:risknt/models/problem.dart';


import 'package:risknt/notifier/problemNotifier.dart';


import '../../notifier/problemNotifier.dart';


class ProblemForm extends StatefulWidget {
  
  final bool isUpdating;

  ProblemForm({@required this.isUpdating});

  @override

  _ProblemFormState createState() => _ProblemFormState();
}

class _ProblemFormState extends State<ProblemForm> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();


  Problem _currentProblem;
  final List <String> categorias =['Ventana abierta','Luces encendidas',"Puertas Abiertas", "Carro encendido"];
  String _imageUrl;
  File _imageFile;
  
 @override
 void initState(){
   super.initState();
    ProblemNotifier problemNotifier = Provider.of<ProblemNotifier>(context,listen: false);

  if(problemNotifier.currentProblem != null && problemNotifier.currentProblem.id != problemNotifier.problemList[problemNotifier.problemList.length -1].id){
    print(problemNotifier.currentProblem.toString());
    _currentProblem = problemNotifier.currentProblem;
    _currentProblem.category = 'Ventana abierta';
  }else{
    _currentProblem = Problem();
    _currentProblem.category = 'Ventana abierta';
  }
  _imageUrl = _currentProblem.image;
 }
 
 _showImage(){
    if(_imageFile== null && _imageUrl == null){
      return Text('Image placeholder');
    }else if (_imageFile != null ){
      print('showing image from local file');

      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.file(
            _imageFile,
            fit: BoxFit.cover,
            height: 250,
          ),
          FlatButton(
            padding: EdgeInsets.all(16),
            color: Colors.black54,
            child: Text(
              'Change Image',
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w400),
            ),
            onPressed: () => _getLocalImage(),
          )
        ],
      );
    }else if(_imageUrl != null ){
      print('showing image from url');

      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.network(
            _imageUrl,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            height: 250,
          ),
          FlatButton(
            padding: EdgeInsets.all(16),
            color: Colors.black54,
            child: Text(
              'Change Image',
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w400),
            ),
            onPressed: () => _getLocalImage(),
          )
        ],
      );
    }
  }
  _getLocalImage() async {
    File imageFile =
        await ImagePicker.pickImage(source: ImageSource.camera, imageQuality: 50, maxWidth: 400);

    if (imageFile != null) {
      setState(() {
        _imageFile = imageFile;
      });
    }
  }

  Widget _buildNameField(){
            return TextFormField(
              decoration: InputDecoration(labelText: 'Problem descrition'),
              initialValue : _currentProblem.description,
              keyboardType: TextInputType.text,
              style: TextStyle(fontSize:20),
              validator: (String value){
                if(value.isEmpty){
                  return 'Description is required';
                }
                return null;
              },
              onSaved: (String value){
                _currentProblem.description = value;
              },
            );
          }
            Widget _buildPlateField(){
            return TextFormField(
              decoration: InputDecoration(labelText: 'Placa del vehiculo'),
              initialValue : _currentProblem.userid,
              keyboardType: TextInputType.text,
              style: TextStyle(fontSize:20),
              validator: (String value){
                if(value.isEmpty){
                   return 'La placa es requerida';
                }
                return null;
              },
              onSaved: (value){
                _currentProblem.userid = value.toUpperCase();
                _currentProblem.userN = "nombre";
              },
            );
          }

  
      Widget _buildCategoryField(){
        
    return DropdownButtonFormField(
      value: _currentProblem.category, 
      items: categorias.map((cat){
        return DropdownMenuItem(
          value: cat!= null ? cat : 'Ventana abierta',
          child: Text('$cat')
        );
      }).toList(),
      onChanged : (value) {setState(() {
        if(value == null){
            _currentProblem.category = value;
          }else{
            _currentProblem.category = "Ventana abierta";
          }
      });}
      
      
      );
  }

  _saveProblema(){
    print('savefood called ');
    if(!_formkey.currentState.validate()){
      return;
    }
    _formkey.currentState.save();
    print('form saved ');
    uploadProblemAndImage(_currentProblem, widget.isUpdating,_imageFile );
    print("name: ${_currentProblem.userN}");
    print("category: ${_currentProblem.category}");
    print("descripcion: ${_currentProblem.description}");
    Navigator.of(context).pop();
  }
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[100],
      appBar: AppBar(title: Text('Problem form'),
      backgroundColor: Colors.orange,),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(32),
        child:Form(
          key: _formkey,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              _showImage(),
              SizedBox(height: 16,),
              Text(
                widget.isUpdating ? "Edit Problem":
                "Add a new Problem",
               textAlign: TextAlign.center,
               style: TextStyle(fontSize: 30),
              ),
              SizedBox(height: 16,),
              _imageFile == null && _imageUrl == null ? 
              ButtonTheme(
                child:RaisedButton(
                  color:  Colors.orange,
                child: Text(
                  "add image",
                  style: TextStyle(color: Colors.white)
                ),
                onPressed: _getLocalImage,
                ),


              ): SizedBox(height: 0,),
              
                _buildNameField(),
                _buildPlateField(),
                _buildCategoryField(),
            ],
          ),
        ),),
                  floatingActionButton: FloatingActionButton(
                    backgroundColor: Colors.orange,
            onPressed: ()=> _saveProblema(),

            child: Icon(Icons.save),
            foregroundColor: Colors.white,
          ),
    );
  }
}