import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ForAddingToFire {
  Future<void> addToFire(
    XFile? anImage,
    String anUrl,
    CollectionReference forAddingRef,
    String forAnId,
    String theBrandName,
  ) async {
    final uniqueName = DateTime.now().toString();
    final fireStorageRef = FirebaseStorage.instance;
    final file = File(anImage!.path);
    final toStorage =
        await fireStorageRef.ref().child("image/$uniqueName").putFile(file);
    final downLoadUrl = await toStorage.ref.getDownloadURL();
    anUrl = downLoadUrl;
    addingBrangFire(
      anImageUrl: anUrl,
      anBrandName: theBrandName,
      anId: forAnId,
      anColectRef: forAddingRef,
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
