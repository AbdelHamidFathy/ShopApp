class LoginModel {
  late bool status;
  late String messaage;
  late UserData data;

  LoginModel.fromJson(Map<String, dynamic>json){
    status=json['status'];
    messaage=json['message'];
    if (json['data']!=null) {
      data=UserData.fromJson(json['data']);
    } 
    else{null;}
  }
}

class UserData {
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late int points;
  late int credit;
  late String token;

  //named constructor
  UserData.fromJson(Map<String, dynamic>json){
    id=json['id'];
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    image=json['image'];
    points=json['points'];
    credit=json['credit'];
    token=json['token'];
  }
}