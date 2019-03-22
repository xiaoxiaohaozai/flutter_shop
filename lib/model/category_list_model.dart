class CategoryListModel {
  String code;
  String message;
  List<CategoryListData> data;

  CategoryListModel({this.code, this.message, this.data});

  CategoryListModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<CategoryListData>();
      json['data'].forEach((v) {
        data.add(new CategoryListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryListData {
  double oriPrice;
  String image;
  String goodsId;
  double presentPrice;
  String goodsName;

  CategoryListData(
      {this.oriPrice,
      this.image,
      this.goodsId,
      this.presentPrice,
      this.goodsName});

  CategoryListData.fromJson(Map<String, dynamic> json) {
    oriPrice = json['oriPrice'];
    image = json['image'];
    goodsId = json['goodsId'];
    presentPrice = json['presentPrice'];
    goodsName = json['goodsName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['oriPrice'] = this.oriPrice;
    data['image'] = this.image;
    data['goodsId'] = this.goodsId;
    data['presentPrice'] = this.presentPrice;
    data['goodsName'] = this.goodsName;
    return data;
  }
}
