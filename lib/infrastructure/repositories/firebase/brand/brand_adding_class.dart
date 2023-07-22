import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:run_away_admin/domain/models/brand/brands.dart';

class ForAddingToFire {
  Future<void> addToFire(
    XFile? anImage,
    String anUrl,
    String theBrandName,
  ) async {
    final uniqueName = DateTime.now().toString();
    final fireStorageRef = FirebaseStorage.instance;
    final file = File(anImage!.path);
    final toStorage =
        await fireStorageRef.ref().child("image/$uniqueName").putFile(file);
    final downLoadUrl = await toStorage.ref.getDownloadURL();
    anUrl = downLoadUrl;

    newBrand(
      anImageUrl: anUrl,
      anBrandName: theBrandName,
    );
  }
}

Future<void> newBrand({
  required String anImageUrl,
  required String anBrandName,
}) async {
  final anFireBaseInstance = FirebaseFirestore.instance.collection("brands");
  Brand anBrand;
  anBrand = Brand(
    brandName: anBrandName,
    imageName: anImageUrl,
    brandId: anFireBaseInstance.doc().id,
  );

  try {
    final upBrand = anBrand.toJson();
    await anFireBaseInstance.doc(anFireBaseInstance.doc().id).set(upBrand);
  } catch (e) {
    log(e.toString());
  }
}
