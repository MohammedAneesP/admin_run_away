import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:run_away_admin/domain/models/product/adding_products_class.dart';

Future<void> forUpdateProDuct({
  required String productName,
  required String productPrize,
  required String productDescription,
  required List<dynamic> imageList,
 required Map<dynamic,dynamic> stockAndSize,
  required String brandId,
  required String productId,
}) async {
  Product product;
  product = Product(
    itemName: productName,
    productImages: imageList,
    stockAndSize: stockAndSize,
    productId: productId,
    price: productPrize,
    brandId: brandId,
    description: productDescription,
  );
  final updateProduct = product.toJson();
 
  FirebaseFirestore.instance
      .collection("products")
      .doc(productId)
      .update(updateProduct);
}




