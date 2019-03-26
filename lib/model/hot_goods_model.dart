class HotGoodsModel {
  String code;
  String message;
  List<HotGoodsModelData> data;

  HotGoodsModel({this.code, this.message, this.data});

  HotGoodsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<HotGoodsModelData>();
      json['data'].forEach((v) {
        data.add(new HotGoodsModelData.fromJson(v));
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

class HotGoodsModelData {
  double mallPrice;
  String image;
  String goodsId;
  double price;
  String name;

  HotGoodsModelData(
      {this.mallPrice, this.image, this.goodsId, this.price, this.name});

  HotGoodsModelData.fromJson(Map<String, dynamic> json) {
    mallPrice = json['mallPrice'];
    image = json['image'];
    goodsId = json['goodsId'];
    price = json['price'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mallPrice'] = this.mallPrice;
    data['image'] = this.image;
    data['goodsId'] = this.goodsId;
    data['price'] = this.price;
    data['name'] = this.name;
    return data;
  }
}
