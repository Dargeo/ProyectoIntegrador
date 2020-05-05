import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:risknt/models/user.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:risknt/services/database.dart';



class PageOne extends StatelessWidget{
  
  @override
  
  Widget build(BuildContext context) {
    String picoPlaca= 'No tiene pico y placa';
    String picoPlaca2= 'No tiene pico y placa';
    String picoPlaca3= 'No tiene pico y placa';
    Color color1 = Colors.blue;
    Color color2 = Colors.blue;
    Color color3 = Colors.blue;
    DateTime dates = DateTime.now();
    String b = DateTimeFormat.format(dates,format: 'l');


    final user = Provider.of<Usuarios>(context);
    return StreamBuilder<Object>(
      stream: DatabaseService(uid: user.uid).userData,
      
      builder: (context,snapshot){
      if(snapshot.hasData){
        print(b);
        UserData userData =snapshot.data;
      // if(DateFormat('EEEE').format(date);)
      List<String> martes = ['2','3','4','5']; 
      for(int a = 0; a< martes.length ; a ++){
        if(b == 'Tuesday' && userData.placa.substring(userData.placa.length-1, userData.placa.length)== martes[a]){
          print('no');
          picoPlaca= 'Tiene pico y placa';
          color1 = Colors.red;
        }
        if(b == 'Tuesday' &&userData.placa2 != '' && userData.placa2.substring(userData.placa2.length-1)== martes[a]){
          picoPlaca2= 'Tiene pico y placa';
          color2 = Colors.red;
        }
        if(b == 'Tuesday' && userData.placa3 != '' &&userData.placa3.substring(userData.placa3.length-1)== martes[a]){
          picoPlaca3= 'Tiene pico y placa';
          color3 = Colors.red;
        }
      }
        


        if(userData.placa2 == ''){
        return SingleChildScrollView (
 
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.orange[100],
                        borderRadius: BorderRadius.only(
                          bottomLeft:Radius.circular(40),
                          bottomRight:Radius.circular(40),
                        )
                      ),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(horizontal:20,vertical:10,),
                            
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('Buenas ${userData.nombre}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text('Tu placa',
                                    style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    ),
                                  )
                                ],
                              ),
                            ),
                              Container(   
                              margin: EdgeInsets.symmetric(horizontal:20,vertical:10,),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(userData.placa,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(16)
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                                    child: Text(userData.ciudad,
                                      style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                  
                                ], 
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: color1,
                                borderRadius: BorderRadius.circular(16)
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                                    child: Text(picoPlaca,
                                      style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                      ),
                                    ),
                            )
                          ],
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 40,
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: 270,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient:LinearGradient(
                            colors:[
                              
                              Color(int. parse(userData.colorPlaca1)),
                              Color(int. parse(userData.colorPlaca1)),
                            ]
                          ),
                        )
                      ),
                    )

                  ],
                ),
              ),
            ),

          );
       }else if(userData.placa2 != '' && userData.placa3 == ''){
         return SingleChildScrollView(
           child: Form(
             child: Container(
               decoration : BoxDecoration(
                 color: Color(int. parse(userData.colorPlaca1)),
               ),
               child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.orange[100],
                        // borderRadius: BorderRadius.only(
                        //   bottomLeft:Radius.circular(40),
                        //   bottomRight:Radius.circular(40),
                        // )
                      ),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(horizontal:20,vertical:10,),
                            
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('Buenas ${userData.nombre}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text('Tu placa',
                                    style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    ),
                                  )
                                ],
                              ),
                            ),
                              Container(
                                
                              margin: EdgeInsets.symmetric(horizontal:20,vertical:10,),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(userData.placa,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(16)
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                                    child: Text(userData.ciudad,
                                      style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  )
                                ], 
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: color1,
                                borderRadius: BorderRadius.circular(16)
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                                    child: Text(picoPlaca,
                                      style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                      ),
                                    ),
                            )


                          ],
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 40,
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: 270,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient:LinearGradient(
                            colors:[
                              
                              Color(int.parse(userData.colorPlaca1)),
                              Color(int.parse(userData.colorPlaca1)),
                            ]
                          ),
                        )
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.orange[100],
                        // borderRadius: BorderRadius.only(
                        //   bottomLeft:Radius.circular(40),
                        //   bottomRight:Radius.circular(40),
                        // )
                      ),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(horizontal:20,vertical:10,),
                            
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('Buenas ${userData.nombre}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text('Tu placa',
                                    style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    ),
                                  )
                                ],
                              ),
                            ),
                              Container(
                                
                              margin: EdgeInsets.symmetric(horizontal:20,vertical:10,),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(userData.placa2,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(16)
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                                    child: Text(userData.ciudad,
                                      style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  )
                                ], 
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: color2,
                                borderRadius: BorderRadius.circular(16)
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                                    child: Text(picoPlaca2,
                                      style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                      ),
                                    ),
                            )


                          ],
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 40,
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: 270,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient:LinearGradient(
                            colors:[
                              
                              Color(int. parse(userData.colorPlaca2)),
                              Color(int. parse(userData.colorPlaca2)),
                            ]
                          ),
                        )
                      ),
                    ),

                  ],
                

               ),
             ),
             

           ),
         );
}else if(userData.placa3!= ''){
         return SingleChildScrollView(
           child: Form(
             child: Container(
               decoration : BoxDecoration(
                 color: Color(int. parse(userData.colorPlaca1)),
               ),
               child: SingleChildScrollView(
                 child: Column(
                    children: <Widget>[
                      SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.orange[100],
                            // borderRadius: BorderRadius.only(
                            //   bottomLeft:Radius.circular(40),
                            //   bottomRight:Radius.circular(40),
                            // )
                          ),
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal:20,vertical:10,),
                                
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('Buenas ${userData.nombre}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text('Tu placa',
                                        style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                  Container(
                                    
                                  margin: EdgeInsets.symmetric(horizontal:20,vertical:10,),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(userData.placa,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.circular(16)
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                                        child: Text(userData.ciudad,
                                          style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      )
                                    ], 
                                  ),
                                ),
                              Container(
                              decoration: BoxDecoration(
                                color: color1,
                                borderRadius: BorderRadius.circular(16)
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                                    child: Text(picoPlaca,
                                      style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                      ),
                                    ),
                            )

                              ],
                            ),
                            margin: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 40,
                            ),
                            width: MediaQuery.of(context).size.width,
                            height: 270,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Color(int.parse(userData.colorPlaca1)),
                            )
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.orange[100],
                          // borderRadius: BorderRadius.only(
                          //   bottomLeft:Radius.circular(40),
                          //   bottomRight:Radius.circular(40),
                          // )
                        ),
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(horizontal:20,vertical:10,),
                              
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('Buenas ${userData.nombre}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text('Tu placa',
                                      style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                                Container(
                                  
                                margin: EdgeInsets.symmetric(horizontal:20,vertical:10,),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(userData.placa2,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(16)
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                                      child: Text(userData.ciudad,
                                        style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    )
                                  ], 
                                ),
                              ),
                              Container(
                              decoration: BoxDecoration(
                                color: color2,
                                borderRadius: BorderRadius.circular(16)
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                                    child: Text(picoPlaca2,
                                      style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                      ),
                                    ),
                            )


                            ],
                          ),
                          margin: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 40,
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: 270,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Color(int.parse(userData.colorPlaca2)),
                          )
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.orange[100],
                          // borderRadius: BorderRadius.only(
                          //   bottomLeft:Radius.circular(40),
                          //   bottomRight:Radius.circular(40),
                          // )
                        ),
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(horizontal:20,vertical:10,),
                              
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('Buenas ${userData.nombre}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text('Tu placa',
                                      style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                                Container(
                                  
                                margin: EdgeInsets.symmetric(horizontal:20,vertical:10,),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(userData.placa3,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(16)
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                                      child: Text(userData.ciudad,
                                        style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    )
                                  ], 
                                ),
                              ),
                              Container(
                              decoration: BoxDecoration(
                                color: color3,
                                borderRadius: BorderRadius.circular(16)
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                                    child: Text(picoPlaca3,
                                      style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                      ),
                                    ),
                            )

                            ],
                          ),
                          margin: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 40,
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: 270,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Color(int.parse(userData.colorPlaca3)),
                          )
                        ),
                      ),

                    ],
                  

                 ),
               ),
             ),
             
             

           ),
         );

}
      }
      return Container();
      }
      
    );
  }
}