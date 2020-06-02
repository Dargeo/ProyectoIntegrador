import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:risknt/models/problem.dart';
import 'package:risknt/notifier/problemNotifier.dart';
import 'package:uuid/uuid.dart';

getProblem(ProblemNotifier problemNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance.collection('problems').getDocuments();

  List<Problem> _problemList = [];
  
  snapshot.documents.forEach((document){
    Problem problem = Problem.fromMap(document.data);
    _problemList.add(problem);
  });
  problemNotifier.problemList = _problemList;
}

  uploadProblemAndImage(Problem problem, bool isUpdating,File localFile) async {
    if(localFile!= null){
      print('Uploading image');

      var filExtension = path.extension(localFile.path);
      print(filExtension);

      var uuid = Uuid().v4();
      var now = new DateTime.now();
      final StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('problems/images/$uuid$filExtension');

        await firebaseStorageRef.putFile(localFile).onComplete.catchError(
          (onError){
            print(onError);
            return false;
          }
        );
        String url = await firebaseStorageRef.getDownloadURL();
        _uploadProblem(problem,isUpdating,imageUrl: url);
        print('download url: $url');

        //
    }else{
      print('skiping image upload'); 
      _uploadProblem(problem,isUpdating);
    }


  }
    _uploadProblem(Problem problem, bool isUpdating, {String imageUrl})async {
    CollectionReference problemRef = Firestore.instance.collection('problems');

    if(imageUrl != null ){
      problem.image = imageUrl;
    }

    if(isUpdating){
      await problemRef.document(problem.id).updateData(problem.toMap());
      print('updated movie with id: ${problem.id}');
    }else{
      DocumentReference documentRef = await problemRef.add(problem.toMap());

      problem.id = documentRef.documentID;

      print('uploaded movie successfully: ${problem.toString()}');

      await documentRef.setData(problem.toMap(),merge: true);
    }

  }
    deleteProblem(Problem problem, Function functionDeleted) async{
    if(problem.image != null){
      StorageReference storageReference = await FirebaseStorage.instance.getReferenceFromUrl(problem.image);

      print(storageReference.path);

      await storageReference.delete();
    }
await Firestore.instance.collection('problems').document(problem.id).delete();
  }