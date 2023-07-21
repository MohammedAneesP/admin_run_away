
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> forUpdateProDuct({
  required String productName,
  required String productPrize,
  required String productDescription,
  required List<dynamic> imageList,
  required List<dynamic> shoeSize,
  required String brandId,
  required String productId,
}) async {
  final updateProduct = {
    "itemName": productName,
    "brandId": brandId,
    "price": productPrize,
    "description": productDescription,
    "productImages": imageList,
    "shoeSize": shoeSize,
  };
  FirebaseFirestore.instance
      .collection("products")
      .doc(productId)
      .update(updateProduct);
}
