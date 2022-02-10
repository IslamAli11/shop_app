 class HomeModel{

  bool? status;
 HomeData? data;

 HomeModel.fromJson(Map<String , dynamic>json){
   status = json['status'];
   data = HomeData.fromJson(json['data']);


 }

 }

 class HomeData{

  List<BannerModel>banners=[];
  List<ProductModel>products=[];
  HomeData.fromJson(Map<String , dynamic>json){
     json['banners'].forEach((element){

       banners.add(BannerModel.fromJson(element));

     });

     json['products'].forEach((element){

       products.add(ProductModel.fromJson(element));

     });


  }

 }

 class BannerModel{

int? id;
String? image;

BannerModel.fromJson(Map<String , dynamic>json){

  id = json['id'];
  image = json['image'];


}

 }

 class ProductModel{

  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? inFavorite;
  bool? inCart;
  String? description;

  ProductModel.fromJson(Map<String , dynamic>json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorite = json['in_favorites'];
    inCart = json['in_cart'];
    description = json['description'];
  }


 }