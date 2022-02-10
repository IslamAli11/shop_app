class SearchModel {
  bool? status;
  SearchDataModel? data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? SearchDataModel.fromJson(json['data']) : null;
  }
}

class SearchDataModel {
  int? currentPage;
  List<ProductDataModel> data = [];

  SearchDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(ProductDataModel.fromJson(element));
    });
  }
}

class ProductDataModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;

  ProductDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
