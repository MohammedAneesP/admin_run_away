import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:run_away_admin/core/color_constants.dart';
import 'package:run_away_admin/core/constants.dart';
import 'package:run_away_admin/presentation/cateegory/adding_brand/brand_add.dart';
import 'package:run_away_admin/presentation/product_page/product_details.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    final kHeight = MediaQuery.of(context).size.height;
    final kWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0),
        centerTitle: true,
        title: Text(
          "Hello Admin..!",
          style: kTitleText,
        ),
        shadowColor: Colors.white.withOpacity(0),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.bag,
              color: kBlack,
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            CupertinoIcons.circle_grid_3x3_fill,
            color: kBlack,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: kHeight * 0.1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "Brands",
                        style: kTitleText,
                      ),
                      Container(
                        height: kHeight * 0.25,
                        width: kWidth * .45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => BrandDetails(),
                              ),
                            );
                          },
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Positioned(
                                left: 5,
                                child: Transform.rotate(
                                  angle: 12.53,
                                  child: StackImage(
                                    kHeight: kHeight * .16,
                                    kWidth: kWidth * .22,
                                    imageName: "assets/adidas.png",
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 5,
                                child: Transform.rotate(
                                  angle: 6.37,
                                  child: StackImage(
                                      kHeight: kHeight * .16,
                                      kWidth: kWidth * .22,
                                      imageName: "assets/nike.png"),
                                ),
                              ),
                              Positioned(
                                top: 28,
                                child: StackImage(
                                    kHeight: kHeight * .17,
                                    kWidth: kWidth * .21,
                                    imageName: "assets/puma.png"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Products",
                        style: kTitleText,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProductDetails(),
                            ),
                          );
                        },
                        child: Container(
                          height: kHeight * 0.25,
                          width: kWidth * .45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                          ),
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Positioned(
                                left: 5,
                                child: Transform.rotate(
                                  angle: 12.53,
                                  child: StackImage(
                                    kHeight: kHeight * .16,
                                    kWidth: kWidth * .22,
                                    imageName: "assets/landing_pic_3.png",
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 5,
                                child: Transform.rotate(
                                  angle: 6.37,
                                  child: StackImage(
                                    kHeight: kHeight * .16,
                                    kWidth: kWidth * .22,
                                    imageName: "assets/landing_pic_2.png",
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 28,
                                child: StackImage(
                                    kHeight: kHeight * .17,
                                    kWidth: kWidth * .21,
                                    imageName: "assets/landing_pic_1.png"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: kHeight * 0.03),
              Row(
                children: [
                  Text(
                    "Customer Order's",
                    style: kTitleText,
                  ),
                ],
              ),
              SizedBox(height: kHeight * 0.03),
              Container(
                height: kHeight * .12,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 2,
                    )
                  ],
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
                child: SizedBox(
                  height: double.infinity,
                  child: ListTile(
                    title: Text(
                      "Nike Air Jordan",
                      style: kHeadingText,
                    ),
                    subtitle: Text(
                      "Price : 13,000",
                      style: kSubTitleText,
                    ),
                    trailing: Container(
                      height: kHeight * 0.75,
                      width: kWidth * 0.26,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage(
                          "assets/landing_pic_3.png",
                        ),
                        fit: BoxFit.cover,
                      )),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class StackImage extends StatelessWidget {
  const StackImage(
      {super.key,
      required this.kHeight,
      required this.kWidth,
      required this.imageName});

  final double kHeight;
  final double kWidth;
  final String imageName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kHeight,
      width: kWidth,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 5)
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(
            imageName,
          ),
        ),
      ),
    );
  }
}
