import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:run_away_admin/presentation/home_page/admin_home.dart';
import 'application/brand_image_bloc/brand_image_bloc.dart';
import 'application/drop_down_bloc/drop_brand_bloc.dart';
import 'application/edit_brand_bloc/edit_brand_details_bloc.dart';
import 'application/pro_edit_image/product_edit_image_bloc.dart';
import 'application/product_display_bloc/product_display_bloc.dart';
import 'application/product_edit_bloc/product_edit_bloc.dart';
import 'application/product_image/product_image_bloc.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BrandImageBloc(),
        ),
        BlocProvider(
          create: (context) => EditBrandDetailsBloc(),
        ),
        BlocProvider(
          create: (context) => ProductImageBloc(),
        ),
        BlocProvider(
          create: (context) => DropBrandBloc(),
        ),
        BlocProvider(
          create: (context) => ProductEditBloc(),
        ),
        BlocProvider(
          create: (context) => ProductEditImageBloc(),
        ),
        BlocProvider(
          create: (context) => ProductDisplayBloc(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: const AdminHome(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
