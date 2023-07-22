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
     CollectionReference forAddingRef,
     String forAnId,
  
  ) async {
    final uniqueName = DateTime.now().toString();
    final fireStorageRef = FirebaseStorage.instance;
    final file = File(anImage!.path);
    final toStorage =
        await fireStorageRef.ref().child("image/$uniqueName").putFile(file);
    final downLoadUrl = await toStorage.ref.getDownloadURL();
    anUrl = downLoadUrl;
    // addingBrangFire(
    //   anImageUrl: anUrl,
    //   anBrandName: theBrandName,
    //   anId: forAnId,
    //   anColectRef: forAddingRef,
    // );
    newBrand(
        anImageUrl: anUrl,
        anBrandName: theBrandName,
        anBrandId: forAnId,
        anReference: forAddingRef,
        );
  }
}

// Future<void> addingBrangFire({
//   required String anImageUrl,
//   required String anBrandName,
//   required String anId,
//   required CollectionReference anColectRef,
// }) async {
//   final addingData = {
//     "imageName": anImageUrl,
//     "brandName": anBrandName,
//     "brandId": anId,
//   };
//   await anColectRef.doc(anId).set(addingData);
// }

Future<void> newBrand({
  required String anImageUrl,
  required String anBrandName,
  required String anBrandId,
 required CollectionReference anReference,
}) async {
 // final anFireBaseInstance = FirebaseFirestore.instance.collection("brands");
  Brand anBrand;
  anBrand = Brand(
    brandName: anBrandName,
    imageName: anImageUrl,
    brandId: anBrandId,
  );

  try {
    final upBrand = anBrand.toJson();
    await anReference.doc(anBrandId).set(upBrand);
  } catch (e) {
    log(e.toString());
  }
}
