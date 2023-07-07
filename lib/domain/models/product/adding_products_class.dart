import 'package:cloud_firestore/cloud_firestore.dart';

class ProductAddingClass {
  final String theItemName;
  final String theItemPrice;
  final String theDescription;
  final List<dynamic> theImageUrls;
  final String oneId;
  final CollectionReference proAddRef;
  final List<dynamic> theSize;
  final String brandId;
  ProductAddingClass({
    required this.theItemName,
    required this.theItemPrice,
    required this.theDescription,
    required this.theImageUrls,
    required this.oneId,
    required this.proAddRef,
    required this.theSize,
    required this.brandId,
  }) {
    addinProduct(
      theItemName: theItemName,
      theItemPrice: theItemPrice,
      theDescription: theDescription,
      theImageUrls: theImageUrls,
      oneId: oneId,
      proAddRef: proAddRef,
      theSize: theSize,
      brandId: brandId,
    );
  }
}

Future<void> addinProduct({
  required String theItemName,
  required String theItemPrice,
  required String theDescription,
  required List<dynamic> theImageUrls,
  required String oneId,
  required CollectionReference proAddRef,
  required List<dynamic> theSize,
  required String brandId,
}) async {
  await proAddRef.doc(oneId).set({
    "itemName": theItemName,
    "price": theItemPrice,
    "description": theDescription,
    "productImages": theImageUrls,
    "shoeSize": theSize,
    "productId": oneId,
    "brandId": brandId,
  });
}
