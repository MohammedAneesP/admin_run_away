import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:run_away_admin/core/color_constants.dart';
import 'package:run_away_admin/core/constants.dart';

class BrandDetails extends StatelessWidget {
  BrandDetails({super.key});

  XFile? anImage;

  @override
  Widget build(BuildContext context) {
    final kHeight = MediaQuery.of(context).size.height;
    final kWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => SingleChildScrollView(
              child: AlertDialog(
                title: GestureDetector(
                  onTap: () async {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => SizedBox(
                        height: kHeight * .1,
                        child: Column(
                          children: [
                            Text(
                              "Add picture",
                              style: kSubTitleText,
                            ),
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
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: const CircleAvatar(
                    radius: 150,
                  ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const TextField(
                      decoration: InputDecoration(
                        labelText: "Brand Name",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Add",
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
            )),
      ),
      body: GridView.builder(
        itemCount: 6,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 250,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 5,
            mainAxisExtent: 250),
        itemBuilder: (context, index) {
          return Container(
            height: kHeight * 1,
            width: kWidth * 1,
            decoration: BoxDecoration(
              color: Colors.black12.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/nike.png"),
                Text(
                  "Nike",
                  style: kSubTitleText,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
