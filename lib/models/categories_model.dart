class CategoriesModel {
  late bool status;
  late CategoriesData data;

  CategoriesModel.fromJson(Map<String, dynamic>json){
    status=json['status'];
    data=CategoriesData.fromJson(json['data']);
  }
}
class CategoriesData {
  late int cuurentPage;
  late List<Data>data=[];

  CategoriesData.fromJson(Map<String, dynamic>json){
    cuurentPage=json['current_page'];
    json['data'].forEach((element) {
      data.add(Data.fromJson(element));
    });
  } 
}
class Data {
  late int id;
  late String name;
  late String image;

  Data.fromJson(Map<String, dynamic>json){
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }  
}