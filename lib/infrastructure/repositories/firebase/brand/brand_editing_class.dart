import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:run_away_admin/application/brands/brand_display_bloc/brand_displaying_bloc.dart';
import 'package:run_away_admin/domain/models/brand/brands.dart';

Future<void> updatingBrandFire({
  required String brandId,
  required String brandNameUp,
  required String imageUrlUp,
  required CollectionReference collectionName,
  required context,
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
    BlocProvider.of<BrandDisplayingBloc>(context).add(BrandDetaiLing());
  } catch (e) {
    log(e.toString());
  }
}
