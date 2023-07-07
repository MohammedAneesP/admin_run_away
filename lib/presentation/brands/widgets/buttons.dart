import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:run_away_admin/application/product_display_bloc/product_display_bloc.dart';
import 'package:run_away_admin/core/constants.dart';

class DeleteDocButton extends StatelessWidget {
  final String theDeleteId;
  final CollectionReference anCollection;
  const DeleteDocButton({
    super.key,
    required this.theDeleteId,
    required this.anCollection,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        await anCollection.doc(theDeleteId).delete();
        BlocProvider.of<ProductDisplayBloc>(context).add(ProductsDisplaying());
        anSnackBarFunc(
          context: context,
          aText: "Deleted Successfully",
          anColor: Colors.grey,
        );
        Navigator.of(context).pop();
      },
      child: const Text("Delete"),
    );
  }
}

class AnEditButton extends StatelessWidget {
  final VoidCallback anOnPressed;

  const AnEditButton({
    super.key,
    required this.anOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: anOnPressed, child: const Text("Edit"));
  }
}
