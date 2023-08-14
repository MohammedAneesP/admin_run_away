import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:run_away_admin/domain/models/brand/brands.dart';

Future<void> updatingBrandFire({
  required String brandId,
  required String brandNameUp,
  required String imageUrlUp,
  required CollectionReference collectionName,
}) async {
  Brand anBrand;
  anBrand = Brand(
    brandName: brandNameUp,
    imageName: imageUrlUp,
    brandId: brandId,
  );

  try {
    final upbrand = anBrand.toJson();
    await collectionName.doc(brandId).update(upbrand);
  } catch (e) {
    log(e.toString());
  }
}
