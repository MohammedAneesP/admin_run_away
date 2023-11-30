import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:run_away_admin/core/color_constants.dart';
import 'package:run_away_admin/core/constants/constants.dart';
import 'package:run_away_admin/domain/services/frbs_auth_methods.dart';
import 'package:run_away_admin/presentation/brands/brand_details.dart';
import 'package:run_away_admin/presentation/login_sign_up_pages/login_page.dart';
import 'package:run_away_admin/presentation/orders/orders.dart';
import 'package:run_away_admin/presentation/product_page/product_details.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    final kHeight = MediaQuery.of(context).size.height;
    final kWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kWhite.withOpacity(0.95),
      appBar: AppBar(
        backgroundColor: kWhite.withOpacity(0),
        centerTitle: true,
        title: Text(
          "Hello Admin..!",
          style: kTitleText,
        ),
        shadowColor: kWhite.withOpacity(0),
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(
              CupertinoIcons.square_grid_2x2_fill,
              color: kBlack,
            ),
          );
        }),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: kWidth * 0.055,
              backgroundColor: kGrey.withOpacity(0.2),
              child: IconButton(
                  onPressed: () {}, icon: const Icon(CupertinoIcons.bag)),
            ),
          )
        ],
      ),
      drawer: Drawer(
        backgroundColor: kGrey200,
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                  // color: kGrey,
                  ),
              child: CircleAvatar(
                radius: 20,
                child: Icon(
                  Icons.person,
                  size: 80,
                ),
              ),
            ),
            ListTile(
              title: const Text("Logout"),
              trailing: IconButton(
                  onPressed: () {
                    FireBaseAuthMethods(FirebaseAuth.instance).signOut(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.logout)),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: kHeight * .1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  HomeTwoImage(
                    anOntap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BrandDetails(),
                        ),
                      );
                    },
                    kHeight: kHeight * 0.25,
                    kWidth: kWidth * .4,
                    imageName: "assets/yonex.png",
                    quoteText: "Never give up",
                    titleText: "yonex",
                    theTitle: "brands",
                  ),
                  HomeTwoImage(
                    anOntap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ProductDetails(),
                        ),
                      );
                    },
                    kHeight: kHeight * 0.25,
                    kWidth: kWidth * .4,
                    imageName: "assets/landing_pic_2.png",
                    quoteText: "runner boost",
                    titleText: "air max",
                    theTitle: "products",
                  )
                ],
              ),
              SizedBox(
                height: kHeight * 0.05,
              ),
              Row(
                children: [
                  Text(
                    "Manage Order's",
                    style: kTitleText,
                  ),
                ],
              ),
              SizedBox(height: kHeight * 0.02),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => OrderUsers(),
                  ));
                },
                child: Container(
                  height: kHeight * .12,
                  decoration: BoxDecoration(
                    color: kWhite.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                  ),
                  child: SizedBox(
                    height: kWidth,
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
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}

class HomeTwoImage extends StatelessWidget {
  const HomeTwoImage({
    super.key,
    required this.kHeight,
    required this.kWidth,
    required this.imageName,
    required this.quoteText,
    required this.titleText,
    required this.theTitle,
    required this.anOntap,
  });

  final double kHeight;
  final double kWidth;
  final String imageName;
  final String quoteText;
  final String titleText;
  final String theTitle;
  final VoidCallback anOntap;

  @override
  Widget build(BuildContext context) {
    final kHeight = MediaQuery.of(context).size.height;
    final kWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      child: Column(
        children: [
          Text(theTitle.toUpperCase(), style: kSubTitleText),
          SizedBox(
            height: kHeight * 0.02,
          ),
          GestureDetector(
            onTap: anOntap,
            child: Container(
              height: kHeight * .25,
              width: kWidth * .4,
              decoration: BoxDecoration(
                color: kWhite.withOpacity(0.5),
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: kHeight * .17,
                      width: kWidth * .4,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              imageName,
                            ),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Text(quoteText.toUpperCase(), style: kitalicText),
                    Text(titleText.toUpperCase(), style: kSubTitleText),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
