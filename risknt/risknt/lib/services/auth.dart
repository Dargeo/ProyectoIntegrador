import 'package:firebase_auth/firebase_auth.dart';
import 'package:risknt/models/user.dart';
import 'package:risknt/services/database.dart';


class AuthService{

final FirebaseAuth _auth = FirebaseAuth.instance;

//Crea un objeto de usuario basado en el usuario de firebase
Usuarios _userFromFirebaseUser(FirebaseUser user){
  return user != null ? Usuarios(uid: user.uid) : null;

}

//auth cambio en el stream de usuario
Stream<Usuarios> get user {
  return _auth.onAuthStateChanged
  .map(_userFromFirebaseUser);
}


//Metodo para logearse anonimamente
Future signInAnon() async{
  //Al logearse puede haber un error, por eso se usa la funcion try catch
  try{
    AuthResult result = await _auth.signInAnonymously();
    FirebaseUser user = result.user;
    return _userFromFirebaseUser(user);
  }catch(e){
    print(e.toString());
    return null;
  }
}



//Metodo para logearse con email y clave
Future signInWithEmailAndPassword(String email, String clave) async {
  try{
    AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: clave);
    FirebaseUser user = result.user;
    return _userFromFirebaseUser(user);
  }catch(e){
      print(e.toString());
      return null;

  }


}



//Metodo para registrarse con email y clave
Future registerWithEmailAndPassword(String email, String clave,String nombre,String placa, String ciudad, String placa2, String placa3, String colorPlaca1, String colorPlaca2, String colorPlaca3) async {
  try{
    AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: clave);
    FirebaseUser user = result.user;

    //Crear un documento nuevo de usuario
    await DatabaseService(uid: user.uid).updateUserData(nombre, placa, ciudad ,user.uid,email,placa2,placa3,colorPlaca1,colorPlaca2,colorPlaca3);
    return _userFromFirebaseUser(user);
  }catch(e){
      print(e.toString());
      return null;

  }


}




//Salir de la app
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }

  }
}