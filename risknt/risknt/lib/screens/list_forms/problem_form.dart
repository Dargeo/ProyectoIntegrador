import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:risknt/api/problem_api.dart';
import 'package:risknt/models/problem.dart';
import 'package:risknt/models/user.dart';
import 'package:risknt/notifier/problemNotifier.dart';
import 'package:risknt/services/database.dart';


class ProblemForm extends StatefulWidget {
  
  final bool isUpdating;
  final String userN;
  final String userId;
  final Problem problema;
  ProblemForm({@required this.isUpdating,this.userN,this.userId,this.problema});

  @override

  _ProblemFormState createState() => _ProblemFormState(nombreUser: userN, idUser: userId,currentProblem: problema);
}

class _ProblemFormState extends State<ProblemForm> {
_ProblemFormState({this.nombreUser,this.idUser,this.currentProblem});
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final String nombreUser;
  final String idUser;
  final Problem currentProblem;
  Problem _currentProblem;
  String _currentProblemDescription = '';
  String _currentProblemCategory = 'Ventana abierta';
  final List <String> categorias =['Ventana abierta','Luces encendidas',"Puertas Abiertas", "Carro encendido"];
  String _imageUrl;
  File _imageFile;
  
 @override
 void initState(){
   super.initState();

  if(currentProblem != null){
    _currentProblem = currentProblem;
    _currentProblem.category = 'Ventana abierta';
  }else{
    _currentProblem = Problem();
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
        await ImagePicker.pickImage(source: ImageSource.gallery, imageQuality: 50, maxWidth: 400);

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
                _currentProblem.userN  = nombreUser;
                _currentProblem.userid = idUser;
              },
            );
          }

  
      Widget _buildCategoryField(){
        
    return DropdownButtonFormField(
      value: _currentProblem.category == null ? 'Ventana abierta' : _currentProblem.category, 
      items: categorias.map((cat){
        return DropdownMenuItem(
          value: cat!= null ? cat : 'Ventana abierta',
          child: Text('$cat')
        );
      }).toList(),
      onChanged : (value) {setState(() {
        _currentProblem.category = value;
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