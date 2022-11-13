import 'category_model.dart';

class CategoriesModel {
  List<CategoryModel>? categories;
  int? totalDocs;
  int? offset;
  int? limit;
  int? totalPages;
  int? page;
  int? pagingCounter;
  bool? hasPrevPage;
  bool? hasNextPage;

  CategoriesModel({
    this.categories,
    this.totalDocs,
    this.offset,
    this.limit,
    this.totalPages,
    this.page,
    this.pagingCounter,
    this.hasPrevPage,
    this.hasNextPage,
  });

   factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      categories: json["docs"] == null || json["docs"] == []
          ? null
          : List<CategoryModel>.from(
              json["docs"].map((x) => CategoryModel.fromJson(x))),
      totalDocs: json["totalDocs"],
      offset: json["offset"],
      limit: json["limit"],
      totalPages: json["totalPages"],
      page: json["page"],
      pagingCounter: json["pagingCounter"],
      hasPrevPage: json["hasPrevPage"],
      hasNextPage: json["hasNextPage"],
    );
  }
}
