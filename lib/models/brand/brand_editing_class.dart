import 'package:cloud_firestore/cloud_firestore.dart';

class EditingBrand {
  final String brandId;
  final String brandNameUp;
  final String imageUrlUp;
  final CollectionReference collectionName;
  EditingBrand({
    required this.brandId,
    required this.brandNameUp,
    required this.imageUrlUp,
    required this.collectionName,
  }) {
    final updateData = {"imageName": imageUrlUp, "brandName": brandNameUp};
    collectionName.doc(brandId).update(updateData);
  }
}
