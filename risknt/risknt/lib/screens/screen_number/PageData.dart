
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:risknt/models/user.dart';
import 'package:risknt/models/users.dart';
import 'package:risknt/services/database.dart';
import 'package:risknt/services/fireStorageService.dart';
import 'package:risknt/shared/loading.dart';


class PageData extends StatefulWidget {
  final Users user;
  PageData({this.user});
  @override
  _PageDataState createState() => _PageDataState();
}

class _PageDataState extends State<PageData> {
    String b = '';
  @override
  Widget build(BuildContext context) {
      List users =Provider.of<List<Users>>(context) ?? [];
      List<String> newUsers = [];
      for(int a = 0;a<users.length; a++){
        newUsers.add(users[a].id);
      }

    final user = Provider.of<Usuarios>(context);
    return StreamBuilder<Object> (
     stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){

        UserData userData =snapshot.data;



         String filePath = 'images/'+userData.id+'.png';
          if(FireStorageService.loadFromStorage(context, filePath)!=null){
            return Scaffold(
          
            body: Stack(children:<Widget>[
                FutureBuilder(
                   future: _getImage(filePath),
  
                  builder: (context, snapshot) {
  
                    if (snapshot.connectionState ==
  
                        ConnectionState.done)
                  if (b!= null){return Column(
  
                          children: <Widget> [Card(
                            margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
                            child: ListTile(
                              title: Text('Ayudame tengo un problema'),
                              leading: GestureDetector(
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  padding: EdgeInsets.symmetric(vertical: 4.0),
                                  alignment: Alignment.center,
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(b),
                                  ),
                                ),
                                
                                
                              )

                            ),
                            // decoration: BoxDecoration(
                            //   image: DecorationImage(
                            //     image: NetworkImage(b),
                            //   ),
                            // ),
                            // height:
  
                            // MediaQuery.of(context).size.height / 1.25,
  
                            // width:
  
                            // MediaQuery.of(context).size.width / 1.25,
  
                            // child: snapshot.data,

                          ),]
  
                        );}else{
                          return Container();
                        }
                        
  
  
  
                    if (snapshot.connectionState ==
  
                        ConnectionState.waiting){
  
                          return Loading();
  
                        }
  
                          return Container();
  
                  }
                  
                  ,),
  
              
  
              ],
        ),
          );
      }else{return Scaffold(
        backgroundColor: Colors.green,
      );}
        
        }else {return Scaffold(
          backgroundColor: Colors.green,
        );}
      }
    );
  }
  
   Future _getImage(String image) async {

    await FireStorageService.loadFromStorage(context, image)
        .then((downloadUrl) {
          this.b=downloadUrl.toString();
    });


  }
}



