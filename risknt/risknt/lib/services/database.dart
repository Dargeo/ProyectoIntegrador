import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:risknt/models/user.dart';
import 'package:risknt/models/users.dart';

class DatabaseService{

final String uid;
DatabaseService({ this.uid });
//Referencia a la coleccion

  final CollectionReference userCollection = Firestore.instance.collection('users2');

  Future updateUserData(String nombre,String placa, String ciudad,String id, String email, String placa2, String placa3, String colorPlaca1, String colorPlaca2, String colorPlaca3)async {
    return await userCollection.document(uid).setData({
      'nombre': nombre,
      'placa': placa,
      'ciudad': ciudad,
      'id': id,
      'email': email,
      'placa2': placa2,
      'placa3': placa3,
      'colorPlaca1':colorPlaca1,
      'colorPlaca2': colorPlaca2,
      'colorPlaca3':colorPlaca3,
    });
  }

//Lista de usuarios desde la snapshot
    List<Users> _userListFromSnapshot(QuerySnapshot snapshot){
      return snapshot.documents.map((doc){
        return Users(
          nombre: doc.data['nombre'] ?? '',
          placa: doc.data['placa'] ?? '',
          ciudad: doc.data['ciudad'] ?? '',
          id: doc.data['id'] ?? '',
          email: doc.data['email'] ?? '',
          placa2: doc.data['placa2'] ?? '',
          colorPlaca1: doc.data['colorPlaca1'] ?? '',
          placa3: doc.data['placa3'] ?? '',
          colorPlaca2: doc.data['colorPlaca2'] ?? '',
          colorPlaca3: doc.data['colorPlaca3'] ?? '',
        );
      }).toList();
      
    }
//Datos de usuario provenientes de una Snapshot
    UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
      return UserData(
        uid: uid,
        nombre: snapshot.data['nombre'],
        ciudad: snapshot.data['ciudad'],
        placa: snapshot.data['placa'],
        id: snapshot.data['id'],
        email: snapshot.data['email'],
        placa2: snapshot.data['placa2'],
        placa3: snapshot.data['placa3'],
        colorPlaca1: snapshot.data['colorPlaca1'],
        colorPlaca2: snapshot.data['colorPlaca2'],
        colorPlaca3: snapshot.data['colorPlaca3']
  
      );
    }

//Obtener stream de usuarios
  Stream<List<Users>> get users {
    return userCollection.snapshots()
    .map(_userListFromSnapshot);
  }


  //Obtener el documento de usuario
  Stream<UserData> get userData{
    return userCollection.document(uid).snapshots()
    .map(_userDataFromSnapshot);
  }

}