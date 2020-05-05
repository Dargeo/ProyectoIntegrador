import 'package:flutter/material.dart';
import 'package:risknt/models/users.dart';

class UserTile extends StatelessWidget {

  final Users user;
  UserTile({
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius:25.0,
            backgroundColor: Colors.green,
           
          ),
           title: Text(user.nombre),
           subtitle: Text('Su placa es ${user.placa} y su ciudad es ${user.ciudad}'),
        ),
      )
    );
     
  }
}