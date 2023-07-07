import 'package:cloud_firestore/cloud_firestore.dart';

class BrandAdding {
  final String anImageUrl;
  final String anBrandName;
  final String anId;
  final CollectionReference anColectRef;

  BrandAdding({
    required this.anImageUrl,
    required this.anBrandName,
    required this.anId,
    required this.anColectRef,
  }) {
    addingBrangFire(
      anImageUrl: anImageUrl,
      anBrandName: anBrandName,
      anId: anId,
      anColectRef: anColectRef,
    );
  }
}

Future<void> addingBrangFire({
  required String anImageUrl,
  required String anBrandName,
  required String anId,
  required CollectionReference anColectRef,
}) async {
  final addingData = {
    "imageName": anImageUrl,
    "brandName": anBrandName,
    "brandId": anId,
  };
 await anColectRef.doc(anId).set(addingData);
}
