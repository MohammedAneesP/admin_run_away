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
import 'package:run_away_admin/domain/models/brand/brand_editing_class.dart';
import 'package:run_away_admin/presentation/widgets/image_container.dart';
import 'package:run_away_admin/presentation/widgets/textfield.dart';

class EditBrand extends StatelessWidget {
   EditBrand({
    super.key,
    required this.brandImage,
    required this.brandNameText,
    required this.anId,
  });
  final String brandNameText;
  final String brandImage;
  final String anId;

 
  final brandCollection = FirebaseFirestore.instance.collection('brands');

  String imageUrl = "";
  XFile? anUpdateUrl;
  TextEditingController updateController = TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<EditBrandDetailsBloc>(context)
          .add(EditBrandData(anId: anId));
    });

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
              updateController.text = state.anBrandMap["brandName"];
              return SafeArea(
                child: Center(
                  child: Column(
                    children: [
                      GestureDetector(onTap: () async {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return SizedBox(
                              height: 80,
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
                      const SizedBox(height: 20),
                      TheTextField(
                        anLabelText: "Brand name",
                        forMaxLine: null,
                        anController: updateController,
                        anType: TextInputType.name,
                      ),
                      const SizedBox(height: 20),
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
                          showDialog(
                            context: context,
                            builder: (context) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                          final imageToUpdate = FirebaseStorage.instance
                              .refFromURL(brandImage);
                          await imageToUpdate.putFile(File(anUpdateUrl!.path));
                          final anImageUrl =
                              await imageToUpdate.getDownloadURL();

                          EditingBrand(
                            brandId: anId,
                            brandNameUp: updateController.text,
                            imageUrlUp: anImageUrl,
                            collectionName: brandCollection,
                          );
                          anSnackBarFunc(
                            context: context,
                            aText: "Successfully updated",
                            anColor: Colors.blue,
                          );
                          updateController.clear();
                          BlocProvider.of<BrandImageBloc>(context)
                              .add(RemoveImage());
                          Navigator.of(context).pop();
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
