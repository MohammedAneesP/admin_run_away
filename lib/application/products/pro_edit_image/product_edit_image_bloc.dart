import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'product_edit_image_event.dart';
part 'product_edit_image_state.dart';

Set<dynamic> forFireImages = {};

class ProductEditImageBloc
    extends Bloc<ProductEditImageEvent, ProductEditImageState> {
  ProductEditImageBloc() : super(ProductEditImageInitial()) {
    on<ProductNetImagesDisply>((event, emit) async {
      //  List<dynamic> forTheImages = [];
      final productDocsnap = await FirebaseFirestore.instance
          .collection("products")
          .doc(event.anId)
          .get();

      final theData = productDocsnap.data();

      if (theData!.isEmpty) {
        return emit(ProductEditImageState(
            firImages: [], anErrorMessage: "no images Uplaoded"));
      }
      if (theData.isNotEmpty) {
        forFireImages.addAll(theData["productImages"]);

        return emit(ProductEditImageState(
            firImages: forFireImages.toList(), anErrorMessage: ""));
      }
    });
    on<ProductImageEditAdd>((event, emit) async {
      // List<dynamic> forTheImages = [];
      final oneImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (oneImage != null) {
        final firebaseStorageRef = FirebaseStorage.instance;
        final uniqueName = DateTime.now().toString();
        final file = File(oneImage.path);
        final toStorage = await firebaseStorageRef
            .ref()
            .child("image/$uniqueName")
            .putFile(file);
        final downloadUrls = await toStorage.ref.getDownloadURL();

        forFireImages.add(downloadUrls);
        return emit(ProductEditImageState(
            firImages: forFireImages.toList(), anErrorMessage: ""));
      }
    });
    on<ProductRemoveImage>((event, emit) async {
      if (forFireImages.isEmpty) {
        return emit(ProductEditImageState(
            firImages: [], anErrorMessage: "Nothing uploaded"));
      } else {
        final anRemoved = forFireImages.toList();
        anRemoved.removeAt(event.index);
        forFireImages.clear();
        forFireImages.addAll(anRemoved);
        return emit(
            ProductEditImageState(firImages: forFireImages.toList(), anErrorMessage: ""));
      }
    });
    on<RemoveAllImages>((event, emit)async {
       forFireImages.clear();
       return emit(ProductEditImageState(firImages: [], anErrorMessage: "sorry"));
    });
  }
}