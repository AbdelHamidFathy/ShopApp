class FavoritesModel 
{
  late bool status;
  late Data data;
  
  FavoritesModel.fromJson(Map<String, dynamic> json) 
  {
    status = json['status'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  late int currentPage;
  List<FavoritesData> data=[];

  Data.fromJson(Map<String, dynamic>json){
    currentPage=json['current_page'];
    json['data'].forEach((element){
      data.add(FavoritesData.fromJson(element));
    });
  }
}

class FavoritesData {
  late int id;
  late Product product;

  FavoritesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =Product.fromJson(json['product']);
  }
}

class Product {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late int discount;
  late String image;
  late String name;
  late String description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    data['discount'] = this.discount;
    data['image'] = this.image;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}
