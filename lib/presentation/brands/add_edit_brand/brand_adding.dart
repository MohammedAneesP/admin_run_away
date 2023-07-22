import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:run_away_admin/application/brands/brand_display_bloc/brand_displaying_bloc.dart';
import 'package:run_away_admin/application/brands/brand_image_bloc/brand_image_bloc.dart';
import 'package:run_away_admin/core/color_constants.dart';
import 'package:run_away_admin/core/constants/constants.dart';
import 'package:run_away_admin/infrastructure/repositories/firebase/brand/brand_adding_class.dart';
import 'package:run_away_admin/presentation/brands/brand_details.dart';
import 'package:run_away_admin/presentation/widgets/for_image/image_container.dart';
import 'package:run_away_admin/presentation/widgets/textfield.dart';

class AddingData extends StatelessWidget {
  AddingData({super.key});

  XFile? theImage;

  String anUrl = "";

  final TextEditingController brandController = TextEditingController();

  final brandCollection = FirebaseFirestore.instance.collection('brands');

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<BrandDisplayingBloc>(context).add(BrandDetaiLing());
    final kHeight = MediaQuery.of(context).size.height;
    final kWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhite.withOpacity(0),
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Add new".toUpperCase(),
          style: kTitleText,
        ),
        leading: IconButton(
            icon: const Icon(
              CupertinoIcons.back,
              color: kBlack,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  GestureDetector(onTap: () async {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => SizedBox(
                        height: kHeight * 0.1,
                        width: kWidth,
                        child: Column(
                          children: [
                            Text(
                              "Add picture",
                              style: kSubTitleText,
                            ),
                            BlocProvider(
                              create: (context) => BrandImageBloc(),
                              child: IconButton(
                                icon: const Icon(
                                  CupertinoIcons.photo_fill,
                                  size: 30,
                                ),
                                onPressed: () async {
                                  BlocProvider.of<BrandImageBloc>(context)
                                      .add(AddingImage());

                                  Navigator.of(context).pop();
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }, child: BlocBuilder<BrandImageBloc, BrandImageState>(
                    builder: (context, state) {
                      if (state.anImage == null) {
                        return CircleAvatar(
                          radius: kHeight * 0.13,
                          backgroundColor: kBlack.withOpacity(0.1),
                          child: const Icon(
                            Icons.add_a_photo_outlined,
                            size: 50,
                            color: kBlack,
                          ),
                        );
                      } else {
                        theImage = state.anImage;
                        return ContainerForImage(imagePath: theImage!.path);
                      }
                    },
                  )),
                  SizedBox(height: kHeight * 0.02),
                  TheTextField(
                    anLabelText: "Brand name",
                    forMaxLine: null,
                    anController: brandController,
                    anType: TextInputType.name,
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                      foregroundColor: MaterialStatePropertyAll(kWhite),
                      backgroundColor: MaterialStatePropertyAll(Colors.blue),
                      shape: MaterialStatePropertyAll(
                        StadiumBorder(),
                      ),
                    ),
                    onPressed: ()async  {
                      showDialog(
                        context: context,
                        builder: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                     await ForAddingToFire().addToFire(
                        theImage,
                        anUrl,
                        brandController.text,
                        // brandCollection,
                        // brandCollection.doc().id,
                        
                      );
                      BlocProvider.of<BrandDisplayingBloc>(context)
                          .add(BrandDetaiLing());
                      BlocProvider.of<BrandImageBloc>(context)
                          .add(RemoveImage());
                      brandController.clear();
                      anSnackBarFunc(
                        context: context,
                        aText: "New Brand Added",
                        anColor: Colors.greenAccent,
                      );
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => BrandDetails(),
                      ));
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
