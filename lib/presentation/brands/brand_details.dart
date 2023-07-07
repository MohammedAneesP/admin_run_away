import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:run_away_admin/core/color_constants.dart';
import 'package:run_away_admin/core/constants.dart';
import 'package:run_away_admin/presentation/brands/add_edit_brand/brand_adding.dart';
import 'package:run_away_admin/presentation/brands/add_edit_brand/brand_edit.dart';
import 'widgets/buttons.dart';

class BrandDetails extends StatelessWidget {
  BrandDetails({super.key});

  final TextEditingController brandController = TextEditingController();

  final TextEditingController brandUpdateController = TextEditingController();

  final brandCollection = FirebaseFirestore.instance.collection('brands');

  @override
  Widget build(BuildContext context) {
    final kHeight = MediaQuery.of(context).size.height;
    final kWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kWhite.withOpacity(0.95),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddingData(),
          ));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Brands",
          style: kTitleText,
        ),
        shadowColor: kWhite.withOpacity(0),
        backgroundColor: kWhite.withOpacity(0),
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
          stream: brandCollection.orderBy("brandName").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasData) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 3,
                  mainAxisExtent: 250,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot brandSnapshot =
                      snapshot.data!.docs[index];

                  return Container(
                    decoration: BoxDecoration(
                        color: kWhite, borderRadius: BorderRadius.circular(15)),
                    height: kHeight * 1,
                    width: kWidth * 1,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            PopupMenuButton(
                              icon:
                                  const Icon(CupertinoIcons.ellipsis_vertical),
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                    child: DeleteDocButton(
                                      theDeleteId: brandSnapshot.id,
                                      anCollection: brandCollection,
                                    ),
                                  ),
                                  PopupMenuItem(
                                    child: AnEditButton(
                                      anOnPressed: () async {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                        );
                                        Navigator.pop(context);

                                        Navigator.pop(context);
                                        await Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => EditBrand(
                                              brandImage:
                                                  brandSnapshot["imageName"],
                                              brandNameText:
                                                  brandSnapshot["brandName"],
                                              anId: brandSnapshot.id,
                                            ),
                                          ),
                                        );
                                        //
                                      },
                                    ),
                                  ),
                                ];
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
                                fit: BoxFit.contain),
                          ),
                        ),
                        SizedBox(
                          height: kHeight * 0.02,
                        ),
                        Text(
                          "${brandSnapshot["brandName"]}".toUpperCase(),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            return Container(
              height: 50,
              width: 50,
              color: Colors.amber,
            );
          },
        ),
      ),
    );
  }
}
