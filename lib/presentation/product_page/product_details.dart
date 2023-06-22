import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:run_away_admin/core/color_constants.dart';
import 'package:run_away_admin/core/constants.dart';
import 'package:run_away_admin/presentation/product_page/add_edit_pro/product_adding.dart';
import 'package:run_away_admin/presentation/product_page/add_edit_pro/product_edit.dart';

class ProductDetails extends StatelessWidget {
  final String anId;
  final String brandName;
  const ProductDetails({super.key, required this.anId, required this.brandName});


  @override
  Widget build(BuildContext context) {

    final kHeight = MediaQuery.of(context).size.height;
    final kWidth = MediaQuery.of(context).size.width;
    final brandRef = FirebaseFirestore.instance
        .collection("admin")
        .doc(anId)
        .collection("shoe");

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(CupertinoIcons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProductAddingScreen(
                anId: anId,
              ),
            ),
          );
        },
      ),
      appBar: AppBar(
        shadowColor: kWhite.withOpacity(0),
        backgroundColor: kWhite,
        centerTitle: true,
        title: Text(
          brandName.toUpperCase(),
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
          stream: brandRef.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(

                itemCount: snapshot.data!.docs.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 250,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 5,
                  mainAxisExtent: 300,
                ),
                itemBuilder: (context, index) {
                  final productSnap = snapshot.data!.docs[index];
                  return Container(
                    height: kHeight * 1,
                    width: kWidth * 1,
                    decoration: BoxDecoration(
                      color: kBlack.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  CupertinoIcons.delete,
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text(
                                        "Do you want to delete this product ?",
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () async {
                                              await brandRef
                                                  .doc(snapshot
                                                      .data!.docs[index].id)
                                                  .delete();
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("YES")),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("NO"))
                                      ],
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(CupertinoIcons.pencil),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ProductEdit(
                                        brandId: anId,
                                        productId: productSnap["id"],
                                        productName: productSnap["itemName"],
                                        description: productSnap["description"],
                                        productPrice: productSnap["price"],
                                        listOfImages:
                                            productSnap["productImages"],
                                        shoeSizes: productSnap["shoeSize"],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: kHeight * .17,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      productSnap["productImages"][0]),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          Text("${productSnap["itemName"]}".toUpperCase()),
                          Text("Price : ${productSnap["price"]}"),
                        ],
                      ),
                    ),
                  );
                },
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
