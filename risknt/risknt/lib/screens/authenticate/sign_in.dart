import 'package:flutter/material.dart';
import 'package:risknt/animation/fadeAnimation.dart';

import 'package:risknt/services/auth.dart';
import 'package:risknt/shared/loading.dart';


class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});


  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

//Varialbe que permite la union de la base de datos FireBase con la app
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //Variables de texto
  String email = '';
  String clave = '';
  String error = '';
  

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() :Scaffold(
      resizeToAvoidBottomPadding: false ,
      //Barra de arriba
      backgroundColor: Colors.blue[100],
      
      //Pagina de Logeo
      body: Container(
        width: double.infinity,
         decoration: BoxDecoration(
           //Creacion de un fondo de pantalla en degrade
           gradient: LinearGradient(
             begin: Alignment.topCenter,
             colors: [
               Color(0xFFe67e22),
               Colors.yellow,
               Colors.white,

             ]
           ),
           
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
                    FadeAnimation(1,Text("Log-in", style: TextStyle(color: Colors.white, fontSize: 40),),),
                    SizedBox(height: 10,),
                    //Escrito de Bienvenido con animacion
                    FadeAnimation(1.3,Text("Bienvenido", style: TextStyle(color: Colors.white, fontSize: 18),),),
                  ],
                  
                ),

              ),
              SizedBox(height: 20,),
              //Creacion de la parte donde se ingresan los datos
              Expanded(
                child:Form(
                  key: _formKey,
                child: Container(
                  decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60) , topRight: Radius.circular(60))
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
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
                                  border: Border(bottom: BorderSide(
                                    color: Colors.grey[200]
                                    ))
                                ),
                                child: TextFormField(
                                  validator: (val)=> val.isEmpty ? 'ingrese un email valido' : null ,
                                  onChanged: (val){
                                    setState(()=>email = val);
                                  },
                                  decoration: InputDecoration(
                                    hintText:  "Email",
                                    hintStyle: TextStyle(color: Colors.grey),
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
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none

                                  ),
                                ),
                              ),
                            ],
                            ),
                        ),),
                        SizedBox(height: 20,),
                        FadeAnimation(1.5,FlatButton(
                          color: Colors.transparent,
                          onPressed: (){
                            widget.toggleView();
                          },
                          child: Text("Quiere registrarse?", style: TextStyle(color: Colors.grey),),
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
                            child: Text('Log In',style: TextStyle(
                              color: Colors.white,
                              fontSize: 16 ,
                             fontWeight: FontWeight.bold),
                             
                             ),
                            onPressed: () async {
                                 if(_formKey.currentState.validate()){
                                  setState(()=> loading = true);
                                 dynamic result = await _auth.signInWithEmailAndPassword(email, clave);
                                if (result ==null){
                                  setState(() {
                                    error = 'No se puede ingresar con sus credenciales';
                                    loading = false;
                                  });
                                  

                                }
                              }
                            },
                            
                          ),
                          
                          ),
                          
                        ),
                        SizedBox(height: 12.0,),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        ),
                        SizedBox(height: 60,),
                        
                        // FadeAnimation(1.7,Text("Ingrese con Google", style: TextStyle(color: Colors.grey),),),
                        // SizedBox(height: 20,),
                        // Row(
                        //   children: <Widget>[
                        //   Expanded(
                        //     child: FadeAnimation(1.9, Container(
                            
                        //     height: 60,
                        //       decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(50),
                        //       color: Colors.blue,
                        //       ),
                        //       child: Center(
                        //         child: Text('Google', style: TextStyle(color : Colors.white )  ,),
                        //       ),
                        //     ),
                        //   ),),
                        // ],
                        // ),
                      ],
                    ),

                  ),
                ),
              ),),
            ],
          )
          


          ),
        );
    
  }
}