import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:run_away_admin/application/products/product_display_bloc/product_display_bloc.dart';
import 'package:run_away_admin/core/color_constants.dart';
import 'package:run_away_admin/core/constants/constants.dart';
import 'package:run_away_admin/presentation/widgets/buttons/buttons.dart';
import 'package:run_away_admin/presentation/product_page/add_edit_pro/product_adding.dart';
import 'package:run_away_admin/presentation/product_page/add_edit_pro/product_edit.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<ProductDisplayBloc>(context).add(ProductsDisplaying());
    });
    final kHeight = MediaQuery.of(context).size.height;
    final kWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: kWhite.withOpacity(0.95),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        shadowColor: kWhite.withOpacity(0),
        backgroundColor: kWhite.withOpacity(0),
        centerTitle: true,
        title: Text(
          "Products".toUpperCase(),
          style: kTitleText,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(CupertinoIcons.back, color: kBlack),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(CupertinoIcons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ProductAddingScreen()),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<ProductDisplayBloc, ProductDisplayState>(
          builder: (context, state) {
            if (state.proFireResponse.isEmpty) {
              return const Center(
                child: Text("No product Added"),
              );
            } else {
              return SizedBox(
                height: kHeight,
                child: GridView.builder(
                  itemCount: state.proFireResponse.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 250,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 5,
                      mainAxisExtent: 240),
                  itemBuilder: (context, index) {
                    final productSnap = state.proFireResponse[index];
                    final brandName = FirebaseFirestore.instance
                        .collection("brands")
                        .doc(productSnap["brandId"]);

                    return Container(
                      height: kHeight * 1,
                      width: kWidth * 1,
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                PopupMenuButton(
                                  icon: const Icon(Icons.more_vert_sharp),
                                  itemBuilder: (context) {
                                    return [
                                      PopupMenuItem(
                                          child: TextButton(
                                              onPressed: () {
                                                BlocProvider.of<
                                                            ProductDisplayBloc>(
                                                        context)
                                                    .add(ProductDeleting(
                                                        anProductId:
                                                            productSnap[
                                                                "productId"]));
                                                Navigator.pop(context);
                                                anSnackBarFunc(
                                                  context: context,
                                                  aText: "Deleted Successfully",
                                                  anColor: Colors.grey,
                                                );
                                              },
                                              child: const Text("Delete"))),
                                      PopupMenuItem(
                                        child: AnEditButton(
                                          anOnPressed: () async {
                                            Navigator.pop(context);
                                            await Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductEdit(
                                                  brandId:
                                                      productSnap["brandId"],
                                                  productId:
                                                      productSnap["productId"],
                                                  productName:
                                                      productSnap["itemName"],
                                                  productPrice:
                                                      productSnap["price"],
                                                  description: productSnap[
                                                      "description"],
                                                  listOfImages: productSnap[
                                                      "productImages"],
                                                  shoeSizes:
                                                      productSnap["shoeSize"],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ];
                                  },
                                )
                              ],
                            ),
                            Container(
                              height: kHeight * .131,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        productSnap["productImages"][0]
                                            .toString()),
                                    fit: BoxFit.contain),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  StreamBuilder(
                                    stream: brandName.snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        if (snapshot.data!.exists) {
                                          return Text(
                                              snapshot.data!["brandName"]
                                                  .toString()
                                                  .toUpperCase(),
                                              style: kitalicSmallText);
                                        } else {
                                          return const Text(
                                              "brand name not found");
                                        }
                                      }
                                      return const Text("Loading ... ");
                                    },
                                  ),
                                  Text(
                                      "${productSnap["itemName"]}"
                                          .toUpperCase(),
                                      style: kSubTitleText),
                                  Text("Price : ${productSnap["price"]}"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
