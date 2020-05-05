import 'package:flutter/material.dart';
import 'package:risknt/animation/fadeAnimation.dart';
import 'package:risknt/services/auth.dart';
import 'package:risknt/shared/constants.dart';
import 'package:risknt/shared/loading.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';

class Register extends StatefulWidget {

  // final Function toggleView;
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  void _showColorPanel( ){
    showModalBottomSheet(context: context, builder: (context){
      return Container(
        child: new ColorPicker(
            color: Colors.blue,
            onChanged: (value){
              setState(() {
                pickerColor = value;
                colorsito = pickerColor.toString().substring(pickerColor.toString().indexOf('(')+1);
                colorsito = colorsito.substring(colorsito.indexOf('(')+1,colorsito.indexOf(')'));
                Navigator.of(context).pop();

            });
          }
        ),
        
      );

    });
  }

  void _showColorPanel2( ){
    showModalBottomSheet(context: context, builder: (context){
      return Container(
        child: new ColorPicker(
            color: Colors.blue,
            onChanged: (val){
              setState(() {
                pickerColor2 = val;
                colorsito2 =pickerColor2.toString().substring(pickerColor2.toString().indexOf('(')+1);
                colorsito2 = colorsito2.substring(colorsito2.indexOf('(')+1,colorsito2.indexOf(')'));
                Navigator.of(context).pop();
            
            });
          }
        ),
        
      );

    });
  }
    void _showColorPanel3( ){
    showModalBottomSheet(context: context, builder: (context){
      return Container(
        child: new ColorPicker(
            color: Colors.blue,
            onChanged: (va){
              setState(() {
                pickerColor3 = va;
                colorsito3 =pickerColor3.toString().substring(pickerColor3.toString().indexOf('(')+1);
                colorsito3 = colorsito3.substring(colorsito3.indexOf('(')+1,colorsito3.indexOf(')'));
                Navigator.of(context).pop();
            
            });
          }
        ),
        
      );

    });
  }
  createAlertDialog(BuildContext context){

    return showDialog(context: context, builder:(context){
      return AlertDialog(
        title: Text('Ingrese contraseña'),
        content: ( TextFormField(
        validator: (val)=> val.length <6  ? 'Ingrese un email valido' : null ,
        onChanged: (val){
        setState(()=>clave = val);
        },
        obscureText: true,
        decoration: InputDecoration(
        hintText:  'Ingrese Contraseña',
        hintStyle: TextStyle(color: Colors.grey),
         border: InputBorder.none

        ),
        )
        ),
      );

    });
  }

  final List<String> ciudades = ['Medellin', 'Bogota', 'Cali', 'Barranquilla'];

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  Color pickerColor = Colors.orange;
  Color pickerColor2 = Colors.orange;
  Color pickerColor3 = Colors.orange;
  //Variables de texto
  String email = '';
  String clave = ''; 
  String error = ' ';
  String nombre= '';
  String placa ='';
  String city = 'Medellin';
  String placa2= '';
  String placa3 ='';
  String colorsito = '0xFFe67e22';
  String colorsito2= '0xFFe67e22';
  String colorsito3 = '0xFFe67e22';
  
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() :Scaffold(
      resizeToAvoidBottomPadding: false ,
      //Barra de arriba
      backgroundColor: Colors.blue[100],


      
      //Pagina de Registro
      body: Container(
        
        width: double.infinity,
        
         decoration: BoxDecoration(
           //Creacion de un fondo de pantalla en degrade
           gradient: LinearGradient(
             begin: Alignment.topCenter,
             colors: [
               Color(0xFFe67e22),
               Colors.yellow[200],
               Colors.white,

             ]
           )
          ),
          //Creacion del titulo de LogIn
          child: Column(
           
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 80,),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    //Escrito de login con animacion
                    FadeAnimation(1,Text("Registrate", style: TextStyle(color: Colors.white, fontSize: 40),),),
                    SizedBox(height: 10,),
                    //Escrito de Bienvenido con animacion
                    FadeAnimation(1.3,Text("Bienvenido", style: TextStyle(color: Colors.white, fontSize: 18),),),
                  ],
                  
                ),

              ),
              SizedBox(height: 10,),
              //Creacion de la parte donde se ingresan los datos
              Expanded(
                child: Form(
                  key: _formKey,
                  child:Container(
                  decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60) , topRight: Radius.circular(60))
                  ),
                  child: Padding(
                    
                    padding: EdgeInsets.all(20),
                    child: SingleChildScrollView(                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 40,),
                        FadeAnimation(1.5,Container(
                          
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [BoxShadow(
                              color: Color(0xFFe67e22),
                              blurRadius: 20,
                              offset: Offset(0,10)
                            )]
                          ),
                          child: Column(
                          
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                ),
                                child: TextFormField(
                                  validator: (val)=> val.isEmpty ? 'Ingrese un email valido' : null ,
                                  onChanged: (val){
                                    setState(()=>email = val);
                                  },
                                  decoration: InputDecoration(
                                    hintText:  'Ingrese su email',
                                    hintStyle: TextStyle(color: Colors.orange),
                                    border: InputBorder.none

                                  ),
                                ),
                              ),
                                
                                Container(
                                  padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                ),
                                child: TextFormField(
                                  validator: (val)=> val.length< 6 ?  'Ingrese una clave con mas de 6 caracteres' : null ,
                                  onChanged: (val){
                                    
                                    setState(()=>clave = val);
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText:  "Password",
                                    hintStyle: TextStyle(color: Colors.orange),
                                    border: InputBorder.none

                                  ),
                                ),
                              ),
                              
                               Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                ),
                                child: TextFormField(
                                  validator: (val)=> val.isEmpty ? "El nombre es necesario" : null ,
                                  onChanged: (val){
                                    setState(()=>nombre = val);
                                  },
                                  decoration: InputDecoration(
                                    hintText:  "Ingrese su nombre completo",
                                    hintStyle: TextStyle(color: Colors.orange),
                                    border: InputBorder.none,

                                  ),
                                ),
                              ),
                              DropdownButtonFormField(
                               
                                decoration: textInputDecoration,
                                value: city ?? ciudades[0],
            
                                items: ciudades.map((ciudad){
                                  return DropdownMenuItem(
                                    value: ciudad,
                                    child: Text('$ciudad',
                                    style:TextStyle(color: Colors.orange)),
                                  );
                                }).toList(), onChanged: (val) => setState(()=> city = val),
                              ),
                               Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                ),
                                child: TextFormField(
                                  validator: (val)=> val.length!=6 ? "Ingrese una placa valida" : null ,
                                  onChanged: (val){
                                    setState(()=>placa = val.toUpperCase());
                                  },
                                  decoration: InputDecoration(
                                    hintText:  "Ingrese su placa",
                                    hintStyle: TextStyle(color: Colors.orange),
                                    border: InputBorder.none

                                  ),
                                ),
                              ),
                                 Container(
                                   child: FlatButton(
                                     color: pickerColor,
                                     child: Text("Color placa 1", style: TextStyle(color: Colors.grey)),
                                     onPressed: (){
                                      _showColorPanel();
                                      print(colorsito);
                                      
                                      
                                      
                                     },
                                   ),
                                  
                              ),
                                                             Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                ),
                                child: TextFormField(
                                  textCapitalization:  TextCapitalization.characters,
                                  
                                  onChanged: (val){
                                    setState(()=>placa2 = val.toUpperCase());
                                  },
                                  decoration: InputDecoration(
                                    hintText:  "Ingrese su placa",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none

                                  ),
                                ),
                              ),
                                 Container(
                                   child: FlatButton(
                                     color: pickerColor2,
                                     child: Text("Color placa 2", style: TextStyle(color: Colors.grey),),
                                     onPressed: (){
                                      _showColorPanel2();
                                     
                                     },
                                   ),
                                  
                              ),
                                                             Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                ),
                                child: TextFormField(
                                  
                                  onChanged: (val){
                                    setState(()=>placa3 = val.toUpperCase());
                                  },
                                  decoration: InputDecoration(
                                    hintText:  "Ingrese su placa",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none

                                  ),
                                ),
                              ),
                                 Container(
                                   child: FlatButton(
                                     color: pickerColor3,
                                     child: Text("Color placa 3", style: TextStyle(color: Colors.grey),),
                                     onPressed: (){
                                      _showColorPanel3();
                                     
                                      
                                     },
                                   ),
                                  
                              ),
                                                SizedBox(height: 20.0,),
                              //dropdown

                            ],   
                            ),
                        ),),
                        SizedBox(height: 20,),
                        FadeAnimation(1.5,FlatButton(
                          onPressed: (){
                            widget.toggleView();
                          },
                          child: Text("Ya tiene cuenta ?", style: TextStyle(color: Colors.grey),),
                          )
                        ),
                        SizedBox(height: 60,),
                        FadeAnimation(1.6,ButtonTheme(
                          minWidth:200,
                          height:50,


                          //Creacion de boton para Logearse
                          child: RaisedButton(  
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(590),
                            ),
                            color: Color(0xFFe67e22),
                            child: Text('Register',style: TextStyle(color: Colors.white, fontSize: 16 ,fontWeight: FontWeight.bold),),
                            onPressed: () async {
                              print(colorsito);

                              if(_formKey.currentState.validate()){
                                setState(()=> loading = true);
                                dynamic result = await _auth.registerWithEmailAndPassword(email, clave,nombre,placa,city,placa2,placa3,colorsito,colorsito2,colorsito3);
                                if (result ==null){
                                    setState(() {
                                      error = 'Por favor ingrese un email valido';
                                      loading = false;
                                    });
                                    
                                }
                              }
                              // return SettingsForm();
                              // createAlertDialog(context);
                            },
                            
                          )),
                        ),
                        SizedBox(height: 60,),

                      ],
                    ),)


                  ),
                ),)
              )
            ],
          )
          
          ),
        );
  }
}
