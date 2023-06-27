import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:run_away_admin/core/constants.dart';
import 'package:run_away_admin/models/brand/brand_editing_class.dart';
import 'package:run_away_admin/presentation/widgets/image_container.dart';
import 'package:run_away_admin/presentation/widgets/textfield.dart';

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
  final brandCollection = FirebaseFirestore.instance.collection('brands');

  String imageUrl = "";

  XFile? anUpdateUrl;

  TextEditingController updateController = TextEditingController();

  Future<void> updateImage() async {
    final pickImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickImage == null) {
      return;
    }

    setState(() {
      anUpdateUrl = pickImage;
    });
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    imageUrl = widget.brandImage;
    updateController.text = widget.brandNameText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final kHeight = MediaQuery.of(context).size.height;
    final kWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
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
                                    updateImage();
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
                child: anUpdateUrl == null
                    ? ContainerForNetworkImage(
                        // kHeight: kHeight * .35,
                        // kWidth: kWidth * 0.655,
                        imagePath: widget.brandImage,
                      )
                    : ContainerForImage(
                        // kHeight: kHeight,
                        // kWidth: kWidth,
                        imagePath: anUpdateUrl!.path,
                      ),
              ),
              SizedBox(height: kHeight * 0.03),
              TheTextField(
                anLabelText: "Brand name",
                forMaxLine: null,
                anController: updateController,
                anType: TextInputType.name,
              ),
              SizedBox(
                height: kHeight * 0.03,
              ),
              ElevatedButton(
                style: const ButtonStyle(
                  shape: MaterialStatePropertyAll(
                    StadiumBorder(),
                  ),
                ),
                child: const Text(
                  "Update",
                ),
                onPressed: () async {
                  final imageToUpdate =
                      FirebaseStorage.instance.refFromURL(widget.brandImage);
                  await imageToUpdate.putFile(File(anUpdateUrl!.path));
                  final anImageUrl = await imageToUpdate.getDownloadURL();

                  EditingBrand(
                    brandId: widget.anId,
                    brandNameUp: updateController.text,
                    imageUrlUp: anImageUrl,
                    collectionName: brandCollection,
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
