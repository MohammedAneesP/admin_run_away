import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:run_away_admin/core/constants.dart';
import 'package:run_away_admin/presentation/product_page/product_details.dart';

class AddingData extends StatefulWidget {
  AddingData({super.key});

  @override
  State<AddingData> createState() => _AddingDataState();
}

class _AddingDataState extends State<AddingData> {
  XFile? anImage;

  String anUrl = "";

  final TextEditingController brandController = TextEditingController();

  final brandCollection = FirebaseFirestore.instance.collection('admin');

  void addingToCollection(
      {required String brandName, required String brandId}) async {
    final addingData = {
      "imageName": anUrl,
      "brandName": brandName,
      "brandId": brandCollection.doc().id
    };
    brandCollection.add(addingData);
  }

  @override
  Widget build(BuildContext context) {
    final kHeight = MediaQuery.of(context).size.height;
    final kWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => SizedBox(
                        height: kHeight * 0.1,
                        child: Column(
                          children: [
                            Text(
                              "Add picture",
                              style: kSubTitleText,
                            ),
                            IconButton(
                              icon: const Icon(
                                CupertinoIcons.photo_fill,
                                size: 30,
                              ),
                              onPressed: () async {
                                final pickImage = await ImagePicker().pickImage(
                                  source: ImageSource.gallery,
                                );
                                final uniqueName = DateTime.now().toString();
                                final fireStorageRef = FirebaseStorage.instance;
                                final file = File(pickImage!.path);
                                final toStorage = await fireStorageRef
                                    .ref()
                                    .child("image/$uniqueName")
                                    .putFile(file);
                                final downLoadUrl =
                                    await toStorage.ref.getDownloadURL();

                                setState(() {
                                  anImage = pickImage;
                                  anUrl = downLoadUrl;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 120,
                    backgroundImage: anImage == null
                        ? const AssetImage("assets/yonex.png")
                        : FileImage(File(anImage!.path)) as ImageProvider,
                  ),
                ),
                TheTextField(
                    anLabelText: "Brand name",
                    forMaxLine: null,
                    anController: brandController),
                ElevatedButton(
                  onPressed: () {
                    addingToCollection(
                      brandName: brandController.text,
                      brandId: brandCollection.doc().id,
                    );
                    brandController.clear();

                    setState(() {
                      anImage = null;
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Submit",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
