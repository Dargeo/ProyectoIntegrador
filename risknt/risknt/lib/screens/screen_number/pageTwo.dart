import 'package:flutter/material.dart';




class PageTwo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Container(
      
      color:Colors.tealAccent,
    );
  }
}
// class PageTwo extends StatelessWidget{
//   @override
//   Widget build (BuildContext context) {
//     return ChangeNotifierProvider<ChatModel>(
//       create: (context) => ChatModel(),
//       child: MaterialApp(
//         theme: ThemeData(),
//         home:PageTwoM(),
//         debugShowCheckedModeBanner: false,

//       )

//     );

//   }

// }


// class PageTwoM extends StatelessWidget{

//   @override
//   Widget build(BuildContext context) {
//    return Scaffold(
//      body: Column(
//        children: <Widget>[
//          Expanded(
//           child: Hero(
//             tag: 'logo',
//             child: Container(
//               width: 400.0,
//               child: Image.asset("images/logo.jpeg"),

//             ),
            
//           )
//          ),
//        ]
//      ),
//    );
//   }
// }

