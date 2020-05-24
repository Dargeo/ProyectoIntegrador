

class Problem {
  String id;
  String category;
  String image;
  String description;
  String userid;
  String userN;

Problem();

  Problem.fromMap(Map<String, dynamic > data){
    id= data['id'];
    category = data['category'];
    image = data['image'];
    description =data['description'];
    userid = data['userid'];
    userN = data['userN'];
  }

  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'category':category,
      'image':image,
      'description':description,
      'userid':userid,
      'userN':userN,
    };
  }
}