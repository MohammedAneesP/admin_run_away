import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:run_away_admin/domain/models/product/adding_products_class.dart';

Future<void> addinProduct({
  required String theItemName,
  required String theItemPrice,
  required String theDescription,
  required List<dynamic> theImageUrls,
  required String oneId,
  required CollectionReference proAddRef,
  required Map<dynamic,dynamic> stockAndSize,
  required String brandId,
}) async {
  Product   product;
  product = Product(
    itemName: theItemName,
    productImages: theImageUrls,
    stockAndSize: stockAndSize,
    productId: oneId,
    price: theItemPrice,
    brandId: brandId,
    description: theDescription,
  );
  final uploadProduct = product.toJson();
  await proAddRef.doc(oneId).set(uploadProduct);
}



// Future<void> addinProduct({
//   required String theItemName,
//   required String theItemPrice,
//   required String theDescription,
//   required List<dynamic> theImageUrls,
//   required String oneId,
//   required CollectionReference proAddRef,
//   required List<dynamic> theSize,
//   required String brandId,
// }) async {
//   await proAddRef.doc(oneId).set({
//     "itemName": theItemName,
//     "price": theItemPrice,
//     "description": theDescription,
//     "productImages": theImageUrls,
//     "shoeSize": theSize,
//     "productId": oneId,
//     "brandId": brandId,
//   });
// }