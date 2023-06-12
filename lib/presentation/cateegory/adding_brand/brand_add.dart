import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:run_away_admin/core/color_constants.dart';
import 'package:run_away_admin/core/constants.dart';
import 'package:run_away_admin/presentation/cateegory/adding_brand/adding_data.dart';
import 'package:run_away_admin/presentation/cateegory/brand_edit.dart';

class BrandDetails extends StatelessWidget {
   BrandDetails({super.key});

  
  XFile? anImage;

  
  String ah = "kop";
  TextEditingController brandController = TextEditingController();

  TextEditingController brandUpdateController = TextEditingController();

  final brandCollection = FirebaseFirestore.instance.collection('admin');

 

  @override
  Widget build(BuildContext context) {
    log(ah);
    final kHeight = MediaQuery.of(context).size.height;
    final kWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddingData(),
          ));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Brands",
          style: kTitleText,
        ),
        shadowColor: Colors.white.withOpacity(0),
        backgroundColor: Colors.white,
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
      body: StreamBuilder(
        stream: brandCollection.orderBy("brandName").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 250,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 5,
                  mainAxisExtent: 300,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot brandSnapshot =
                      snapshot.data!.docs[index];
                  // print(brandSnapshot.id);
                  return SizedBox(
                    height: kHeight * 1,
                    width: kWidth * 1,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                brandCollection
                                    .doc(snapshot.data!.docs[index].id)
                                    .delete();
                              },
                              icon: const Icon(
                                CupertinoIcons.delete,
                                size: 30,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.edit,
                                size: 30,
                              ),
                              onPressed: () {
                                print(brandSnapshot.id);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => EditBrand(
                                      brandImage: brandSnapshot["imageName"],
                                      brandNameText: brandSnapshot["brandName"],
                                      anId: brandSnapshot.id,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        Container(
                          height: kHeight * .17,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                brandSnapshot["imageName"],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: kHeight * 0.05,
                        ),
                        Text(brandSnapshot["brandName"]),
                      ],
                    ),
                  );
                });
          }
          return Container(
            height: 50,
            width: 50,
            color: Colors.amber,
          );
        },
      ),
    );
  }
}
