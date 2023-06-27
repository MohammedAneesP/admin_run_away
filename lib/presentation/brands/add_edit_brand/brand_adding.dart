import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:run_away_admin/core/color_constants.dart';
import 'package:run_away_admin/core/constants.dart';
import 'package:run_away_admin/models/brand/brand_adding_class.dart';
import 'package:run_away_admin/presentation/widgets/image_container.dart';
import 'package:run_away_admin/presentation/widgets/textfield.dart';

class AddingData extends StatefulWidget {
  const AddingData({super.key});

  @override
  State<AddingData> createState() => _AddingDataState();
}

class _AddingDataState extends State<AddingData> {
  XFile? anImage;

  String anUrl = "";

  final TextEditingController brandController = TextEditingController();

  final brandCollection = FirebaseFirestore.instance.collection('brands');

  @override
  Widget build(BuildContext context) {
    final kHeight = MediaQuery.of(context).size.height;
    final kWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhite.withOpacity(0),
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: Text("Add new".toUpperCase(),style: kTitleText,),
        leading: IconButton(
            icon: const Icon(
              CupertinoIcons.back,
              color: kBlack,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      forBottomSheet(context, kHeight,kWidth);
                    },
                    child: anImage == null
                        ? CircleAvatar(
                            radius: kHeight * 0.13,
                            backgroundColor: kBlack.withOpacity(0.1),
                            child: const Icon(
                              Icons.add_a_photo_outlined,
                              size: 50,
                              color: kBlack,
                            ),
                          )
                        : ContainerForImage( imagePath:anImage!.path),
                        
                  ),
                  SizedBox(height: kHeight * 0.02),
                  TheTextField(
                    anLabelText: "Brand name",
                    forMaxLine: null,
                    anController: brandController,
                    anType: TextInputType.name,
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                      shape: MaterialStatePropertyAll(
                        StadiumBorder(),
                      ),
                    ),
                    onPressed: () async {
                      addToFire(
                        anImage,
                        anUrl,
                        brandCollection,
                        brandCollection.doc().id,
                        brandController.text,
                      );

                      brandController.clear();

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
      ),
    );
  }

  Future<dynamic> forBottomSheet(
    BuildContext context,
    double kHeight,
    double kWidth,
  ) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: kHeight * 0.1,
        width: kWidth,
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

                setState(() {
                  anImage = pickImage;
                });
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }
}

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
  BrandAdding(
      anImageUrl: anUrl,
      anBrandName: theBrandName,
      anId: forAnId,
      anColectRef: forAddingRef);
}
