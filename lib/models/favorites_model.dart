 class FavoritesModel{
  bool? status;
  DataModel? data;

  FavoritesModel.fromJson(Map<String , dynamic>json){
   status = json['status'];
   data =json['data'] !=null? DataModel.fromJson(json['data']) : null;

  }


 }

 class DataModel{
 int? currentPage;
 List<FavoritesDataModel> data = [];
 DataModel.fromJson(Map<String ,dynamic>json){
  currentPage = json['current_page'];
  json['data'].forEach((element){
   data.add(FavoritesDataModel.fromJson(element));

  });

 }

 }

 class FavoritesDataModel{
  int? id;
  ProductsModel? products;
FavoritesDataModel.fromJson(Map<String , dynamic>json){

 id = json['id'];
 products  =json['product'] !=null ? ProductsModel.fromJson(json['product']) : null;

}

 }

 class ProductsModel{
 int? id;
 dynamic price;
 dynamic oldPrice;
 dynamic discount;
 String? image;
 String? name;
 String? description;

 ProductsModel.fromJson(Map<String , dynamic>json){
  id = json['id'];
  price = json['price'];
  oldPrice = json['old_price'];
  discount = json['discount'];
  image = json['image'];
  name = json['name'];
  description = json['description'];

 }

 }