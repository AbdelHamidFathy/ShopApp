class AddDeleteFavorite {
  late bool status;
  late String message;
  late Data data;


  AddDeleteFavorite.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  late dynamic id;
  late Product product;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = Product.fromJson(json['product']);
  }
}

class Product {
  late dynamic id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
  }
}