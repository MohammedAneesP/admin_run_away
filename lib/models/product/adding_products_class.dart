import 'package:cloud_firestore/cloud_firestore.dart';

class ProductAddingClass {
  addinProduct({
    required String theItemName,
    required String theItemPrice,
    required String theDescription,
    required List<dynamic> theImageUrls,
    required String oneId,
    required CollectionReference proAddRef,
    required List<dynamic> theSize,
    required String brandId,
  }) async {
    //final uniqueIdName = DateTime.now().toString();

    await proAddRef.doc(oneId).set({
      "itemName": theItemName,
      "price": theItemPrice,
      "description": theDescription,
      "productImages": theImageUrls,
      "shoeSize": theSize,
      "productId": oneId,
      "brandId":brandId,

    });
  }
}
