
class User{
  final int? id;
  final String name;
  final String number;
  final String? email;
  final String? imgPath;

  User({this.id, required this.name,required this.number, this.email,this.imgPath,});

  factory User.fromMap(Map<String,dynamic>json)=> User(
    id:json['id'],
    name:json['name'],
    number:json['number'],
    email:json['email'],
    imgPath:json['imgPath'],
  );

  Map<String,dynamic> toMap(){
    return{
      'id':id,
      'name':name,
      'number':number,
      'email':email,
      'imgPath':imgPath,

    };
  }
}