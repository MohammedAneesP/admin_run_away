
import 'package:cloud_firestore/cloud_firestore.dart';

class BrandAdding {
  String anImageUrl;
  final String anBrandName;
  final String anId;
  final CollectionReference anColectRef;

  BrandAdding({
    required this.anImageUrl,
    required this.anBrandName,
    required this.anId,
    required this.anColectRef,
  }) {
    final addingData = {
      "imageName": anImageUrl,
      "brandName": anBrandName,
      "brandId": anId,
    };
     anColectRef.doc(anId).set(addingData);
  }
}




