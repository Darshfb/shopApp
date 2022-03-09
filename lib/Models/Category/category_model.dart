class CategoryModel {
  bool? status;
  CategoriesDataModel? data;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoriesDataModel.fromJson(json['data']);
  }
}

class CategoriesDataModel {
  int? current_page;
  List<DataModel>? data = [];

  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    current_page = json['current_page'];
    json['data'].forEach((element) {
      data!.add(DataModel.fromMap(element));
    });
  }
}

class DataModel {
  int? id;
  String? name;
  String? image;

  // DataModel.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   name = json['name'];
  //   image = json['image'];
  // }
  DataModel({this.id, this.name, this.image});

  factory DataModel.fromMap(Map<String, dynamic> map) {
    return DataModel(
      id: map['id'] as int,
      image: map['image'] as String,
      name: map['name'] as String,
    );
  }
}
