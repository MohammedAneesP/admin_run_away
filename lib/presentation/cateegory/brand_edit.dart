import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:run_away_admin/core/constants.dart';
import 'package:run_away_admin/presentation/product_page/product_details.dart';

class EditBrand extends StatefulWidget {
  const EditBrand({
    super.key,
    required this.brandImage,
    required this.brandNameText,
    required this.anId,
  });
  final String brandNameText;
  final String brandImage;
  final String anId;

  @override
  State<EditBrand> createState() => _EditBrandState();
}

class _EditBrandState extends State<EditBrand> {
  final brandCollection = FirebaseFirestore.instance.collection('admin');

  void updatingBrand(
      String brandName, String ancSnapshot, String theUrl) async {
    final updateData = {"imageName": theUrl, "brandName": brandName};
    brandCollection.doc(ancSnapshot).update(updateData);
  }

  String imageUrl = "";

  XFile? anUpdateUrl;

  TextEditingController updateController = TextEditingController();
  @override
  void initState() {
    anUpdateUrl = null;
    imageUrl = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    imageUrl = widget.brandImage;
    updateController.text = widget.brandNameText;
    final kHeight = MediaQuery.of(context).size.height;
    // final kWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            //  mainAxisAlignment: MainAxisAlignment.,
            children: [
              GestureDetector(
                onTap: () async {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        height: kHeight * .1,
                        child: Column(
                          children: [
                            Text(
                              "Add picture",
                              style: kSubTitleText,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    final pickImage =
                                        await ImagePicker().pickImage(
                                      source: ImageSource.gallery,
                                    );
                                    log(pickImage!.path.toString());
                                    setState(() {
                                      anUpdateUrl = pickImage;
                                    });
                                    if (pickImage == null) {
                                      return;
                                    }
                                    // String uniqueName = DateTime.now.toString();
                                    // Reference referenceRoot =
                                    //     FirebaseStorage.instance.ref();
                                    // Reference referenceDirImage =
                                    //     referenceRoot.child('Image');

                                    // Reference referenceImageToUpload =
                                    //     referenceDirImage.child(uniqueName);
                                    final imageTOubdate = FirebaseStorage
                                        .instance
                                        .refFromURL(widget.brandImage);
                                    try {
                                      await imageTOubdate
                                          .putFile(File(pickImage.path));
                                      imageUrl =
                                          await imageTOubdate.getDownloadURL();
                                    } catch (e) {
                                      snackBar(context, e.toString());
                                    }
                                  },
                                  icon: const Icon(
                                    CupertinoIcons.photo_fill,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: CircleAvatar(
                  radius: 120,
                  backgroundImage: anUpdateUrl == null
                      ? NetworkImage(widget.brandImage)
                      : FileImage(File(anUpdateUrl!.path)) as ImageProvider,
                ),
              ),
              TheTextField(
                anLabelText: "Brand name",
                forMaxLine: null,
                anController: updateController,
              ),
              ElevatedButton(
                child: const Text(
                  "Update",
                ),
                onPressed: () {
                  print(widget.anId);
                  updatingBrand(
                    updateController.text,
                    widget.anId,
                    imageUrl,
                  );
                  updateController.clear();

                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
