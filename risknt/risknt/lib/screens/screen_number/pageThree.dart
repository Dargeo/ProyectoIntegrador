import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:provider/provider.dart';
import 'package:risknt/models/user.dart';
import 'package:risknt/screens/home/user_list.dart';
import 'package:risknt/screens/screen_number/PageData.dart';
import 'package:risknt/services/database.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class PageThree extends StatelessWidget{

  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Usuarios>(context);
    return StreamBuilder<Object>(
      stream:  DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData userData =snapshot.data;
          return Scaffold(
              body: Container(
              color: Colors.orange,
              child: ImageCapture(nombre: userData.id,), 
                    
            ),
          );
        }else{return Container();}
      }
    );
  }
}


class CircularButton extends StatelessWidget{
  final double width;
  final double height;
  final Color color;
  final Icon icon;
  final Function onClick;

  CircularButton({Key key, this.width, this.height, this.color, this.icon, this.onClick}) : super(key: key);


  @override 
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        color: color,shape: BoxShape.circle,
      ),
      width: width,
      height: height,
      child: IconButton(icon: icon,enableFeedback: true,onPressed: onClick,),
    );
  }
}




/// Widget to capture and crop the image
/// Widget to capture and crop the image
class ImageCapture extends StatefulWidget {
  final String nombre;
  ImageCapture({this.nombre});
  createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  /// Active image file
  File _imageFile;

  /// Cropper plugin
  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
        sourcePath: _imageFile.path,
        // ratioX: 1.0,
        // ratioY: 1.0,
        // maxWidth: 512,
        // maxHeight: 512,
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: IOSUiSettings(
        title: 'Cropper',
      )
      );

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  /// Select an image via gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = selected;
    });
  }

  /// Remove image
  void _clear() {
    setState(() => _imageFile = null);
  }

  @override
  Widget build(BuildContext context) {
    if(_imageFile== null){
      return Scaffold(
        body: PageData(),
        floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.arrow_menu,
        overlayColor: Colors.white,
        backgroundColor: Colors.red,
        animatedIconTheme: IconThemeData.fallback(),
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
            child: Icon(Icons.camera,),
            backgroundColor: Colors.orange,
            label: 'Tomar foto',
            onTap: () => _pickImage(ImageSource.camera),
          ),
          SpeedDialChild(
            child: Icon(Icons.image,),
            backgroundColor: Colors.orange,
            label: 'Abrir galeria',
            onTap: () => _pickImage(ImageSource.gallery),
            
          )
        ],
      ),
      );
    }else{
      return Scaffold(
      

      // Select an image from the camera or gallery
      // bottomNavigationBar: BottomAppBar(
      //   child: Row(
      //     children: <Widget>[
      //       IconButton(
      //         icon: Icon(Icons.photo_camera),
      //         onPressed: () => _pickImage(ImageSource.camera),
      //       ),
      //       IconButton(
      //         icon: Icon(Icons.photo_library),
      //         onPressed: () => _pickImage(ImageSource.gallery),
      //       ),
      //     ],
      //   ),
      // ),

      // Preview the image and crop it

      body: ListView(
        children: <Widget>[
          if (_imageFile != null) ...[

            Image.file(_imageFile),

            Row(
              children: <Widget>[
                FlatButton(
                  child: Icon(Icons.crop),
                  onPressed: _cropImage,
                ),
                FlatButton(
                  child: Icon(Icons.check),
                  onPressed: _clear,
                ),
              ],
            ),

            Uploader(file: _imageFile,nombre: widget.nombre)
          ]
        ],
      ),
    );}

  }
}
class Uploader extends StatefulWidget{
  final File file;
  final String nombre;
  Uploader({Key key,this.file,this.nombre}) : super(key: key);
  createState() => _UploaderState();
}
class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://risknt.appspot.com');

  StorageUploadTask _uploadTask;

  /// Starts an upload task
  void _startUpload() {

    /// Unique file name for the file
    String filePath = 'images/${widget.nombre}.png';

    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {

      /// Manage the task state and event subscription with a StreamBuilder
      return StreamBuilder<StorageTaskEvent>(
          stream: _uploadTask.events,
          builder: (_, snapshot) {
            var event = snapshot?.data?.snapshot;

            double progressPercent = event != null
                ? event.bytesTransferred / event.totalByteCount
                : 0;

            return Column(

                children: [
                  if (_uploadTask.isComplete)
                    Text('Subida de imagen completa'),
                    

                  if (_uploadTask.isPaused)
                    FlatButton(
                      child: Icon(Icons.play_arrow),
                      onPressed: _uploadTask.resume,
                    ),

                  if (_uploadTask.isInProgress)
                    FlatButton(
                      child: Icon(Icons.pause),
                      onPressed: _uploadTask.pause,
                    ),

                  // Progress bar
                  LinearProgressIndicator(value: progressPercent),
                  Text(
                    '${(progressPercent * 100).toStringAsFixed(2)} % '
                  ),
                ],
              );
          });

          
    } else {

      // Allows user to decide when to start the upload
      return FlatButton.icon(
          label: Text('Upload to Firebase'),
          icon: Icon(Icons.cloud_upload),
          onPressed: _startUpload,
        );

    }
  }
}