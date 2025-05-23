class ItemModel {
  String? status;
  String? message;
  List<Item>? data;

  ItemModel({this.status, this.message, this.data});

  ItemModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Item>[];
      json['data'].forEach((v) {
        data!.add(Item.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Item {
  int? id;
  String? name;
  int? price;
  String? category;
  String? brand;
  int? sold;
  double? rating;
  int? stock;
  int? yearReleased;
  String? material;

  Item(
      {this.id,
      this.name,
      this.price,
      this.category,
      this.brand,
      this.sold,
      this.rating,
      this.stock,
      this.yearReleased,
      this.material});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    category = json['category'];
    brand = json['brand'];
    sold = json['sold'];
    rating = json['rating']?.toDouble();
    stock = json['stock'];
    yearReleased = json['yearReleased'];
    material = json['material'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['category'] = category;
    data['brand'] = brand;
    data['sold'] = sold;
    data['rating'] = rating;
    data['stock'] = stock;
    data['yearReleased'] = yearReleased;
    data['material'] = material;
    return data;
  }
}
