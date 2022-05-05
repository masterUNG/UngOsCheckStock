// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String name;
  final String address;
  final String qrcode;
  final int stock;
  final String unit;
  final String urlpic;
  final GeoPoint latlng;
  ProductModel({
    required this.name,
    required this.address,
    required this.qrcode,
    required this.stock,
    required this.unit,
    required this.urlpic,
    required this.latlng,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'address': address,
      'qrcode': qrcode,
      'stock': stock,
      'unit': unit,
      'urlpic': urlpic,
      'latlng': latlng,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: (map['name'] ?? '') as String,
      address: (map['address'] ?? '') as String,
      qrcode: (map['qrcode'] ?? '') as String,
      stock: (map['stock'] ?? 0) as int,
      unit: (map['unit'] ?? '') as String,
      urlpic: (map['urlpic'] ?? '') as String,
      latlng: (map['latlng']),
    );
  }

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
