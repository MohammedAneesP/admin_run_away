import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:run_away_admin/application/brands/brand_display_bloc/brand_displaying_bloc.dart';
import 'package:run_away_admin/core/color_constants.dart';
import 'package:run_away_admin/core/constants/constants.dart';
import 'package:run_away_admin/presentation/brands/add_edit_brand/brand_adding.dart';
import 'package:run_away_admin/presentation/brands/add_edit_brand/brand_edit.dart';
import '../widgets/buttons/buttons.dart';

class BrandDetails extends StatelessWidget {
  BrandDetails({super.key});

  final TextEditingController brandController = TextEditingController();

  final TextEditingController brandUpdateController = TextEditingController();

  final brandCollection = FirebaseFirestore.instance.collection('brands');

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<BrandDisplayingBloc>(context).add(BrandDetaiLing());
    });
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
        child: BlocBuilder<BrandDisplayingBloc, BrandDisplayingState>(
          builder: (context, state) {
            if (state.brandFireResp.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 3,
                  mainAxisExtent: 250,
                ),
                itemCount: state.brandFireResp.length,
                itemBuilder: (context, index) {
                  final brandSnapshot = state.brandFireResp[index];

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
                                    child: TextButton(
                                        onPressed: () {
                                          BlocProvider.of<BrandDisplayingBloc>(
                                                  context)
                                              .add(BrandDeleting(
                                                  anBrandId: brandSnapshot[
                                                      "brandId"]));
                                          anSnackBarFunc(
                                            context: context,
                                            aText: "Deleted Successfully",
                                            anColor: Colors.grey,
                                          );
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Delete")),
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
                                              anId: brandSnapshot["brandId"],
                                            ),
                                          ),
                                        );
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
          },
        ),
      ),
    );
  }
}
