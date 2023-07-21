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
  });
}
