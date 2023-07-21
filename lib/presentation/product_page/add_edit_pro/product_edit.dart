import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:run_away_admin/application/drop_down_bloc/drop_brand_bloc.dart';
import 'package:run_away_admin/application/products/pro_edit_image/product_edit_image_bloc.dart';
import 'package:run_away_admin/application/products/product_display_bloc/product_display_bloc.dart';
import 'package:run_away_admin/application/products/product_edit_bloc/product_edit_bloc.dart';
import 'package:run_away_admin/core/constants/constants.dart';
import 'package:run_away_admin/infrastructure/repositories/firebase/product/product_updating.dart';
import 'package:run_away_admin/presentation/product_page/add_edit_pro/product_adding.dart';
import 'package:run_away_admin/presentation/widgets/for_image/image_container.dart';
import 'package:run_away_admin/presentation/widgets/buttons/round_button.dart';
import 'package:run_away_admin/presentation/widgets/textfield.dart';
import 'widgets/drop_down_widget.dart';

class ProductEdit extends StatelessWidget {
  final String brandId;
  final String productId;
  final String productName;
  final String productPrice;
  final String description;
  final List<dynamic> listOfImages;
  final List<dynamic> shoeSizes;

  ProductEdit({
    super.key,
    required this.brandId,
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.description,
    required this.listOfImages,
    required this.shoeSizes,
  });

  List<dynamic> editSizeList = [];
  List<dynamic> imageList = [];
  List<dynamic> imageXfile = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptController = TextEditingController();

  final brandREf = FirebaseFirestore.instance.collection("brands");

  dynamic anSelected;
  Set<String> brandList = {};
  Set<String> theBrandId = {};

  @override
  Widget build(BuildContext context) {
    final brandRefName =
        FirebaseFirestore.instance.collection("brands").doc(brandId);
    BlocProvider.of<ProductEditBloc>(context)
        .add(EditProductData(anId: productId));
    BlocProvider.of<ProductEditImageBloc>(context)
        .add(ProductNetImagesDisply(anId: productId));

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Edit".toUpperCase(),
          style: kHeadingText,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: BlocBuilder<ProductEditBloc, ProductEditState>(
              builder: (context, state) {
                if (state.anData.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  nameController.text = state.anData["itemName"];
                  priceController.text = state.anData["price"];
                  descriptController.text = state.anData["description"];
                  editSizeList = state.anData["shoeSize"];
                  return Column(
                    children: [
                      SizedBox(
                        height: 280,
                        width: 360,
                        child: BlocBuilder<ProductEditImageBloc,
                            ProductEditImageState>(
                          builder: (context, state) {
                            return ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 10),
                              scrollDirection: Axis.horizontal,
                              itemCount: state.firImages.length,
                              itemBuilder: (context, index) {
                                return Stack(
                                  children: [
                                    ContainerForNetworkImage(
                                        imagePath: state.firImages[index]),
                                    Positioned(
                                      top: 205,
                                      left: 250,
                                      child: BlocProvider(
                                        create: (context) =>
                                            ProductEditImageBloc(),
                                        child: IconButton(
                                          onPressed: () {
                                            BlocProvider.of<
                                                        ProductEditImageBloc>(
                                                    context)
                                                .add(ProductRemoveImage(
                                                    index: index,
                                                    anId: productId));
                                          },
                                          icon: const Icon(
                                              CupertinoIcons.delete,
                                              size: 45),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        style: buttonStyleRoundSmall,
                        onPressed: () async {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => SizedBox(
                              height: 80,
                              child: Column(
                                children: [
                                  const Text("Choose Image"),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      BlocProvider(
                                        create: (context) =>
                                            ProductEditImageBloc(),
                                        child: IconButton(
                                          onPressed: () async {
                                            BlocProvider.of<
                                                        ProductEditImageBloc>(
                                                    context)
                                                .add(ProductImageEditAdd(
                                                    anId: productId));
                                            Navigator.of(context).pop();
                                          },
                                          icon: const Icon(
                                              CupertinoIcons.photo_fill,
                                              size: 30),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        child: const Text("Add picture"),
                      ),
                      const SizedBox(height: 8),
                      TheTextField(
                          anLabelText: "product name",
                          forMaxLine: null,
                          anController: nameController,
                          anType: TextInputType.name),
                      const SizedBox(height: 8),
                      TheTextField(
                          anLabelText: "Product price",
                          forMaxLine: null,
                          anController: priceController,
                          anType: TextInputType.number),
                      const SizedBox(height: 8),
                      TheTextField(
                          anLabelText: "Description",
                          forMaxLine: 5,
                          anController: descriptController,
                          anType: TextInputType.name),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 320, 0),
                        child: Text("Size :", style: kSubTitleText),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          SizeButton(
                              anSize: shoeSize[0], sizeList: editSizeList),
                          SizeButton(
                              anSize: shoeSize[1], sizeList: editSizeList),
                          SizeButton(
                              anSize: shoeSize[2], sizeList: editSizeList),
                          SizeButton(
                              anSize: shoeSize[3], sizeList: editSizeList),
                          SizeButton(
                              anSize: shoeSize[4], sizeList: editSizeList),
                          SizeButton(
                              anSize: shoeSize[5], sizeList: editSizeList),
                        ],
                      ),
                      const SizedBox(height: 5),
                      StreamBuilder(
                        stream: brandREf.snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            final brandSnapShot = snapshot.data!.docs;

                            for (var i = 0; i < brandSnapShot.length; i++) {
                              brandList.add(
                                  brandSnapShot[i]["brandName"].toString());
                              theBrandId
                                  .add(brandSnapShot[i]["brandId"].toString());
                            }

                            return StreamBuilder(
                              stream: brandREf.snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasData) {
                                  final brandSnapShot = snapshot.data!.docs;

                                  for (var i = 0;
                                      i < brandSnapShot.length;
                                      i++) {
                                    brandList.add(brandSnapShot[i]["brandName"]
                                        .toString());
                                    theBrandId.add(
                                        brandSnapShot[i]["brandId"].toString());
                                  }
                                  return BlocBuilder<DropBrandBloc,
                                      DropBrandState>(
                                    builder: (context, state) {
                                      return DropOptionsBrand(
                                        brandNames: brandList,
                                        anHint: StreamBuilder(
                                          stream: brandRefName.snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return Text(
                                                  snapshot.data!["brandName"]);
                                            } else {
                                              return const CircularProgressIndicator();
                                            }
                                          },
                                        ),
                                        anOption: anSelected,
                                        anOnChange: (value) {
                                          anSelected = value;
                                          BlocProvider.of<DropBrandBloc>(
                                                  context)
                                              .add(
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
                                    child: CircularProgressIndicator());
                              },
                            );
                          }
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      ),
                      ElevatedButton(
                        
                          style: buttonStyleRound,
                          
                          onPressed: () async {
                            showDialog(
                              context: context,
                              builder: (context) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                            final forBrandId = theBrandId.toList();
                            final forBrandName = brandList.toList();
                            final theIndex = forBrandName
                                .indexWhere((element) => element == anSelected);

                            forUpdateProDuct(
                                brandId: forBrandId[theIndex],
                                productId: productId,
                                productName: nameController.text,
                                productPrize: priceController.text,
                                productDescription: descriptController.text,
                                imageList: forFireImages.toList(),
                                shoeSize: editSizeList);
                            BlocProvider.of<ProductDisplayBloc>(context)
                                .add(ProductsDisplaying());
                            forFireImages.clear();
                            brandList.clear();
                            theBrandId.clear();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            anSnackBarFunc(
                                context: context,
                                aText: "Updated Successfully",
                                anColor: Colors.blueAccent);
                          },
                          child: const Text("Update")),
                      const SizedBox(height: 5),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
