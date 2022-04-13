import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../database/db_helper.dart';

class ProductModel {
  final String id;
  String productName;
  String productPrice;
  File productImage;

  ProductModel({
    required this.id,
    required this.productName,
    required this.productPrice,
    required this.productImage,
  });
}

class ProductProvider extends ChangeNotifier {
  List<ProductModel> _item = [];

  List<ProductModel> get item => _item;

  Uint8List? bytes;

  String? fileType;
  ImagePicker? picker;
  String? fileSize;
  XFile? image;
  File? showImage;
  int? size;

  Future pickImage() async {
    picker = ImagePicker();
    image = await picker!.pickImage(
      source: ImageSource.gallery,
      imageQuality: 25,
      // maxHeight: ,
      // maxWidth: ,
    );
    showImage = File(image!.path);
    bytes = showImage!.readAsBytesSync();
    size = showImage!.readAsBytesSync().lengthInBytes;
    final kb = size! / 1024;
    final mb = kb / 1024;
    fileSize = mb.toString().substring(0, 4);
    fileType = image!.name.toString().split('.').last;
    print('image!.path=${image!.path}');
    print('fileName=$fileType');
    print('image!.mb=$mb');
    print('image!.kb=$kb');
    notifyListeners();
  }

  Future deleteImage() async {
    image = null;
    showImage = null;
    notifyListeners();
  }

  //database
  Future insertDatabase(
    String productName,
    String productPrice,
    File productImage,
  ) async {
    final newProduct = ProductModel(
      id: const Uuid().v1(),
      productName: productName,
      productPrice: productPrice,
      productImage: productImage,
    );
    _item.add(newProduct);

    DBHelper.insert(DBHelper.product, {
      'id': newProduct.id,
      'productName': newProduct.productName,
      'productPrice': newProduct.productPrice,
      'productImage': newProduct.productImage.path,
    });

    notifyListeners();
  }

// نمایش محصولات فعال
  Future<void> selectProducts() async {
    final dataList = await DBHelper.selectProduct();
    _item = dataList
        .map((item) => ProductModel(
              id: item['id'],
              productName: item['productName'],
              productPrice: item['productPrice'],
              productImage: File(item['productImage']),
            ))
        .toList();
    notifyListeners();
  }

  Future<void> deleteProductById(pickId) async {
    await DBHelper.deleteById(DBHelper.product, 'id', pickId);
    print('delete_product');
    notifyListeners();
  }

  Future deleteTable() async {
    await DBHelper.deleteTable(DBHelper.product);
    print('table delete');
    notifyListeners();
  }

  Future<void> updateProductNameById(id, String productName) async {
    final db = await DBHelper.database();
    await db.update(
      DBHelper.product,
      {'productName': productName},
      where: "id = ?",
      whereArgs: [id],
    );
    notifyListeners();
  }

  Future<void> updatePriceById(id, String productPrice) async {
    final db = await DBHelper.database();
    await db.update(
      DBHelper.product,
      {'productPrice': productPrice},
      where: "id = ?",
      whereArgs: [id],
    );
    notifyListeners();
  }

  Future<void> updateProductImageById(id, productImage) async {
    final db = await DBHelper.database();
    await db.update(
      DBHelper.product,
      {'productImage': productImage},
      where: "id = ?",
      whereArgs: [id],
    );
    notifyListeners();
  }
}
