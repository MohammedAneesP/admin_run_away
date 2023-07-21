import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:run_away_admin/application/brands/brand_display_bloc/brand_displaying_bloc.dart';

// class EditingBrand {
//   final String brandId;
//   final String brandNameUp;
//   final String imageUrlUp;
//   final CollectionReference collectionName;
//   EditingBrand({
//     required this.brandId,
//     required this.brandNameUp,
//     required this.imageUrlUp,
//     required this.collectionName,
//   }) {
//     // updatingBrandFire(
//     //   brandId: brandId,
//     //   brandNameUp: brandNameUp,
//     //   imageUrlUp: imageUrlUp,
//     //   collectionName: collectionName,
//     // );
//   }
// }

Future<void> updatingBrandFire({
  required String brandId,
  required String brandNameUp,
  required String imageUrlUp,
  required CollectionReference collectionName,
  required context,
}) async {
  final anUpdatingMap = {
    "imageName": imageUrlUp,
    "brandName": brandNameUp,
  };
  await collectionName.doc(brandId).update(anUpdatingMap);
  BlocProvider.of<BrandDisplayingBloc>(context).add(BrandDetaiLing());
}
