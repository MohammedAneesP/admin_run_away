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
  }) ;
}
