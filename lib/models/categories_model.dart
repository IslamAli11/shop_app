class CategoriesModel{
  bool? status;
 CategoriesData? data;

 CategoriesModel.fromJson(Map<String , dynamic>json){
   status = json['status'];
   data = CategoriesData.fromJson(json['data']);
 }


}

class CategoriesData{
  int? currentPage;
  List<Data> data = [];
  CategoriesData.fromJson(Map<String , dynamic>json){

    currentPage = json['current_page'];
    json['data'].forEach((element){

      data.add(Data.fromJson(element));
    });
  }


}


class Data{

  int? id;
  String? image;
  String? name;
  Data.fromJson(Map<String , dynamic>json){
    id = json['id'];
    image = json['image'];
    name = json['name'];

  }
}