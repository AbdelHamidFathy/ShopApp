class CartModel {
  late bool status;
  late Data data;

  CartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  List<CartItems> cartItems=[];
  late dynamic subTotal;
  late dynamic total;

  Data.fromJson(Map<String, dynamic> json) {
      json['cart_items'].forEach((element) {
        cartItems.add(CartItems.fromJson(element));
      });
    subTotal = json['sub_total'];
    total = json['total'];
  }
}

class CartItems {
  late dynamic id;
  late int quantity;
  late Product product;

  CartItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product = Product.fromJson(json['product']);
  }
}

class Product {
  late dynamic id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late String description;
  List<String> images=[];
  late bool inFavorites;
  late bool inCart;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    json['images'].forEach((element){
      images.add(element);
    });
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}