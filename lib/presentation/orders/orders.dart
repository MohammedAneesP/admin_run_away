import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:run_away_admin/application/orders/ordered_user_view/order_viewing_bloc.dart';
import 'package:run_away_admin/core/color_constants.dart';
import 'package:run_away_admin/core/constants/constants.dart';
import 'package:run_away_admin/presentation/home_page/admin_home.dart';
import 'package:run_away_admin/presentation/orders/ordered_products/an_user_products.dart';

class OrderUsers extends StatelessWidget {
  const OrderUsers({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<OrderViewingBloc>(context).add(OrderViewing());
    });
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Orders",
          style: kTitleText,
        ),
        shadowColor: kWhite.withOpacity(0),
        backgroundColor: kWhite.withOpacity(0),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const AdminHome(),
                ));
          },
          icon: const Icon(
            CupertinoIcons.back,
            color: kBlack,
          ),
        ),
      ),
      body: BlocBuilder<OrderViewingBloc, OrderViewingState>(
        builder: (context, state) {
          if (state.orders.isEmpty) {
            return const Center(
              child:CircularProgressIndicator()
            );
          } else {
            return ListView.separated(
              itemBuilder: (context, index) {
                final anOrder = state.orders[index];
                int quantity = 0;
                Map<String, dynamic> products = anOrder["products"];
                products.forEach((key, value) {
                  quantity = quantity + int.parse(products[key]["count"]);
                });
                final dateAndTime = anOrder["documentId"].toString();
                final forDateAndTime = dateAndTime.split(" ");
                final anDate = forDateAndTime[0];
                final anTime = forDateAndTime[1].substring(0, 5);

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 120,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AnUserProducts(
                                anDocumentId: anOrder.id.toString()),
                          ),
                        );
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                blurStyle: BlurStyle.outer,
                                color: kGrey,
                              )
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 120,
                              height: 110,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: kGrey200,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15))),
                                child: const Icon(
                                  Icons.shopping_cart,
                                  size: 90,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 250,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Ordered in $anDate",
                                      style: kSubTitleText),
                                  Text("Time -  $anTime", style: kSubTitleText),
                                  Text(
                                    "No. of Products $quantity",
                                    style: kSubTitleText,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(
                color: kTransparent,
              ),
              itemCount: state.orders.length,
            );
          }
        },
      ),
    );
  }
}
