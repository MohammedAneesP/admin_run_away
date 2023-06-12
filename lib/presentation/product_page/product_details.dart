import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductDetails extends StatelessWidget {
  ProductDetails({super.key});
  XFile? anImage;
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptController = TextEditingController();

  // final  brandCollection =
  //     FirebaseFirestore.instance.collection('admin');

  // void addBrand({
  //   required String name,
  //   required String price,
  //   required String description,
  // }) {
  //   final adding = {
  //     "name": name,
  //     "price": price,
  //     "descrition": description,
  //   };
  //   brandCollection.add(adding);
  // }

  @override
  Widget build(BuildContext context) {
    final kHeight = MediaQuery.of(context).size.height;
    final kWidth = MediaQuery.of(context).size.width;
    final shoeSize = [6, 7, 8, 9, 10, 11, 12];
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => SingleChildScrollView(
              child: AlertDialog(
                title: GestureDetector(
                  onTap: () {
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
                                    final pickImage =
                                        await ImagePicker().pickImage(
                                      source: ImageSource.camera,
                                    );

                                    anImage = pickImage!;
                                  },
                                  icon: const Icon(
                                    CupertinoIcons.camera_fill,
                                    size: 30,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    final pickImage =
                                        await ImagePicker().pickImage(
                                      source: ImageSource.gallery,
                                    );
                                    anImage = pickImage!;
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
                  child: SizedBox(
                    height: kHeight * 0.3,
                    width: kWidth * 0.9,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Stack(
                        children: [
                          const CircleAvatar(
                            radius: 150,
                          ),
                          Positioned(
                            left: 200,
                            bottom: 40,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                CupertinoIcons.photo_camera,
                                size: 60,
                                color: Colors.black26,
                              ),
                            ),
                          ),
                        ],
                      ),
                      itemCount: 4,
                    ),
                  ),
                ),
                content: Column(
                  children: [
                    TheTextField(
                      anLabelText: "Product name",
                      anController: nameController,
                      forMaxLine: null,
                    ),
                    SizedBox(height: kHeight * 0.005),
                    TheTextField(
                      anLabelText: "Product price",
                      anController: priceController,
                      forMaxLine: null,
                    ),
                    SizedBox(height: kHeight * 0.005),
                    TheTextField(
                      anLabelText: "Description",
                      anController: descriptController,
                      forMaxLine: 5,
                    ),
                    SizedBox(height: kHeight * 0.008),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Size",
                        ),
                        SizedBox(
                          height: kHeight * 0.05,
                          width: kWidth * 0.9,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {},
                              child: CircleAvatar(
                                radius: 20,
                                child: Text(
                                  shoeSize[index].toString(),
                                ),
                              ),
                            ),
                            itemCount: shoeSize.length,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: kHeight * 0.015),
                    ElevatedButton(
                      onPressed: ()  {
                        // addBrand(
                        //   name: nameController.text,
                        //   price: priceController.text,
                        //   description: descriptController.text,
                        // );
                        log(nameController.text);
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Continue",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Nike",
        ),
      ),
      body: GridView.builder(
        itemCount: 6,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 250,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 5,
          mainAxisExtent: 300,
        ),
        itemBuilder: (context, index) {
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
                                onPressed: () {}, child: const Text("YES")),
                            TextButton(
                                onPressed: () {}, child: const Text("NO"))
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
                  const Text("Product Name"),
                  const Text("Prize :"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class TheTextField extends StatelessWidget {
  const TheTextField({
    super.key,
    required this.anLabelText,
    required this.forMaxLine,
    required this.anController,
  });
  final String anLabelText;
  final int? forMaxLine;
  final TextEditingController anController;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: anController,
      textAlign: TextAlign.start,
      maxLines: forMaxLine,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        labelText: anLabelText,
        alignLabelWithHint: true,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
