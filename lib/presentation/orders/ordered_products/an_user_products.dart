import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:run_away_admin/application/orders/ordered_product/ordered_product_bloc.dart';
import 'package:run_away_admin/application/orders/products_an_user_ordered/product_orderd_an_user_bloc.dart';
import 'package:run_away_admin/core/color_constants.dart';
import 'package:run_away_admin/core/constants/constants.dart';
import 'package:run_away_admin/presentation/orders/ordered_products/an_product_details.dart';
import 'package:run_away_admin/presentation/orders/orders.dart';

class AnUserProducts extends StatelessWidget {
  final String anDocumentId;
  const AnUserProducts({super.key, required this.anDocumentId});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<OrderedProductBloc>(context).add(ResetOrder());
      BlocProvider.of<ProductOrderdAnUserBloc>(context)
          .add(OrdersByAnUser(anDocmentId: anDocumentId));
    });

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Ordered Products",
          style: kTitleText,
        ),
        shadowColor: kWhite.withOpacity(0),
        backgroundColor: kWhite.withOpacity(0),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const OrderUsers(),
                ));
          },
          icon: const Icon(
            CupertinoIcons.back,
            color: kBlack,
          ),
        ),
      ),
      body: BlocBuilder<ProductOrderdAnUserBloc, ProductOrderdAnUserState>(
        builder: (context, state) {
          if (state.thisUsersProducts.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.separated(
                itemBuilder: (context, index) {
                  final orders = state.thisUsersProducts;
                  String anTime = orders["documentId"].toString();
                  final dateAndTime = anTime.split(" ");
                  final anDate = dateAndTime[0];

                  final anProduct = state.products[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        BlocProvider.of<OrderedProductBloc>(context)
                            .add(ResetOrder());
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => OneProductDetailed(
                              anOrderKey: anTime,
                              anProductId: anProduct["productId"]),
                        ));
                      },
                      child: Container(
                        height: 100,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5,
                                blurStyle: BlurStyle.outer,
                                color: kGrey,
                              )
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 100,
                              height: 80,
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            anProduct["productImages"][0])),
                                    color: kGrey200,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15))),
                              ),
                            ),
                            SizedBox(
                              width: 220,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Orederd in - $anDate",
                                      style: kSubTitleText),
                                  Text(
                                      "Quantity -  ${orders["products"][anProduct["productId"]]["count"]}",
                                      style: kSubTitleText),
                                  Text(
                                      "Status -  ${orders["products"][anProduct["productId"]]["status"]}",
                                      style: kSubTitleText),
                                ],
                              ),
                            ),
                            PopupMenuButton(
                              icon: const Icon(Icons.more_vert),
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                      child: TextButton(
                                          onPressed: () {},
                                          child: const Text("Remove Order")))
                                ];
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                      height: 20,
                      color: kTransparent,
                    ),
                itemCount: state.products.length);
          }
        },
      ),
    );
  }
}
