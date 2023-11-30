import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:run_away_admin/application/orders/order_status-update/status_updating_bloc.dart';
import 'package:run_away_admin/application/orders/order_status_drop/order_status_drop_bloc.dart';
import 'package:run_away_admin/application/orders/ordered_product/ordered_product_bloc.dart';
import 'package:run_away_admin/application/orders/products_an_user_ordered/product_orderd_an_user_bloc.dart';
import 'package:run_away_admin/core/color_constants.dart';
import 'package:run_away_admin/core/constants/constants.dart';
import 'package:run_away_admin/presentation/orders/orders.dart';

String selectedStatus = "Order Placed";

class OneProductDetailed extends StatelessWidget {
  final String anOrderKey;
  final String anProductId;
  OneProductDetailed(
      {super.key, required this.anOrderKey, required this.anProductId});

  List<String> statuses = [
    "Order Placed",
    "Shipped",
    "Ready to Deliver",
    "Delivered",
    "Cancelled"
  ];

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<OrderedProductBloc>(context).add(
          AnSingleOrder(anOrderDocId: anOrderKey, anProductId: anProductId));
    });

    final kHeight = MediaQuery.sizeOf(context);
    return BlocBuilder<OrderedProductBloc, OrderedProductState>(
      builder: (context, state) {
        if (state.anProduct.isEmpty) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          final anOrder = state.anOrder;
          final anProduct = state.anProduct;
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: kHeight.height * 0.35,
                      decoration: BoxDecoration(
                        color: kGrey200,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        image: DecorationImage(
                            image: NetworkImage(anProduct["productImages"][0]),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Text("Product Name : ${anProduct["itemName"]}",
                        style: kHeadingText, overflow: TextOverflow.ellipsis),
                    Text("Product Price : ${anProduct["price"]}",
                        style: kHeadingText, overflow: TextOverflow.ellipsis),
                    Text(
                      "Size : ${anOrder["products"][anProductId]["size"]}",
                      style: kHeadingText,
                    ),
                    Text(
                        "Quantity : ${anOrder["products"][anProductId]["count"]}",
                        style: kHeadingText,
                        overflow: TextOverflow.ellipsis),
                    Text("Name : ${anOrder["address"]["name"]}",
                        style: kHeadingText, overflow: TextOverflow.ellipsis),
                    Text("Contact Number : ${anOrder["address"]["number"]}",
                        style: kHeadingText, overflow: TextOverflow.ellipsis),
                    Text("Address : ${anOrder["address"]["address"]}",
                        style: kHeadingText),
                    Text("Pincode : ${anOrder["address"]["pincode"]}",
                        style: kHeadingText),
                    Text("Place : ${anOrder["address"]["place"]}",
                        style: kHeadingText),
                    Text("Landmark :${anOrder["address"]["landmark"]}",
                        style: kHeadingText),
                    Row(
                      children: [
                        Text("Order Status : ", style: kHeadingText),
                        BlocBuilder<OrderStatusDropBloc, OrderStatusDropState>(
                          builder: (context, state) {
                            return DropdownButton<String>(
                              hint: Text(anOrder["products"][anProductId]
                                      ["status"]
                                  .toString()),
                              value: selectedStatus,
                              items: statuses.map((String item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                BlocProvider.of<OrderStatusDropBloc>(context)
                                    .add(StatusChanging(
                                        anStatus: newValue.toString()));
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: kHeight.height * 0.02,
                    ),
                    Center(
                      child: ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(kBlue),
                              fixedSize:
                                  MaterialStatePropertyAll(Size(250, 60))),
                          onPressed: () async {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            );
                            await Future.delayed(const Duration(seconds: 1));
                            if (context.mounted) {
                              BlocProvider.of<StatusUpdatingBloc>(context).add(
                                  UpdatingStatus(
                                      anOrderId: anOrderKey,
                                      anProductid: anProductId,
                                      anStatus: selectedStatus));
                              BlocProvider.of<ProductOrderdAnUserBloc>(context)
                                  .add(OrdersByAnUser(anDocmentId: anOrderKey));
                              BlocProvider.of<OrderedProductBloc>(context)
                                  .add(ResetOrder());

                              Navigator.pop(context);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const OrderUsers(),
                                  ));
                              anSnackBarFunc(
                                  context: context,
                                  aText: "Status Updated",
                                  anColor: kBlue);
                            }
                          },
                          child: Text(
                            "Submit Changes",
                            style: buttontextWhite,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
