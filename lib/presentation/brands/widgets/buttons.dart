
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
