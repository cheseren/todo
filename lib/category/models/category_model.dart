class CategoryModel {
  String? title;
  String? id;

  CategoryModel({
    this.title,
    this.id,
  });

   factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        title: json["title"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "_id": id,
      };

 
}
