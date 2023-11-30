import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:run_away_admin/application/products/drop_down_bloc/drop_brand_bloc.dart';
import 'package:run_away_admin/application/products/product_display_bloc/product_display_bloc.dart';
import 'package:run_away_admin/application/products/product_image/product_image_bloc.dart';
import 'package:run_away_admin/core/color_constants.dart';
import 'package:run_away_admin/core/constants/constants.dart';
import 'package:run_away_admin/infrastructure/repositories/firebase/product/product_adding.dart';
import 'package:run_away_admin/presentation/widgets/for_image/image_container.dart';
import 'package:run_away_admin/presentation/widgets/buttons/round_button.dart';
import 'package:run_away_admin/presentation/widgets/textfield/textfield.dart';
import 'widgets/drop_down_widget.dart';

final List<dynamic> shoeSize = [6, 7, 8, 9, 10, 11, 12];
final List<dynamic> addingSize = [];
String? anSelected;

class ProductAddingScreen extends StatelessWidget {
  ProductAddingScreen({super.key});

  final List<dynamic> downloadUrls = [];
  final Set<String> brandList = {};
  final Set<String> brandId = {};

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptController = TextEditingController();

  final productRef = FirebaseFirestore.instance.collection("products");
  final brandREf = FirebaseFirestore.instance.collection("brands");

  final ValueNotifier<int> inStock = ValueNotifier(1);

  @override
  Widget build(BuildContext context) {
    final kHeight = MediaQuery.of(context).size.height;
    final kWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kWhite.withOpacity(0.95),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: kWhite.withOpacity(0),
        shadowColor: kWhite.withOpacity(0),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(CupertinoIcons.back)),
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
                      child: BlocBuilder<ProductImageBloc, ProductImageState>(
                        builder: (context, state) {
                          return state.imageList!.isEmpty
                              ? const Center(
                                  child: Icon(
                                    CupertinoIcons.photo_fill_on_rectangle_fill,
                                    size: 150,
                                  ),
                                )
                              : ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.imageList!.length,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    width: kWidth * 0.03,
                                  ),
                                  itemBuilder: (context, index) {
                                    return ContainerForImage(
                                      imagePath: state.imageList![index].path,
                                    );
                                  },
                                );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    style: buttonStyleRoundSmall,
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
                                  BlocProvider(
                                    create: (context) => ProductImageBloc(),
                                    child: IconButton(
                                      onPressed: () async {
                                        BlocProvider.of<ProductImageBloc>(
                                                context)
                                            .add(ProductImageAdding());

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
                        ),
                      );
                    },
                    child: const Text("Add picture"),
                  ),
                  SizedBox(height: kHeight * 0.02),
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
                      child: Text("Stock :", style: kSubTitleText)),
                  ValueListenableBuilder(
                    valueListenable: inStock,
                    builder: (context, value, child) {
                      return Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (inStock.value > 1) {
                                inStock.value -= 1;
                              } else {
                                return;
                              }
                            },
                            style: const ButtonStyle(
                                shape:
                                    MaterialStatePropertyAll(CircleBorder())),
                            child: const Icon(Icons.remove),
                          ),
                          Text(inStock.value.toString()),
                          ElevatedButton(
                            onPressed: () {
                              inStock.value += 1;
                            },
                            style: const ButtonStyle(
                                shape:
                                    MaterialStatePropertyAll(CircleBorder())),
                            child: const Icon(Icons.add),
                          ),
                        ],
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 320, 0),
                    child: Text(
                      "Size :",
                      style: kSubTitleText,
                    ),
                  ),
                  SizedBox(height: kHeight * 0.02),
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
                        return BlocBuilder<DropBrandBloc, DropBrandState>(
                          builder: (context, state) {
                            return DropOptionsBrand(
                              brandNames: brandList,
                              anHint: const Text("Select Brand"),
                              anOption: anSelected,
                              anOnChange: (value) {
                                anSelected = value;
                                BlocProvider.of<DropBrandBloc>(context).add(
                                  AnBrandSelect(
                                    theBrandString: value.toString(),
                                  ),
                                );
                              },
                            );
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
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      );
                      final fireStorageRef = FirebaseStorage.instance;
                      for (var element in theImageList) {
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

                      final theIndex = forBrandName.indexWhere(
                          (element) => element == anSelected.toString());

                      final Map<dynamic, dynamic> sizeStock = {};

                      // Loop through each element in the addingSize list.
                      for (var element in addingSize) {
                        // Set each element as a key in the sizeStock map.
                        sizeStock[element.toString()] =
                            inStock.value.toString();
                      }

                      addinProduct(
                        theItemName: nameController.text,
                        theItemPrice: priceController.text,
                        theDescription: descriptController.text,
                        theImageUrls: downloadUrls,
                        oneId: productRef.doc().id,
                        proAddRef: productRef,
                        stockAndSize: sizeStock,
                        brandId: forBrandId[theIndex],
                      );
                      if (context.mounted) {
                        BlocProvider.of<ProductImageBloc>(context)
                            .add(RemoveProductImage());
                        BlocProvider.of<ProductDisplayBloc>(context)
                            .add(ProductsDisplaying());
                        anSnackBarFunc(
                            context: context,
                            aText: "New Product added",
                            anColor: Colors.greenAccent);
                      }

                      addingSize.clear();
                      brandList.clear();
                      brandId.clear();
                      theImageList.clear();
                      anSelected = null;

                      if (context.mounted) {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }
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
