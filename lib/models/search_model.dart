class SearchModel {
  late bool status;
  late Data data;

  SearchModel.fromJson(Map<String, dynamic>json){
    status=json['status'];
    data=Data.fromJson(json['data']);
  }
}
class Data {
  late int cuurentPage;
  List<Product>data=[];

  Data.fromJson(Map<String, dynamic>json){
    cuurentPage=json['current_page'];
    json['data'].forEach((element){
      data.add(Product.fromJson(element));
    });
  }
}
class Product {
  late int id;
  late dynamic price;
  late String image;
  late String name;
  late String description;
  List<String>images=[];

  Product.fromJson(Map<String, dynamic>json){
    id=json['id'];
    price=json['price'];
    name=json['name'];
    image=json['image'];
    description=json['description'];
    json['images'].forEach((element) { 
      images.add(element);
    });
  }
}