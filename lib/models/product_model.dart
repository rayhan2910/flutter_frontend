import 'package:bs_admin/helpers/helpers.dart';
import 'package:bs_admin/models/type_model.dart';

class ProductModel {
  int id;
  int typeid;
  String? productcd;
  String? productnm;
  String? description;

  Map<String, dynamic>? _type;

  ProductModel(
      {this.id = 0,
      this.typeid = 0,
      this.productcd,
      this.productnm,
      this.description,
      Map<String, dynamic>? type})
      : _type = type;

  factory ProductModel.fromJson(Map<String, dynamic> map) {
    return ProductModel(
      id: parseInt(map['id']),
      typeid: parseInt(map['typeid']),
      productcd: parseString(map['productcd']),
      productnm: parseString(map['productnm']),
      description: parseString(map['description']),
      type: map['type']
    );
  }

  TypeModel get type {
    if(_type == null) return TypeModel();

    return TypeModel.fromJson(_type!);
  }
}
