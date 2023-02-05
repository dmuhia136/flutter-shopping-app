class CategoryModel {
  String? name;
  String? sId;

  CategoryModel({this.name,this.sId});

    CategoryModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    sId = json['_id'];

  }
}
