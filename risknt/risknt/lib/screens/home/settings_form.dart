import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:risknt/models/user.dart';
import 'package:risknt/services/database.dart';
import 'package:risknt/shared/constants.dart';
import 'package:risknt/shared/loading.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> ciudades = ['Medellin', 'Bogota', 'Cali', 'Barranquilla'];


//Valores de la forma
  String _currentNombre;
  String _currentCiudad;
  String _currentPlaca;
  
  

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Usuarios>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context,snapshot){
        if(snapshot.hasData){
          UserData userData =snapshot.data;
          
          return Drawer(
            key:_formKey,
            child: Column(
              children: <Widget>[
                  Text(
                    'Modifica tus datos',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    initialValue: userData.nombre,
                    decoration: textInputDecoration,
                    validator: (val)=> val.isEmpty ? 'Ingrese un nombre' : null,
                    onChanged: (val)=> setState(() => _currentNombre = val),

                  ),
                  SizedBox(height: 20.0,),
                  TextFormField(
                    initialValue: userData.placa,
                    decoration: textInputDecoration,
                    validator: (val)=> val.isEmpty ? 'Ingrese su placa' : null,
                    onChanged: (val)=> setState(() => _currentPlaca = val),

                  ),
                  SizedBox(height: 20.0,),
                  //dropdown
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentCiudad ?? userData.ciudad,
 
                    items: ciudades.map((ciudad){
                      return DropdownMenuItem(
                        value: ciudad,
                        child: Text('$ciudad'),
                      );
                    }).toList(), onChanged: (val) => setState(()=> _currentCiudad = val),
                  ),
                  //button
                  RaisedButton(
                    color: Colors.teal[400],
                    child: Text(
                      'update',
                      style: TextStyle(color: Colors.white)
                    ),
                    onPressed: () async{
                        await DatabaseService(uid: user.uid).updateUserData(
                          _currentNombre ?? userData.nombre,
                          _currentPlaca ?? userData.placa,
                          _currentCiudad ?? userData.ciudad,
                          userData.id,
                          userData.email,
                          userData.placa2,
                          userData.placa3,
                          userData.colorPlaca1,
                          userData.colorPlaca2,
                          userData.colorPlaca3,

                        ); 
                        Navigator.pop(context);                    
                      
                    },

                  )

              ],
            ),
          
        );
        }else{
          return Loading();
        }
        
      }
    );
  }
}