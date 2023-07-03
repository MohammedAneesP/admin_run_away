import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:run_away_admin/core/constants.dart';
import 'package:run_away_admin/models/product/updating_product_class.dart';
import 'package:run_away_admin/presentation/product_page/add_edit_pro/product_adding.dart';
import 'package:run_away_admin/presentation/widgets/image_container.dart';
import 'package:run_away_admin/presentation/widgets/round_button.dart';
import 'package:run_away_admin/presentation/widgets/textfield.dart';

class ProductEdit extends StatefulWidget {
  final String brandId;
  final String productId;
  final String productName;

  final String productPrice;
  final String description;
  final List<dynamic> listOfImages;
  final List<dynamic> shoeSizes;
  const ProductEdit({
    super.key,
    required this.brandId,
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.description,
    required this.listOfImages,
    required this.shoeSizes,
  });

  @override
  State<ProductEdit> createState() => _ProductEditState();
}

List<dynamic> editSizeList = [];
List<dynamic> imageList = [];
List<dynamic> imageXfile = [];

TextEditingController nameController = TextEditingController();
TextEditingController priceController = TextEditingController();
TextEditingController descriptController = TextEditingController();

class _ProductEditState extends State<ProductEdit> {
  @override
  void initState() {
    nameController.text = widget.productName;
    priceController.text = widget.productPrice;
    descriptController.text = widget.description;
    imageList = widget.listOfImages;
    editSizeList = widget.shoeSizes;
    super.initState();
  }

  final brandREf = FirebaseFirestore.instance.collection("brands");

  dynamic anSelected;

  Set<String> brandList = {};

  Set<String> theBrandId = {};

  @override
  Widget build(BuildContext context) {
    final brandRefName =
        FirebaseFirestore.instance.collection("brands").doc(widget.brandId);

    final kHeight = MediaQuery.of(context).size.height;
    final kWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Edit".toUpperCase(),
          style: kHeadingText,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: kHeight * 0.3,
                  width: kWidth * 0.9,
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        SizedBox(width: kWidth * 0.02),
                    scrollDirection: Axis.horizontal,
                    itemCount: imageList.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          ContainerForNetworkImage(
                            imagePath: imageList[index],
                          ),
                          Positioned(
                            top: 200,
                            left: 225,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  imageList.removeAt(index);
                                });
                              },
                              icon: const Icon(
                                CupertinoIcons.delete,
                                size: 45,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    final pickImage = await ImagePicker()
                                        .pickImage(source: ImageSource.gallery);
                                    final firebaseStorageRef =
                                        FirebaseStorage.instance;
                                    final uniqueName =
                                        DateTime.now().toString();
                                    final file = File(pickImage!.path);
                                    final toStorage = await firebaseStorageRef
                                        .ref()
                                        .child("image/$uniqueName")
                                        .putFile(file);
                                    imageList.add(
                                        await toStorage.ref.getDownloadURL());
                                    setState(() {});
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
                SizedBox(height: kHeight * 0.008),
                TheTextField(
                    anLabelText: "product name",
                    forMaxLine: null,
                    anController: nameController,
                    anType: TextInputType.name),
                SizedBox(height: kHeight * 0.008),
                TheTextField(
                  anLabelText: "Product price",
                  forMaxLine: null,
                  anController: priceController,
                  anType: TextInputType.number,
                ),
                SizedBox(height: kHeight * 0.008),
                TheTextField(
                  anLabelText: "Description",
                  forMaxLine: 5,
                  anController: descriptController,
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
                SizedBox(height: kHeight * 0.01),
                Row(
                  children: [
                    SizeButton(anSize: shoeSize[0], sizeList: editSizeList),
                    SizeButton(anSize: shoeSize[1], sizeList: editSizeList),
                    SizeButton(anSize: shoeSize[2], sizeList: editSizeList),
                    SizeButton(anSize: shoeSize[3], sizeList: editSizeList),
                    SizeButton(anSize: shoeSize[4], sizeList: editSizeList),
                    SizeButton(anSize: shoeSize[5], sizeList: editSizeList),
                  ],
                ),
                SizedBox(height: kHeight * 0.01),
                StreamBuilder(
                  stream: brandREf.snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      final brandSnapShot = snapshot.data!.docs;

                      for (var i = 0; i < brandSnapShot.length; i++) {
                        brandList.add(brandSnapShot[i]["brandName"]
                            .toString()
                            .toUpperCase());
                        theBrandId.add(brandSnapShot[i]["brandId"]
                            .toString()
                            .toUpperCase());
                      }

                      return DropdownButton<String>(
                        // hint: Text(snapshot.data!.docs[),
                        hint: StreamBuilder(
                          stream: brandRefName.snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(snapshot.data!["brandName"]);
                            }
                            return const Text("Select Brand");
                          },
                        ),
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
                      final forBrandId = theBrandId.toList();
                      final forBrandName = brandList.toList();

                      final theIndex = forBrandName
                          .indexWhere((element) => element == anSelected);

                      UpdatingProducts(
                        brandId: forBrandId[theIndex],
                        productId: widget.productId,
                        productName: nameController.text,
                        productPrize: priceController.text,
                        productDescription: descriptController.text,
                        imageList: imageList,
                        shoeSize: editSizeList,
                      );
                      Navigator.pop(context);
                    },
                    child: const Text("Update"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
