import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:run_away_admin/core/constants.dart';
import 'package:run_away_admin/models/product/adding_products_class.dart';
import 'package:run_away_admin/presentation/widgets/image_container.dart';
import 'package:run_away_admin/presentation/widgets/round_button.dart';
import 'package:run_away_admin/presentation/widgets/textfield.dart';

final List<dynamic> shoeSize = [6, 7, 8, 9, 10, 11, 12];

final List<dynamic> addingSize = [];

class ProductAddingScreen extends StatefulWidget {
  const ProductAddingScreen({super.key});

  @override
  State<ProductAddingScreen> createState() => _ProductAddingScreenState();
}

class _ProductAddingScreenState extends State<ProductAddingScreen> {
  XFile? anImage;
  List<dynamic> listOfProductImg = [];
  final List<dynamic> downloadUrls = [];
  final Set<String> brandList = {};
  final Set<String> brandId = {};
  String? anSelected;

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptController = TextEditingController();

  final productRef = FirebaseFirestore.instance.collection("products");
  final brandREf = FirebaseFirestore.instance.collection("brands");

  @override
  Widget build(BuildContext context) {
    final kHeight = MediaQuery.of(context).size.height;
    final kWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add new".toUpperCase(),
          style: kTitleText,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: SizedBox(
                      height: kHeight * 0.3,
                      width: kWidth * 0.9,
                      child: listOfProductImg.isEmpty
                          ? const Center(
                              child: Icon(
                                CupertinoIcons.photo_fill_on_rectangle_fill,
                                size: 150,
                              ),
                            )
                          : ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: listOfProductImg.length,
                              separatorBuilder: (context, index) => SizedBox(
                                width: kWidth * 0.03,
                              ),
                              itemBuilder: (context, index) {
                                return ContainerForImage(
                                  // kHeight: kHeight * 0.06,
                                  // kWidth: kWidth * .7,
                                  imagePath: listOfProductImg[index].path,
                                );
                              },
                            ),
                    ),
                  ),
                  ElevatedButton(
                    style: buttonStyleRound,
                    onPressed: () async {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => SizedBox(
                          height: kHeight * 0.1,
                          child: Column(
                            children: [
                              const Text("Choose Image"),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      final pickImage = await ImagePicker()
                                          .pickImage(
                                              source: ImageSource.gallery);

                                      setState(() {
                                        if (pickImage != null) {
                                          listOfProductImg.add(pickImage);
                                        }
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    icon: const Icon(
                                      CupertinoIcons.photo_fill,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Add picture",
                    ),
                  ),
                  TheTextField(
                    anLabelText: "Product name",
                    anController: nameController,
                    forMaxLine: null,
                    anType: TextInputType.name,
                  ),
                  SizedBox(height: kHeight * 0.005),
                  TheTextField(
                    anLabelText: "Product price",
                    anController: priceController,
                    forMaxLine: null,
                    anType: TextInputType.number,
                  ),
                  SizedBox(height: kHeight * 0.005),
                  TheTextField(
                    anLabelText: "Description",
                    anController: descriptController,
                    forMaxLine: 5,
                    anType: TextInputType.name,
                  ),
                  SizedBox(height: kHeight * 0.008),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 320, 0),
                    child: Text(
                      "Size :",
                      style: kSubTitleText,
                    ),
                  ),
                  SizedBox(
                    height: kHeight * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizeButton(anSize: shoeSize[0], sizeList: addingSize),
                      SizeButton(anSize: shoeSize[1], sizeList: addingSize),
                      SizeButton(anSize: shoeSize[2], sizeList: addingSize),
                      SizeButton(anSize: shoeSize[3], sizeList: addingSize),
                      SizeButton(anSize: shoeSize[4], sizeList: addingSize),
                      SizeButton(anSize: shoeSize[5], sizeList: addingSize),
                    ],
                  ),
                  SizedBox(height: kHeight * 0.015),
                  StreamBuilder(
                    stream: brandREf.snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        final brandSnapShot = snapshot.data!.docs;

                        for (var i = 0; i < brandSnapShot.length; i++) {
                          brandList
                              .add(brandSnapShot[i]["brandName"].toString());
                          brandId.add(brandSnapShot[i]["brandId"].toString());
                        }

                        return DropdownButton<String>(
                          value: anSelected,
                          items: brandList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              anSelected = value;
                            });
                          },
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                  ElevatedButton(
                    style: buttonStyleRound,
                    onPressed: () async {
                    
                      final fireStorageRef = FirebaseStorage.instance;
                      for (var element in listOfProductImg) {
                        final uniqueName = DateTime.now().toString();
                        final file = File(element.path);

                        final toStorage = await fireStorageRef
                            .ref()
                            .child("image/$uniqueName")
                            .putFile(file);

                        downloadUrls.add(await toStorage.ref.getDownloadURL());
                      }
                      final forBrandId = brandId.toList();
                      final forBrandName = brandList.toList();
                      

                      final theIndex = forBrandName
                          .indexWhere((element) => element == anSelected);

                      

                      ProductAddingClass().addinProduct(
                        proAddRef: productRef,
                        theItemName: nameController.text,
                        theItemPrice: priceController.text,
                        theDescription: descriptController.text,
                        theImageUrls: downloadUrls,
                        theSize: addingSize,
                        oneId: productRef.doc().id,
                        brandId: forBrandId[theIndex],
                      );
                      addingSize.clear();
                      brandList.clear();
                      brandId.clear();
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
}
