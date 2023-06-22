
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductAddingClass {
  addinProduct(
      {required String theItemName,
      required String theItemPrice,
      required String theDescription,
      required List<dynamic> theImageUrls,
      required String oneId,
      required List<dynamic> theSize}) async {
    final uniqueIdName = DateTime.now().toString();
    final brandRef = FirebaseFirestore.instance.collection("admin").doc(oneId);
    final shoesCollection = brandRef.collection("shoe");
    await shoesCollection.doc(uniqueIdName).set({

      "itemName": theItemName,
      "price": theItemPrice,
      "description": theDescription,
      "productImages": theImageUrls,
      "shoeSize": theSize,
      "id": uniqueIdName,
    });
  }
}