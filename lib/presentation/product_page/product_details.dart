
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:run_away_admin/core/color_constants.dart';
import 'package:run_away_admin/core/constants.dart';
import 'package:run_away_admin/presentation/brands/widgets/buttons.dart';
import 'package:run_away_admin/presentation/product_page/add_edit_pro/product_adding.dart';
import 'package:run_away_admin/presentation/product_page/add_edit_pro/product_edit.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final kHeight = MediaQuery.of(context).size.height;
    final kWidth = MediaQuery.of(context).size.width;
    final productRef = FirebaseFirestore.instance.collection("products");

    return Scaffold(
      backgroundColor: kWhite.withOpacity(0.95),
      floatingActionButton: FloatingActionButton(
        child: const Icon(CupertinoIcons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ProductAddingScreen(),
            ),
          );
        },
      ),
      appBar: AppBar(
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
          icon: const Icon(
            CupertinoIcons.back,
            color: kBlack,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: productRef.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasData) {
              return SizedBox(
                height: kHeight,
                child: GridView.builder(
                  itemCount: snapshot.data!.docs.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 5,
                    mainAxisExtent: 240,
                  ),
                  itemBuilder: (context, index) {
                    final productSnap = snapshot.data!.docs[index];
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
                                        child: DeleteDocButton(
                                          theDeleteId: productSnap.id,
                                          anCollection: productRef,
                                        ),
                                      ),
                                      PopupMenuItem(
                                        child: AnEditButton(
                                          anOnPressed: () async {
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
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ];
                                  },
                                )
                              ],
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: kHeight * .131,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        productSnap["productImages"][0]),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  StreamBuilder(
                                    stream: brandName.snapshots(),
                                    builder: (context, AsyncSnapshot snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data["brandName"]
                                              .toString()
                                              .toUpperCase(),
                                          style: kitalicSmallText,
                                        );
                                      }
                                      return const Text("Loading ... ");
                                    },
                                  ),
                                  Text(
                                    "${productSnap["itemName"]}".toUpperCase(),
                                    style: kSubTitleText,
                                  ),
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
            return const Center(
              child: Text(" Collection not added"),
            );
          },
        ),
      ),
    );
  }
}
