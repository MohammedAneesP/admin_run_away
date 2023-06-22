
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdatingProducts {
  final String productName;
  final String productPrize;
  final String productDescription;
  final List<dynamic> imageList;
  final List<dynamic> shoeSize;
  final String brandId;
  final String productId;
  UpdatingProducts(
      {required this.brandId,
      required this.productId,
      required this.productName,
      required this.productPrize,
      required this.productDescription,
      required this.imageList,
      required this.shoeSize}) {
    final updateProduct = {
      "itemName": productName,
      "price": productPrize,
      "description": productDescription,
      "productImages": imageList,
      "shoeSize": shoeSize,
    };
    FirebaseFirestore.instance
        .collection("admin")
        .doc(brandId)
        .collection("shoe")
        .doc(productId)
        .update(updateProduct);
  }
}
