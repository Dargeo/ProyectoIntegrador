import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:risknt/models/user.dart';
import 'package:risknt/models/users.dart';
import 'package:risknt/screens/home/settings_form.dart';
import 'package:risknt/screens/screen_number/pageOne.dart';
import 'package:risknt/screens/screen_number/pageThree.dart';
import 'package:risknt/screens/screen_number/pageTwo.dart';
import 'package:risknt/screens/screen_number/pagetres.dart';
import 'package:risknt/services/auth.dart';
import 'package:risknt/services/database.dart';
import 'package:risknt/shared/loading.dart';


class UpBottom extends StatefulWidget {
  @override
  _UpBottomState createState() => _UpBottomState();
}

class _UpBottomState extends State<UpBottom> {
final AuthService _auth = AuthService();
  

//Variables usadas para la movilizacion entre pantallas
  int currentTab= 0;
  PageOne one;
  PageTwo two;
  PageTres three;
  List<Widget> pages;
  Widget currentPage;
  @override
  void initState(){
    one = PageOne();
    two = PageTwo();
    three = PageTres();
    pages = [one,two,three];
    currentPage = one;
    super.initState();
  }
  String title = 'Pagina uno';


//Global key para la navegacion entre pantallas
     GlobalKey _bottomNavigationKey = GlobalKey();
//Global key de data
final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
final user = Provider.of<Usuarios>(context);
//Esto muestra la barra de settings
    void _showSettingsPanel(){
      showModalBottomSheet(
        context: context,
        builder: (context){
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60),
           child: SettingsForm(),
          );
        }
      );
    }

//Metodo para poner el titulo en la appBar

    String _showTitle(){
      if(currentPage== one){
        title='Tus Placas';
        
      }else if(currentPage==two){
        title='Chats';

      }else if(currentPage==three){
        title = 'Ayuda';
      }
      return title;
    }
    return StreamBuilder<Object>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context,snapshot){
        if(snapshot.hasData){
          UserData userData =snapshot.data;
           return StreamProvider<List<Users>>.value(
          value: DatabaseService().users,
            child: Scaffold(
//Creacion de la barra de arriba del home.
              backgroundColor: Colors.orange[100],
              appBar: AppBar(
                centerTitle: true,
                  title: Text(_showTitle(),
                    style: TextStyle(                      
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),             
                backgroundColor: Color(0xFFe67e22),
                brightness: Brightness.light,
                elevation: 0,
              ),

//Creacion de un drawer para el menu de opciones
              drawer: Drawer(
                child: ListView(
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      accountName: Text(userData.nombre),
                      accountEmail: Text(userData.email),
                      currentAccountPicture: GestureDetector(
                        child: CircleAvatar(
                          backgroundImage:  AssetImage('assets/images/download.jfif'),
                        ),
                      ),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/images/night.jpg')
                        )
                      )
                    ),
                    ListTile(
                      title: Text('Placas'),
                      trailing: Icon(Icons.calendar_view_day, color: Color(0xFFe67e22)),
                    ),
                    ListTile(
                      title: Text('Cuenta'),
                      trailing: Icon(Icons.account_circle, color: Color(0xFFe67e22)),
                      onTap: (){ _showSettingsPanel();
                       
                      }
                    ),
                    Divider(),
                    ListTile(
                      onTap: () async {
                      await _auth.signOut();
                      
                      Navigator.pop(context);   
                    },
                      title: Text('Cerrar Sesion'),
                      trailing: Icon(Icons.backspace, color: Color(0xFFe67e22)),
                    ),
                  ],
                ),
                
              ),
              
//Desde aqui se comienza la barra de navegacion con animacion
              body:currentPage,
              bottomNavigationBar: CurvedNavigationBar(
                key:_bottomNavigationKey,
                color: Color(0xFFe67e22),
                backgroundColor: Color(0xFFf1c40f),
                buttonBackgroundColor: Color(0xFFe67e22),
                height: 70 ,
                items: <Widget>[
//Se definen los iconos de la app
                  Icon(Icons.airport_shuttle, size: 19, color: Colors.white,),
                  Icon(Icons.message, size: 19, color: Colors.white),
                  Icon(Icons.add_alert, size: 19, color: Colors.white),
                ],
//Se programa el tiempo que dura la animacion de la barra de navegacion 
                animationDuration: Duration(
                milliseconds: 200,
                ),
                animationCurve: Curves.decelerate,
                index: currentTab,
//Aqui se hace la logica para la eleccion de pantalla
                onTap: (int index) {
                  setState((){
                        currentTab = index;
                        currentPage = pages[index];
                      }
                      );
                },
              
              ),
              
            ));

        }else{
          return Loading();
        }

       
      }
    );
      }
    
  }

