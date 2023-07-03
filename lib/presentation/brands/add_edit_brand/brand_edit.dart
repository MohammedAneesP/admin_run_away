import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:run_away_admin/application/brand_image_bloc/brand_image_bloc.dart';
import 'package:run_away_admin/application/edit_brand_bloc/edit_brand_details_bloc.dart';
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

  @override
  void initState() {
    updateController.text = widget.brandNameText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<EditBrandDetailsBloc>(context)
        .add(EditBrandData(anId: widget.anId));
    final kHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("edit".toUpperCase(), style: kTitleText),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<EditBrandDetailsBloc, EditBrandDetailsState>(
          builder: (context, state) {
            if (state.anBrandMap.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.anBrandMap.isNotEmpty) {
              imageUrl = state.anBrandMap["imageName"];
              return SafeArea(
                child: Center(
                  child: Column(
                    children: [
                      GestureDetector(onTap: () async {
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      BlocProvider(
                                        create: (context) => BrandImageBloc(),
                                        child: IconButton(
                                          onPressed: () async {
                                            BlocProvider.of<BrandImageBloc>(
                                                    context)
                                                .add(AddingImage());
                                            Navigator.of(context).pop();
                                          },
                                          icon: const Icon(
                                            CupertinoIcons.photo_fill,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }, child: BlocBuilder<BrandImageBloc, BrandImageState>(
                        builder: (context, state) {
                          anUpdateUrl = state.anImage;
                          return state.anImage == null
                              ? ContainerForNetworkImage(
                                  imagePath: imageUrl,
                                )
                              : ContainerForImage(
                                  imagePath: anUpdateUrl!.path,
                                );
                        },
                      )),
                      SizedBox(height: kHeight * 0.02),
                      TheTextField(
                        anLabelText: "Brand name",
                        forMaxLine: null,
                        anController: updateController,
                        anType: TextInputType.name,
                      ),
                      SizedBox(
                        height: kHeight * 0.02,
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
                          final imageToUpdate = FirebaseStorage.instance
                              .refFromURL(widget.brandImage);
                          await imageToUpdate.putFile(File(anUpdateUrl!.path));
                          final anImageUrl =
                              await imageToUpdate.getDownloadURL();

                          EditingBrand(
                            brandId: widget.anId,
                            brandNameUp: updateController.text,
                            imageUrlUp: anImageUrl,
                            collectionName: brandCollection,
                          );
                          anSnackBarFunc(
                            context: context,
                            aText: "Successfully updated",
                            anColor: Colors.green,
                          );
                          updateController.clear();
                          BlocProvider.of<BrandImageBloc>(context)
                              .add(RemoveImage());
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text("An Error occured"),
              );
            }
          },
        ),
      ),
    );
  }
}


