import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:run_away_admin/application/brands/brand_display_bloc/brand_displaying_bloc.dart';
import 'package:run_away_admin/application/brands/brand_image_bloc/brand_image_bloc.dart';
import 'package:run_away_admin/application/products/drop_down_bloc/drop_brand_bloc.dart';
import 'package:run_away_admin/application/products/product_image/product_image_bloc.dart';
import 'package:run_away_admin/presentation/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'application/brands/edit_brand_bloc/edit_brand_details_bloc.dart';
import 'application/orders/order_status-update/status_updating_bloc.dart';
import 'application/orders/order_status_drop/order_status_drop_bloc.dart';
import 'application/orders/ordered_product/ordered_product_bloc.dart';
import 'application/orders/ordered_user_view/order_viewing_bloc.dart';
import 'application/orders/products_an_user_ordered/product_orderd_an_user_bloc.dart';
import 'application/products/pro_edit_image/product_edit_image_bloc.dart';
import 'application/products/product_display_bloc/product_display_bloc.dart';
import 'application/products/product_edit_bloc/product_edit_bloc.dart';

int? isViewed;
Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
  SharedPreferences pref = await SharedPreferences.getInstance();

  isViewed = pref.getInt("OnBoard");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BrandImageBloc()),
        BlocProvider(create: (context) => EditBrandDetailsBloc()),
        BlocProvider(create: (context) => BrandDisplayingBloc()),
        BlocProvider(create: (context) => ProductImageBloc()),
        BlocProvider(create: (context) => DropBrandBloc()),
        BlocProvider(create: (context) => ProductEditBloc()),
        BlocProvider(create: (context) => ProductEditImageBloc()),
        BlocProvider(create: (context) => ProductDisplayBloc()),
        BlocProvider(create: (context) => OrderViewingBloc()),
        BlocProvider(create: (context) => ProductOrderdAnUserBloc()),
        BlocProvider(create: (context) => OrderedProductBloc()),
        BlocProvider(create: (context) => OrderStatusDropBloc()),
        BlocProvider(create: (context) => StatusUpdatingBloc()),
      ],
      child: MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
