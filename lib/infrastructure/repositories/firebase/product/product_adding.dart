
import 'package:cloud_firestore/cloud_firestore.dart';

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
