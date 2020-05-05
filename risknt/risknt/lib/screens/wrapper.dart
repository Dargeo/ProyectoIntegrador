import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:risknt/models/user.dart';
import 'package:risknt/screens/authenticate/authenticate.dart';
import 'package:risknt/screens/screen_number/upBottom.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<Usuarios>(context);  
    print(user);

      //Retorna home o authenticate dependiendo si esta o no logeado
      if(user==null){
        return Authenticate();
      } else {
        return UpBottom();
      }


    
  }
}