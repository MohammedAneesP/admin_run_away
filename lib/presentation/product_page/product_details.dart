import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:run_away_admin/presentation/product_page/add_edit_pro/product_adding.dart';

class ProductDetails extends StatelessWidget {
  final String anId;
  ProductDetails({super.key, required this.anId, required brandName});

  final shouUnique = DateTime.now().toString();

  @override
  Widget build(BuildContext context) {
    final kHeight = MediaQuery.of(context).size.height;
    final kWidth = MediaQuery.of(context).size.width;
    final brandRef = FirebaseFirestore.instance
        .collection("admin")
        .doc(anId)
        .collection("new");

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
          centerTitle: true,
          title: const Text(
            "Nike",
          ),
        ),
        body: StreamBuilder(
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
                      color: Colors.black12.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text(
                                    "Do you want to delete this product ?",
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {},
                                        child: const Text("YES")),
                                    TextButton(
                                        onPressed: () {},
                                        child: const Text("NO"))
                                  ],
                                ),
                              );
                            },
                            icon: const Icon(
                              CupertinoIcons.delete,
                            ),
                          ),
                          Container(
                            height: kHeight * .17,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/landing_pic_2.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text("${productSnap["shoeName"]}"),
                          Text("Price : ${productSnap["price"]}"),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return const CircularProgressIndicator();
          },
        ));
  }
}

class TheTextField extends StatelessWidget {
  const TheTextField({
    super.key,
    required this.anLabelText,
    required this.forMaxLine,
    required this.anController,
    required this.anType,
  });
  final String anLabelText;
  final int? forMaxLine;
  final TextInputType anType;
  final TextEditingController anController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: anController,
      textAlign: TextAlign.start,
      maxLines: forMaxLine,
      keyboardType: anType,
      decoration: InputDecoration(
        labelText: anLabelText,
        alignLabelWithHint: true,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
